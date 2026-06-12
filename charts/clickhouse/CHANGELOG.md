# Changelog

## [0.1.0]

### Added

- Initial release of the standalone ClickHouse Helm chart
- StatefulSet deployment using official `clickhouse/clickhouse-server` image
- Configurable `config.xml` and `users.xml` via ConfigMaps
- Persistent storage via PVC with configurable size and storage class
- HTTP (8123) and TCP/native (9000) service ports
- Headless service for StatefulSet DNS
- Optional Prometheus metrics sidecar with ServiceMonitor support
- Optional Ingress and Gateway API HTTPRoute resources
- Optional ServiceAccount creation
- Liveness, readiness, and startup probes via ClickHouse `/ping` endpoint
- Support for init SQL scripts via ConfigMap
- `extraObjects`, `extraEnvVars`, `extraVolumes`, `extraVolumeMounts` escape hatches
- Auto-generated credentials secret with connection URI
- Pod and container security context defaults
- `persistentVolumeClaimRetentionPolicy` support
