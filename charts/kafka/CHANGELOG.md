# Changelog

All notable changes to this chart will be documented in this file.

## [0.1.0] - 2026-05-29

Initial release. Deploys Apache Kafka 4.2.1 in KRaft mode (no ZooKeeper) using the official `apache/kafka` image, pinned by digest.

### Security

- SASL/PLAIN authentication on the client, inter-broker, and controller listeners (`auth.*`), enabled by default with auto-generated passwords stored in a Secret and preserved across upgrades. Supports bring-your-own credentials (`auth.existingSecret`) and per-listener toggles. Broker traffic uses separate `CLIENT` (9092), `INTERNAL` (9094), and `CONTROLLER` (9093) listeners; the internal port is exposed only on the headless Service.
- TLS on all listeners (`tls.enabled`): listeners become `SSL`, or `SASL_SSL` when the matching auth boundary is also enabled. Three certificate sources (`tls.source`): `self-signed` (chart-generated CA + cert, persisted across upgrades), `existing-secret` (bring your own PEM Secret), and `cert-manager` (PKCS#8 key). Optional mutual TLS via `tls.clientAuth`. The PEM keystore is assembled at runtime, compatible with the read-only root filesystem.
- Hardened pod defaults: runs as non-root with a read-only root filesystem, all capabilities dropped, seccomp `RuntimeDefault`, and `automountServiceAccountToken: false`. Works with hardened images (e.g. Docker Hardened Images); see the README for TLS cert-source guidance on minimal images.

### Observability

- Optional kafka-exporter Deployment and Prometheus `ServiceMonitor` (`metrics.*`), which authenticate over SASL and connect over TLS when those are enabled.

### Resilience & operations

- Quorum-aware PodDisruptionBudget, configurable persistence (PVC templates or existing claim), optional NetworkPolicy, console-only log4j2 logging, a startup probe sized for KRaft quorum formation, and `extraEnvVars` / `extraVolumes` / `extraObjects` escape hatches.
