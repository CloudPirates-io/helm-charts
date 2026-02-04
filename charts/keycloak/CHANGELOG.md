# Changelog

All notable changes to this chart will be documented in this file.

## [0.14.1] - 2026-02-04

- [mariadb] Update initContainers.waitForMariadb.repository to v12.1.2 (#957) ([7542e66](../../commit/7542e66))

## [0.14.0] - 2026-02-04

- [keycloak]: Align init container images with global registry, add resource configuration, and improve realm import handling (#946) ([4a70951](../../commit/4a70951))
- [all]: Update documentation to include proper cosign public key ([e42365d](../../commit/e42365d))

## [0.13.6] - 2026-01-30

- [keycloak]: Allow prepending arguments to keycloak (#925) ([c536f47](../../commit/c536f47))

## [0.13.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](../../commit/f8d134d))

## [0.13.4] - 2026-01-27

- [keycloak]: Allow empty database type string (#912) ([2244324](../../commit/2244324))

## [0.13.3] - 2026-01-27

- [keycloak]: Remove unused secret (#911) ([8371cd1](../../commit/8371cd1))

## [0.13.2] - 2026-01-26

- [keycloak]: Try to fix keycloak startup probe/s (#900) ([1cd74cb](../../commit/1cd74cb))

## [0.13.1] - 2026-01-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.2 (patch) (#892) ([3899ff2](../../commit/3899ff2))

## [0.13.0] - 2026-01-19

- [keycloak]: Add simultaneous support for http and https (#863) ([bb671a5](../../commit/bb671a5))

## [0.12.0] - 2026-01-19

- [keycloak]: Move to stateful set (#859) ([76ed920](../../commit/76ed920))

## [0.11.5] - 2026-01-19

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.1 (patch) (#860) ([8b8713d](../../commit/8b8713d))

## [0.11.4] - 2026-01-08

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.0 (minor) (#823) ([7e1eb1c](../../commit/7e1eb1c))

## [0.11.3] - 2025-12-04

- Apply preserveThemes and preserveProviders to the deployment for volume mounts (#689) ([58d54a8](../../commit/58d54a8))

## [0.11.2] - 2025-12-01

- quote dnsnames for certificates (#678) ([1dde1f7](../../commit/1dde1f7))

## [0.11.1] - 2025-12-01

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.7 (patch) (#664) ([3224ae7](../../commit/3224ae7))

## [0.11.0] - 2025-11-26

- Fix/allow realm import on production mode (#668) ([be3939e](../../commit/be3939e))

## [0.10.2] - 2025-11-26

- Use correct metrics path if httpRelativePath is set (#666) ([87276ae](../../commit/87276ae))

## [0.10.1] - 2025-11-26

- Preserve themes and providers options (#660) ([1bf70b4](../../commit/1bf70b4))

## [0.10.0] - 2025-11-25

- Add support for PriorityClass (#651) ([0aaf369](../../commit/0aaf369))

## [0.9.1] - 2025-11-24

- [Keycloak[ improve subchart variables (#652) ([e1c50c6](../../commit/e1c50c6))

## [0.9.0] - 2025-11-24

- Keycloak/subchart variables (#649) ([bb0520a](../../commit/bb0520a))

## [0.8.8] - 2025-11-24

- Fix JDBC connection string when using mssql database (#643) (#644) ([639db93](../../commit/639db93))
- fix: correct installation command in the  (#646) ([b88029b](../../commit/b88029b))

## [0.8.7] - 2025-11-22

- Make resources apply to initContainers (#645) ([35f4ac3](../../commit/35f4ac3))

## [0.8.6] - 2025-11-13

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.5 (patch) (#593) ([a4cfe0c](../../commit/a4cfe0c))

## [0.8.5] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](../../commit/e63f5f9))

## [0.8.4] - 2025-11-11

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.4 (patch) (#563) ([c65d420](../../commit/c65d420))

## [0.8.3] - 2025-11-11

- add truststoreExistingSecretKey, add truststorePassword to env-Vars (#574) ([9c97080](../../commit/9c97080))

## [0.8.2] - 2025-11-05

- [keycloak]: Fix mariadb configuration (#544) ([6cec40c](../../commit/6cec40c))

## [0.8.1] - 2025-11-02

- [keycloak]: Fix https settings in keycloak when disabling http (#530) ([b0c34f6](../../commit/b0c34f6))

## [0.8.0] - 2025-10-30

- Provide empty mounts for themes and providers (#504) ([4d2f107](../../commit/4d2f107))

## [0.7.1] - 2025-10-29

- fix: use metrics service targetPort configuration (#493) ([bd3cc53](../../commit/bd3cc53))

## [0.7.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](../../commit/4aee7b4))

## [0.6.8] - 2025-10-27

- add mssql support (#469) ([11cdbfb](../../commit/11cdbfb))

## [0.6.7] - 2025-10-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.2 (patch) (#453) ([52a01c8](../../commit/52a01c8))

## [0.6.6] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](../../commit/cdb38db))

## [0.6.5] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](../../commit/c2b2024))
- [universal] fix all appversions in charts (#417) ([b8debeb](../../commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](../../commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](../../commit/c24d26d))

## [0.6.4] - 2025-10-17

- realm import (#402) ([4257b8b](../../commit/4257b8b))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](../../commit/37f1c5b))

## [0.6.3] - 2025-10-17

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.1 (patch) (#400) ([c6f2ca2](../../commit/c6f2ca2))
- [universal] Rework all schema json (#393) ([79d1439](../../commit/79d1439))

## [0.6.2] - 2025-10-14

- Add support for templating hostname and hostnameAdmin (#390) ([133f4d5](../../commit/133f4d5))

## [0.6.1] - 2025-10-14

- [keycloak]: Implement TLS in keycloak (#373) ([04abaee](../../commit/04abaee))

## [0.6.0] - 2025-10-14

- [universal] All charts use cloudpirates prefix (#378) ([7485c19](../../commit/7485c19))

## [0.5.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](../../commit/bcc566c))

## [0.5.0] - 2025-10-13

- feat: add metrics (#368) ([cf5aba0](../../commit/cf5aba0))
- [universal]: Fix changelog generation (#354) ([2e973c0](../../commit/2e973c0))

## [0.4.0] - 2025-10-10

- Import realm (#219) ([f7ff0cf](../../commit/f7ff0cf))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](../../commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](../../commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](../../commit/c931978))
- [keycloak]: Fix invalid documentation (#283) ([59f3d3c](../../commit/59f3d3c))

## [0.3.2] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.0 (minor) (#270) ([b107e1b](../../commit/b107e1b))

## [0.3.1] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.3.5 (patch) (#261) ([360de40](../../commit/360de40))

## [0.3.0] - 2025-10-08

- make keycloak run on openshift (#225) ([9b4f896](../../commit/9b4f896))

## [0.2.1] - 2025-10-07

- default http relative path to '/' to fix argocd deployment (#221) ([bdb1946](../../commit/bdb1946))

## [0.2.0] - 2025-10-06

- Add support for extra volumes, volumeMounts and initContainers (#215) ([16afcfe](../../commit/16afcfe))

## [0.1.12] - 2025-10-06

- [mariadb] chore(deps): update mariadb:12.0.2 Docker digest to 03a03a6 (#208) ([01a6ad1](../../commit/01a6ad1))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](../../commit/c7c2f4c))

## [0.1.11] - 2025-10-06

- Allow keycloak to have a relative path (#216) ([0237457](../../commit/0237457))

## [0.1.10] - 2025-10-02

- [postgres] chore(deps): update postgres:17.6 Docker digest to e6a4209 (#173) ([beb0b40](../../commit/beb0b40))

## [0.1.9] - 2025-10-02

- add topologySpreadConstraints and trafficDistribution opti… (#209) ([c777fca](../../commit/c777fca))

## [0.1.8] - 2025-09-30

- Feature/command customize (#186) ([a458e15](../../commit/a458e15))

## [0.1.7] - 2025-09-29

- replace deprecated 'proxy' with new proxy parameters (#183) ([d850b7b](../../commit/d850b7b))

## [0.1.6] - 2025-09-26

- [postgres] chore(deps): update postgres:17.6 Docker digest to 0b6428e (#162) ([6293612](../../commit/6293612))

## [0.1.5] - 2025-09-25

- add support for extra env vars from an existing secret (#158) ([263604f](../../commit/263604f))
- Update CHANGELOG.md ([b7572a8](../../commit/b7572a8))
- Update CHANGELOG.md ([245f9b6](../../commit/245f9b6))
- Update CHANGELOG.md ([0bf9f75](../../commit/0bf9f75))

## [0.1.4] - 2025-09-24

- Update CHANGELOG.md ([03d476e](../../commit/03d476e))
- Bump the correct thing ([35e7901](../../commit/35e7901))
- [postgres] chore(deps): update postgres:17.6 Docker digest to 0f4f200 ([b4a6a30](../../commit/b4a6a30))
- Update CHANGELOG.md ([20c19bb](../../commit/20c19bb))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([68435aa](../../commit/68435aa))
- Fix resolving template expressions in extraobjects ([12a1cb5](../../commit/12a1cb5))

## [0.1.2] - 2025-09-22

- Update CHANGELOG.md ([b8adca8](../../commit/b8adca8))
- Fix chart version bump ([aae07b1](../../commit/aae07b1))
- Fix deprecated env vars warning ([50d9fa0](../../commit/50d9fa0))

## [0.1.1] - 2025-09-19

- Update CHANGELOG.md ([62e51b9](../../commit/62e51b9))
- add readme documentation and values.schema.json ([369448b](../../commit/369448b))
- Update CHANGELOG.md ([54f725e](../../commit/54f725e))
- Update CHANGELOG.md ([2ed9b3f](../../commit/2ed9b3f))
- Update CHANGELOG.md ([2178148](../../commit/2178148))

## [0.1.0] - 2025-09-17

- Initial release

