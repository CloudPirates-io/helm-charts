# Changelog

## 0.1.6 (2025-10-09)

* [zookeeper] Update charts/zookeeper/values.yaml zookeeper to v3.9.4 (patch) ([#267](https://github.com/CloudPirates-io/helm-charts/pull/267))

## <small>0.1.5 (2025-10-01)</small>

* Fix/allow zookeeper to scale to 0 replicas (#196) ([7403e9d](https://github.com/CloudPirates-io/helm-charts/commit/7403e9d)), closes [#196](https://github.com/CloudPirates-io/helm-charts/issues/196)
* trigger pipeline without version-upgrade (#191) ([819492c](https://github.com/CloudPirates-io/helm-charts/commit/819492c)), closes [#191](https://github.com/CloudPirates-io/helm-charts/issues/191)

## <small>0.1.4 (2025-09-30)</small>

* [Nginx] Change nginx and zookeeper security-context to use helper-function (#169) ([b581bc7](https://github.com/CloudPirates-io/helm-charts/commit/b581bc7)), closes [#169](https://github.com/CloudPirates-io/helm-charts/issues/169)

## <small>0.1.3 (2025-09-26)</small>

* #170 fix for command whitelist (#171) ([ebd91d8](https://github.com/CloudPirates-io/helm-charts/commit/ebd91d8)), closes [#171](https://github.com/CloudPirates-io/helm-charts/issues/171) [#170](https://github.com/CloudPirates-io/helm-charts/issues/170)

## <small>0.1.2 (2025-09-26)</small>

* [common] Fix/set securitycontext based on targetplatform to comply with openshift clusters (#166) ([f1bb75e](https://github.com/CloudPirates-io/helm-charts/commit/f1bb75e)), closes [#166](https://github.com/CloudPirates-io/helm-charts/issues/166)

## <small>0.1.1 (2025-09-25)</small>

*  Update ZooKeeper container ports and the client connection command dynamically based on values in t ([8d7bd25](https://github.com/CloudPirates-io/helm-charts/commit/8d7bd25))
* add networkpolicy and poddisruptionbudget (#2) (#155) ([2a84b43](https://github.com/CloudPirates-io/helm-charts/commit/2a84b43)), closes [#2](https://github.com/CloudPirates-io/helm-charts/issues/2) [#155](https://github.com/CloudPirates-io/helm-charts/issues/155) [#2](https://github.com/CloudPirates-io/helm-charts/issues/2)
* Add maintainer contact ([ebe7585](https://github.com/CloudPirates-io/helm-charts/commit/ebe7585))
* add missing configuration parameters ([a452902](https://github.com/CloudPirates-io/helm-charts/commit/a452902))
* add some comments, change values order ([47e540d](https://github.com/CloudPirates-io/helm-charts/commit/47e540d))
* add tests and fix minor template issues ([0bc5e9c](https://github.com/CloudPirates-io/helm-charts/commit/0bc5e9c))
* add zookeeper helm charts ([ae0a99c](https://github.com/CloudPirates-io/helm-charts/commit/ae0a99c))
* fix linting ([d82df91](https://github.com/CloudPirates-io/helm-charts/commit/d82df91))
* fix zookeeper config ([d71e20f](https://github.com/CloudPirates-io/helm-charts/commit/d71e20f))
* fixed to run as cluster ([f530292](https://github.com/CloudPirates-io/helm-charts/commit/f530292))
* make zookeeper config more flexible ([8b5c677](https://github.com/CloudPirates-io/helm-charts/commit/8b5c677))
* reload pods after config changes ([1f4e7b4](https://github.com/CloudPirates-io/helm-charts/commit/1f4e7b4))
* remove duplicate tests ([25e5ef6](https://github.com/CloudPirates-io/helm-charts/commit/25e5ef6))
* remove newlines to allign with other charts ([c64f6d5](https://github.com/CloudPirates-io/helm-charts/commit/c64f6d5))
* replace bitnami helm chart ([7017864](https://github.com/CloudPirates-io/helm-charts/commit/7017864))
* running zookeeper, made it more aligned to other charts ([602da71](https://github.com/CloudPirates-io/helm-charts/commit/602da71))
* update artefacthub ID ([4118db4](https://github.com/CloudPirates-io/helm-charts/commit/4118db4))
* update chart icon ([729958d](https://github.com/CloudPirates-io/helm-charts/commit/729958d))
* uprove docs, and align with other charts ([8c970a6](https://github.com/CloudPirates-io/helm-charts/commit/8c970a6))
* use sections for parameters table ([d0811cd](https://github.com/CloudPirates-io/helm-charts/commit/d0811cd))
* use service port in config ([3d06339](https://github.com/CloudPirates-io/helm-charts/commit/3d06339))
