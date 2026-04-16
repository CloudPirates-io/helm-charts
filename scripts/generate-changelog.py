#!/usr/bin/env python3
"""
Per-chart changelog generator for CloudPirates helm-charts monorepo.

Generates scoped CHANGELOG.md files for each chart by:
1. Detecting all charts in charts/
2. For each chart, finding commits that touched its directory
3. Grouping commits by chart version (detected from Chart.yaml changes)
4. Classifying commits using conventional commit patterns
5. Writing a scoped CHANGELOG.md in each chart directory

Adapted from https://github.com/ixxeL-DevOps/gha-templates/blob/main/changelog.py
"""

import os
import re
import sys
from datetime import datetime, timezone
from typing import Optional

import click
import yaml

try:
    import git
except ImportError:
    click.echo("ERROR: gitpython is required. Install with: pip install gitpython", err=True)
    sys.exit(1)

DEFAULT_GROUPS = [
    {
        "title": "💥 Breaking changes",
        "regexp": r"^.*?(feat|chore|fix)!(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "🚀 New Features",
        "regexp": r"^.*?feat(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "📦 Dependency updates",
        "regexp": r"^.*?(?:chore|build|ci)(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "⚠️ Security updates",
        "regexp": r"^.*?sec(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "🐛 Bug fixes",
        "regexp": r"^.*?(fix|refactor)(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "📚 Documentation updates",
        "regexp": r"^.*?docs(?:\(\w+\))?!?: .+$",
    },
    {
        "title": "🔄 Image updates",
        "regexp": r"^.*(?:Update image\.?\w*|update.*image).*$",
    },
]

NOISE_PATTERNS = [
    r"^chore: update CHANGELOG\.md",
    r"^Merge branch ",
    r"^chore: update CHANGELOG",
]


# ---------------------------------------------------------------------------
# Core logic
# ---------------------------------------------------------------------------

def discover_charts(repo_root: str) -> list[str]:
    """Find all chart directories under charts/."""
    charts_dir = os.path.join(repo_root, "charts")
    if not os.path.isdir(charts_dir):
        return []
    return sorted(
        d
        for d in os.listdir(charts_dir)
        if os.path.isfile(os.path.join(charts_dir, d, "Chart.yaml"))
    )


def get_chart_commits(repo: git.Repo, chart_path: str, max_commits: int = 500) -> list[git.Commit]:
    """Get all commits that touched a specific chart directory."""
    return list(repo.iter_commits(paths=chart_path, max_count=max_commits))


def get_version_at_commit(repo: git.Repo, commit: git.Commit, chart_yaml_path: str) -> Optional[str]:
    """Get the chart version from Chart.yaml at a specific commit."""
    try:
        blob = commit.tree / chart_yaml_path
        content = yaml.safe_load(blob.data_stream.read().decode("utf-8"))
        return content.get("version")
    except (KeyError, yaml.YAMLError, UnicodeDecodeError):
        return None


def group_commits_by_version(
    repo: git.Repo, commits: list[git.Commit], chart_name: str
) -> dict[str, list[git.Commit]]:
    """Group commits by the chart version they belong to.

    Walks commits chronologically (newest first). When the version in
    Chart.yaml changes between two consecutive commits, that marks a
    version boundary.
    """
    chart_yaml_path = f"charts/{chart_name}/Chart.yaml"
    versioned: dict[str, list[git.Commit]] = {}
    current_version = None

    for commit in commits:
        version = get_version_at_commit(repo, commit, chart_yaml_path)
        if version is None:
            continue
        if current_version is None:
            current_version = version
        if version != current_version:
            current_version = version
        versioned.setdefault(current_version, []).append(commit)

    return versioned


def is_noise_commit(message: str) -> bool:
    """Filter out automated/noise commits (changelog updates, merges)."""
    first_line = message.split("\n", 1)[0].strip()
    return any(re.match(p, first_line) for p in NOISE_PATTERNS)


def is_commit_relevant(commit: git.Commit, chart_name: str) -> bool:
    """Check if a commit has meaningful changes beyond just a version bump.

    A commit is considered irrelevant if:
    - It ONLY changes the version field in Chart.yaml
    - It is an automated noise commit (changelog update, merge)
    """
    if is_noise_commit(commit.message):
        return False

    chart_path = f"charts/{chart_name}/"
    chart_files_changed = []

    for parent in commit.parents:
        diff = parent.diff(commit)
        for d in diff:
            path = d.b_path or d.a_path
            if path and path.startswith(chart_path):
                chart_files_changed.append(path)

    if not chart_files_changed:
        return False

    if chart_files_changed == [f"charts/{chart_name}/Chart.yaml"]:
        return False

    return True


def classify_commit(message: str, groups: list[dict]) -> Optional[str]:
    """Classify a commit message into a group."""
    first_line = message.split("\n", 1)[0].strip()
    for group in groups:
        if group.get("regexp") and re.match(group["regexp"], first_line):
            return group["title"]
    return None


def format_author(name: str, email: str, repo_url: str) -> str:
    """Format author as a GitHub-linkable mention.

    Resolution order:
    1. GitHub noreply email → extract username → @username
    2. Bot accounts → @name[bot]
    3. No spaces in name → assume username → @username
    4. Fallback → link to GitHub commits by author email
    """
    # GitHub noreply pattern: username@users.noreply.github.com
    # or: 12345+username@users.noreply.github.com
    noreply_match = re.match(r"(?:\d+\+)?([^@]+)@users\.noreply\.github\.com", email)
    if noreply_match:
        return f"@{noreply_match.group(1)}"

    # Bot accounts (already formatted as username[bot])
    if "[bot]" in name:
        return f"@{name}"

    # No spaces = likely a username
    if " " not in name:
        return f"@{name}"

    # Fallback: link to commits by this author in the repo
    return f"[{name}]({repo_url}/commits?author={email})"


def format_commit_message(commit: git.Commit, repo_url: str) -> str:
    """Format a single commit as a markdown list item."""
    msg = commit.message.split("\n", 1)[0].strip()
    sha_short = commit.hexsha[:8]

    pr_match = re.search(r"\(#(\d+)\)", msg)
    if pr_match:
        pr_num = pr_match.group(1)
        msg = re.sub(
            r"\(#(\d+)\)",
            f"([#{pr_num}]({repo_url}/pull/{pr_num}))",
            msg,
        )

    author = format_author(commit.author.name, commit.author.email, repo_url)

    return f"- {msg} ([{sha_short}]({repo_url}/commit/{commit.hexsha})) — {author}"


def generate_chart_changelog(
    repo: git.Repo,
    chart_name: str,
    repo_url: str,
    groups: list[dict],
    max_versions: int = 20,
    max_commits: int = 500,
) -> str:
    """Generate a scoped CHANGELOG.md content for a single chart."""
    chart_path = f"charts/{chart_name}"
    commits = get_chart_commits(repo, chart_path, max_commits)

    if not commits:
        return f"# Changelog — {chart_name}\n\nNo changes recorded.\n"

    versioned = group_commits_by_version(repo, commits, chart_name)

    markdown = f"# Changelog — {chart_name}\n\n"
    markdown += "All notable changes to this chart will be documented in this file.\n"
    markdown += "Only commits that directly affect this chart are listed.\n\n"

    version_count = 0
    for version, version_commits in versioned.items():
        if version_count >= max_versions:
            break

        relevant_commits = [c for c in version_commits if is_commit_relevant(c, chart_name)]

        if not relevant_commits and not version_commits:
            continue

        date = datetime.fromtimestamp(
            version_commits[0].committed_date, tz=timezone.utc
        ).strftime("%Y-%m-%d")

        markdown += f"## [{chart_name}-{version}] - {date}\n\n"

        if not relevant_commits:
            markdown += "_Version bump only — no user-facing changes._\n\n"
            version_count += 1
            continue

        classified: dict[str, list[git.Commit]] = {g["title"]: [] for g in groups}
        classified["🧰 Other work"] = []

        for commit in relevant_commits:
            group_title = classify_commit(commit.message, groups)
            if group_title:
                classified[group_title].append(commit)
            else:
                classified["🧰 Other work"].append(commit)

        for title, group_commits in classified.items():
            if group_commits:
                markdown += f"### {title}\n\n"
                for commit in group_commits:
                    markdown += format_commit_message(commit, repo_url) + "\n"
                markdown += "\n"

        version_count += 1

    return markdown


def generate_release_notes(
    repo: git.Repo,
    chart_name: str,
    repo_url: str,
    groups: list[dict],
    max_commits: int = 500,
) -> tuple[str, str]:
    """Generate release notes for the latest version of a chart.

    Returns (version, markdown) tuple. The markdown is suitable for
    injection into a GitHub Release body.
    """
    chart_path = f"charts/{chart_name}"
    commits = get_chart_commits(repo, chart_path, max_commits)

    if not commits:
        return ("unknown", "No changes recorded.")

    versioned = group_commits_by_version(repo, commits, chart_name)

    if not versioned:
        return ("unknown", "No versioned changes found.")

    version = next(iter(versioned))
    version_commits = versioned[version]
    relevant_commits = [c for c in version_commits if is_commit_relevant(c, chart_name)]

    if not relevant_commits:
        return (version, "_Version bump only — no user-facing changes._")

    markdown = ""
    classified: dict[str, list[git.Commit]] = {g["title"]: [] for g in groups}
    classified["🧰 Other work"] = []

    for commit in relevant_commits:
        group_title = classify_commit(commit.message, groups)
        if group_title:
            classified[group_title].append(commit)
        else:
            classified["🧰 Other work"].append(commit)

    for title, group_commits in classified.items():
        if group_commits:
            markdown += f"## {title}\n\n"
            for commit in group_commits:
                markdown += format_commit_message(commit, repo_url) + "\n"
            markdown += "\n"

    return (version, markdown.strip())


def load_config(config_path: str) -> dict:
    """Load optional YAML config file."""
    if os.path.isfile(config_path):
        with open(config_path, "r") as f:
            return yaml.safe_load(f) or {}
    return {}


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

@click.group(invoke_without_command=True)
@click.pass_context
def cli(ctx: click.Context) -> None:
    """Per-chart changelog generator for Helm monorepos."""
    if ctx.invoked_subcommand is None:
        click.echo(ctx.get_help())


@cli.command()
@click.option("--repo-url", default="https://github.com/CloudPirates-io/helm-charts", show_default=True, help="GitHub repository URL.")
@click.option("--charts", "-c", multiple=True, help="Specific chart(s) to process. Repeat for multiple. Default: all.")
@click.option("--max-versions", default=20, show_default=True, type=int, help="Maximum versions per chart.")
@click.option("--max-commits", default=500, show_default=True, type=int, help="Maximum commits to scan per chart.")
@click.option("--config", "config_path", default=".changelog-config.yml", show_default=True, help="Path to optional YAML config file.")
@click.option("--dry-run", is_flag=True, help="Print to stdout instead of writing files.")
def generate(
    repo_url: str,
    charts: tuple[str, ...],
    max_versions: int,
    max_commits: int,
    config_path: str,
    dry_run: bool,
) -> None:
    """Generate scoped CHANGELOG.md for each chart."""
    repo_root = os.getcwd()
    repo = git.Repo(repo_root)

    config = load_config(config_path)
    groups = config.get("groups", DEFAULT_GROUPS)

    chart_list = list(charts) or discover_charts(repo_root)

    if not chart_list:
        raise click.ClickException("No charts found in charts/ directory")

    click.echo(f"Processing {len(chart_list)} chart(s): {', '.join(chart_list)}")

    for chart_name in chart_list:
        chart_dir = os.path.join(repo_root, "charts", chart_name)
        if not os.path.isdir(chart_dir):
            click.secho(f"  SKIP {chart_name} — directory not found", fg="yellow")
            continue

        click.echo(f"\n{'='*60}")
        click.secho(f"  Generating changelog for: {chart_name}", fg="cyan", bold=True)
        click.echo(f"{'='*60}")

        changelog = generate_chart_changelog(
            repo=repo,
            chart_name=chart_name,
            repo_url=repo_url,
            groups=groups,
            max_versions=max_versions,
            max_commits=max_commits,
        )

        if dry_run:
            click.echo(changelog)
        else:
            output_path = os.path.join(chart_dir, "CHANGELOG.md")
            with open(output_path, "w") as f:
                f.write(changelog)
            click.secho(f"  ✓ Wrote {output_path}", fg="green")

    click.echo("\nDone.")


@cli.command("list")
def list_charts() -> None:
    """List all discovered charts."""
    repo_root = os.getcwd()
    charts = discover_charts(repo_root)

    if not charts:
        raise click.ClickException("No charts found in charts/ directory")

    click.echo(f"Found {len(charts)} chart(s):\n")
    for chart in charts:
        chart_yaml = os.path.join(repo_root, "charts", chart, "Chart.yaml")
        with open(chart_yaml) as f:
            data = yaml.safe_load(f)
        version = data.get("version", "?")
        click.echo(f"  {chart:<30} v{version}")


@cli.command()
@click.argument("chart_name")
@click.option("--max-commits", default=100, show_default=True, type=int, help="Maximum commits to scan.")
def inspect(chart_name: str, max_commits: int) -> None:
    """Show recent commits for a specific chart (debug helper)."""
    repo_root = os.getcwd()
    repo = git.Repo(repo_root)
    chart_path = f"charts/{chart_name}"

    if not os.path.isdir(os.path.join(repo_root, chart_path)):
        raise click.ClickException(f"Chart not found: {chart_name}")

    commits = get_chart_commits(repo, chart_path, max_commits)
    chart_yaml_path = f"charts/{chart_name}/Chart.yaml"

    click.echo(f"Last {len(commits)} commits touching {chart_path}/:\n")
    for commit in commits[:30]:
        version = get_version_at_commit(repo, commit, chart_yaml_path) or "?"
        msg = commit.message.split("\n", 1)[0].strip()[:80]
        relevant = "✓" if is_commit_relevant(commit, chart_name) else "✗"
        noise = " (noise)" if is_noise_commit(commit.message) else ""
        sha = commit.hexsha[:8]
        click.echo(f"  [{relevant}] {sha}  v{version:<10}  {msg}{noise}")


@cli.command("release-notes")
@click.argument("chart_name")
@click.option("--repo-url", default="https://github.com/CloudPirates-io/helm-charts", show_default=True, help="GitHub repository URL.")
@click.option("--max-commits", default=500, show_default=True, type=int, help="Maximum commits to scan.")
@click.option("--config", "config_path", default=".changelog-config.yml", show_default=True, help="Path to optional YAML config file.")
@click.option("--output-file", "-o", type=click.Path(), default=None, help="Write to file instead of stdout.")
def release_notes(
    chart_name: str,
    repo_url: str,
    max_commits: int,
    config_path: str,
    output_file: Optional[str],
) -> None:
    """Generate release notes for the latest version of a chart.

    Outputs markdown suitable for a GitHub Release body.
    Use with: gh release create <tag> --notes-file <file>
    """
    repo_root = os.getcwd()
    repo = git.Repo(repo_root)
    chart_dir = os.path.join(repo_root, "charts", chart_name)

    if not os.path.isdir(chart_dir):
        raise click.ClickException(f"Chart not found: {chart_name}")

    config = load_config(config_path)
    groups = config.get("groups", DEFAULT_GROUPS)

    version, markdown = generate_release_notes(
        repo=repo,
        chart_name=chart_name,
        repo_url=repo_url,
        groups=groups,
        max_commits=max_commits,
    )

    if output_file:
        with open(output_file, "w") as f:
            f.write(markdown)
        click.secho(f"Release notes for {chart_name}-{version} written to {output_file}", fg="green")
    else:
        click.echo(markdown)


if __name__ == "__main__":
    cli()
