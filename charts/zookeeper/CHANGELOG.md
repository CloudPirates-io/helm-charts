# Changelog

All notable changes to this chart will be documented in this file.

## [0.5.4] - 2026-02-01

- Use latest common version (#934) ([b7f36a2](../../commit/b7f36a2))
- [all]: Update every chart to newest common (#920) ([f8d134d](../../commit/f8d134d))

## [0.5.3] - 2026-01-28

- Add support for overriding selector labels (#915) ([a2cd851](../../commit/a2cd851))

## [0.5.2] - 2026-01-19

- Update charts/zookeeper/values.yaml zookeeper (#858) ([7dceb5c](../../commit/7dceb5c))

## [0.5.1] - 2026-01-08

- [zookeeper]: fix NetPol and PDB to use correct selectorLabels template (#802) ([7e578e3](../../commit/7e578e3))

## [0.5.0] - 2026-01-05

- [zookeeper]: add ServiceMonitor (#792) ([3831796](../../commit/3831796))

## [0.4.1] - 2026-01-01

- [zookeeper]: fix typos and set automountServiceAccountToken to false (#789) ([343fb3d](../../commit/343fb3d))

## [0.3.10] - 2025-12-23

- Final fix for supporting migration from bitnami zookeeper (#778) ([474ab06](../../commit/474ab06))

## [0.3.9] - 2025-12-23

- fix(zookeeper): add apiVersion and kind to volumeClaimTemplates to prevent OutOfSync on Server-Side-Apply with ArgoCD (#777) ([6800e29](../../commit/6800e29))

## [0.3.8] - 2025-12-21

- Add support for Bitnami Zookeeper migration with multiple replicas (#768) ([65c0764](../../commit/65c0764))

## [0.3.7] - 2025-12-17

- Add dataDir option to override path to data folder (#763) ([092def6](../../commit/092def6))

## [0.3.6] - 2025-12-11

- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba](../../commit/ac9e1ba))

## [0.3.5] - 2025-12-06

- Update zookeeper statefulset to use existing peristent volume claim if set (#698) ([1bf1992](../../commit/1bf1992))

## [0.3.4] - 2025-12-04

- fix network policy switch (#690) ([f7b8ae2](../../commit/f7b8ae2))

## [0.3.3] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](../../commit/87624a5))
- Update charts/zookeeper/values.yaml zookeeper (#604) ([2586190](../../commit/2586190))

## [0.3.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](../../commit/e63f5f9))

## [0.3.1] - 2025-11-12

- Update charts/zookeeper/values.yaml zookeeper (#590) ([ac259f3](../../commit/ac259f3))
- [etcd, rabbitmq, redis, zookeeper] add signature verification documentation to readme (#476) ([91c7310](../../commit/91c7310))

## [0.3.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](../../commit/4aee7b4))

## [0.2.1] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](../../commit/cdb38db))
- [universal] fix all appversions in charts (#417) ([b8debeb](../../commit/b8debeb))
- [universal] use a string instead of a boolean (#413) ([c24d26d](../../commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](../../commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](../../commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](../../commit/b7a63ee))

## [0.2.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](../../commit/87acfb1))

## [0.1.7] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](../../commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](../../commit/2e973c0))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](../../commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](../../commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](../../commit/c931978))

## [0.1.6] - 2025-10-09

- Update charts/zookeeper/values.yaml zookeeper to v3.9.4 (patch) (#267) ([df3b9e3](../../commit/df3b9e3))

## [0.1.5] - 2025-10-01

- Fix/allow zookeeper to scale to 0 replicas (#196) ([7403e9d](../../commit/7403e9d))
- trigger pipeline without version-upgrade (#191) ([819492c](../../commit/819492c))

## [0.1.4] - 2025-09-30

- [Nginx] Change nginx and zookeeper security-context to use helper-function (#169) ([b581bc7](../../commit/b581bc7))

## [0.1.3] - 2025-09-26

- #170 fix for command whitelist (#171) ([ebd91d8](../../commit/ebd91d8))

## [0.1.2] - 2025-09-26

- [common] Fix/set securitycontext based on targetplatform to comply with openshift clusters (#166) ([f1bb75e](../../commit/f1bb75e))

## [0.1.1] - 2025-09-25

- add networkpolicy and poddisruptionbudget (#2) (#155) ([2a84b43](../../commit/2a84b43))

## [0.1.0] - 2025-09-11

- Initial release

