# Changelog

All notable changes to this chart will be documented in this file.

## [0.3.0] - 2026-05-16

- [rabbitmq-cluster-operator] Move operator images to ghcr.io (rabbitmqoperator/* on Docker Hub is no longer published)
- [rabbitmq-cluster-operator] Bump cluster-operator to v2.21.0 and messaging-topology-operator to v1.19.2
- [rabbitmq-cluster-operator] Bump default-user-credential-updater to v1.0.14 and default RabbitMQ image to 4.2.6-management-alpine (matches cluster-operator v2.21.0 defaults)
- [rabbitmq-cluster-operator] Switch operator probes to upstream /healthz and /readyz on a dedicated health port (containerPorts.health, default 8081); required by messaging-topology-operator v1.19.0+
- [rabbitmq-cluster-operator] Messaging-topology-operator metrics now served over HTTPS on port 8443; PodMonitor / ServiceMonitor configured with scheme: https and insecureSkipVerify
- [rabbitmq-cluster-operator] Rename ValidatingWebhookConfiguration webhook entries to upstream v1.19 names (e.g. vbinding-v1beta1.kb.io)
- [rabbitmq-cluster-operator] Align messaging-topology-operator RBAC with upstream v1.19.1's events fix ([rabbitmq/messaging-topology-operator#1145](https://github.com/rabbitmq/messaging-topology-operator/pull/1145)): replace the legacy core API events rule on the ClusterRole with the `events.k8s.io` group, and add the `patch` verb on the namespaced Role's events rule
- [rabbitmq-cluster-operator] Refresh CRDs from upstream cluster-operator v2.21.0 and messaging-topology-operator v1.19.2

## [0.2.2] - 2026-03-27

- Update CRDs and remove ALPHA tag (#1191) ([3aa66d70](https://github.com/CloudPirates-io/helm-charts/commit/3aa66d70))

## [0.2.1] - 2026-02-24

- rabbitmq-cluster-operator: Fix template error when namespaced watch is defined. (#1052) ([7d12ccb6](https://github.com/CloudPirates-io/helm-charts/commit/7d12ccb6))

## [0.2.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.1.7] - 2026-02-12

- [rabbitmqoperator/messaging-topology-operator] Update image to v1.18.3 (#981) ([60ee56c7](https://github.com/CloudPirates-io/helm-charts/commit/60ee56c7))

## [0.1.6] - 2026-02-12

- [rabbitmqoperator/cluster-operator] Update image to v2.19.1 (#982) ([6cca1d5e](https://github.com/CloudPirates-io/helm-charts/commit/6cca1d5e))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.1.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.1.4] - 2026-01-19

- update to latest version (#852) ([373255fc](https://github.com/CloudPirates-io/helm-charts/commit/373255fc))

## [0.1.3] - 2026-01-09

- Add issuer and extra-list templates that were missing (#825) ([219ab178](https://github.com/CloudPirates-io/helm-charts/commit/219ab178))

## [0.1.2] - 2026-01-05

- Fix securityContext rendering for operators (#793) ([c513db8a](https://github.com/CloudPirates-io/helm-charts/commit/c513db8a))

## [0.1.1] - 2025-12-16

- update to latest version and fix schema issues (#752) ([7f9f9d72](https://github.com/CloudPirates-io/helm-charts/commit/7f9f9d72))
- change file-ending of artifacthub-repo.yaml to .yml (#679) ([1d59052c](https://github.com/CloudPirates-io/helm-charts/commit/1d59052c))

## [0.1.0] - 2025-12-01

- Initial release

