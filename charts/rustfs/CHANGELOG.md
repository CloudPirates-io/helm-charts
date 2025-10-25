# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-10-21

### Added
- Initial release of RustFS Helm chart
- Support for RustFS deployment with S3-compatible API
- Configurable persistence for data, logs, and TLS certificates
- Health checks and probes configuration
- Ingress support for both API and console endpoints
- Comprehensive values.yaml with all configuration options
- Security context configuration with non-root user support
- Service account management
- Multi-volume persistence support
- CORS configuration support
- Environment variable configuration through ConfigMap
- Secret management for access and secret keys
- Complete documentation and examples

### Features
- **Container Image**: `rustfs/rustfs:latest`
- **Ports**: 
  - API: 9000
  - Console: 9001
- **Storage**: Configurable persistent volumes for data, logs, and TLS
- **Authentication**: Access key and secret key based authentication
- **Network**: Ingress support with optional TLS
- **Monitoring**: Health checks for both API and console endpoints
- **Security**: Non-root container execution and minimal capabilities