# Contributing to CloudPirates Helm Charts

Hi there! We are thrilled that you'd like to contribute to this project. It's people like you that make this collection of charts such a valuable resource for the Kubernetes community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Chart Development Standards](#chart-development-standards)
- [Testing](#testing)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples to demonstrate the steps**
- **Describe the behavior you observed and what behavior you expected**
- **Include details about your configuration and environment**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a step-by-step description of the suggested enhancement**
- **Provide specific examples to demonstrate the steps**
- **Describe the current behavior and explain which behavior you expected to see**
- **Explain why this enhancement would be useful**

### Types of Contributions We're Looking For

- **New Charts**: Production-ready Helm charts for popular open-source applications
- **Chart Improvements**: Bug fixes, feature additions, and security enhancements
- **Documentation**: Improvements to README files, values documentation, and examples
- **Testing**: Additional test coverage and test improvements

## Development Setup

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- [helm-unittest](https://github.com/helm-unittest/helm-unittest) plugin

### Setting Up Your Development Environment

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/helm-charts.git
   cd helm-charts
   ```

3. Install the helm-unittest plugin:
   ```bash
   helm plugin install https://github.com/helm-unittest/helm-unittest
   ```

## Contributing Guidelines

### Chart Development Standards

All charts in this repository must follow these standards:

#### Security First
- Implement read-only root filesystems where possible
- Drop unnecessary Linux capabilities
- Configure security contexts properly
- Never hardcode credentials

#### Production Ready
- Include comprehensive health checks (liveness, readiness, startup probes)
- Support resource requests and limits
- Provide persistent storage configurations
- Include health check endpoints

#### Highly Configurable
- Provide extensive `values.yaml` with detailed documentation
- Support existing secrets and ConfigMaps
- Offer flexible ingress configurations
- Allow service account customization
- Support common labels and annotations

### Chart Structure

Follow this standard structure for new charts:

```
charts/your-chart/
├── Chart.yaml
├── README.md
├── values.yaml
├── templates/
│   ├── NOTES.txt
│   ├── _helpers.tpl
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── ingress.yaml
│   ├── secret.yaml
│   ├── service.yaml
│   └── serviceaccount.yaml
└── tests/
    └── *_test.yaml
```

### Documentation Requirements

Each chart must include:

1. **Chart.yaml**: Complete metadata with proper versioning
2. **README.md**: Comprehensive documentation including:
   - Chart description and purpose
   - Prerequisites and requirements
   - Installation instructions
   - Configuration parameters table
   - Examples and common configurations
   - Troubleshooting section
3. **values.yaml**: Well-documented default values with inline comments

### Versioning

We follow [Semantic Versioning](https://semver.org/) for chart versions:

- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality in a backwards compatible manner
- **PATCH**: Backwards compatible bug fixes

## Testing

### Running Tests

All charts must include comprehensive tests. Run tests using:

```bash
# Test all charts
./test-all-charts.sh

# Test individual chart
helm dependency update charts/your-chart
helm unittest charts/your-chart
```

### Test Requirements

Your tests should cover:
- Template rendering with default values
- Template rendering with custom values
- Required value validation
- Common configuration scenarios
- Edge cases and error conditions

### Manual Testing

Before submitting, manually test your chart:

```bash
# Lint the chart
helm lint ./charts/your-chart

# Render templates locally
helm template test-release ./charts/your-chart -n test

# Install in a test cluster
helm install test-release ./charts/your-chart -n test

# Verify the deployment
kubectl get all -n test
```

## Pull Request Process

1. **Branch**: Create a feature branch from `main`
   ```bash
   git checkout -b feature/your-chart-improvement
   ```

2. **Development**: Make your changes following the guidelines above

3. **Testing**: Run all tests and ensure they pass
   ```bash
   ./test-all-charts.sh
   helm lint ./charts/your-chart
   ```

4. **Documentation**: Update documentation as needed

5. **Commit**: Use clear, descriptive commit messages
   ```bash
   git commit -m "[chart-name] Add support for custom annotations"
   ```

6. **Pull Request**: Create a PR with the following:
   - Clear title following the pattern: `[chart-name] Descriptive title`
   - Complete the PR template
   - Reference any related issues
   - Include screenshots/examples if relevant

### Pull Request Checklist

Before submitting your pull request, ensure:

- Chart version is bumped according to semver (not needed for README-only changes)
- Variables are documented in `values.yaml` and `README.md`
- All tests pass
- Chart passes `helm lint`
- Documentation is updated
- Changes are backwards compatible (or breaking changes are clearly documented)
