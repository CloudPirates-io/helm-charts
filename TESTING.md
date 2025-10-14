# Helm Charts Testing Guide

This repository includes comprehensive tests for all Helm charts to validate common parameters and image configuration.

## Prerequisites

You need to have the `helm-unittest` plugin installed:

```bash
helm plugin install https://github.com/helm-unittest/helm-unittest
```

## Running Tests

### Run All Chart Tests

Use the provided test runner script to run tests for all charts:

```bash
./test-charts.sh
```

This script will:

- Check if helm-unittest plugin is installed
- Update dependencies for each chart
- Run unit tests for all charts
- Provide a summary of results

### Run Tests for Individual Charts

You can also run tests for individual charts:

```bash
# Update dependencies first
helm dependency update charts/mongodb

# Run tests
helm unittest charts/mongodb
```
