# Changelog


## 0.5.2 (2026-01-19)

* Update charts/zookeeper/values.yaml zookeeper (#858) ([7dceb5c](https://github.com/CloudPirates-io/helm-charts/commit/7dceb5c))

## 0.5.1 (2026-01-08)

* chore: update CHANGELOG.md for merged changes ([f603113](https://github.com/CloudPirates-io/helm-charts/commit/f603113))
* chore: update CHANGELOG.md for merged changes ([9c34b5d](https://github.com/CloudPirates-io/helm-charts/commit/9c34b5d))
* [zookeeper]: fix NetPol and PDB to use correct selectorLabels template (#802) ([7e578e3](https://github.com/CloudPirates-io/helm-charts/commit/7e578e3))
* chore: update CHANGELOG.md for merged changes ([d3d8715](https://github.com/CloudPirates-io/helm-charts/commit/d3d8715))
* chore: auto-generate values.schema.json (#797) ([d9b4adf](https://github.com/CloudPirates-io/helm-charts/commit/d9b4adf))

## 0.5.0 (2026-01-05)

* chore: update CHANGELOG.md for merged changes ([4309c14](https://github.com/CloudPirates-io/helm-charts/commit/4309c14))
* chore: update CHANGELOG.md for merged changes ([78ae03c](https://github.com/CloudPirates-io/helm-charts/commit/78ae03c))
* [zookeeper]: add ServiceMonitor (#792) ([3831796](https://github.com/CloudPirates-io/helm-charts/commit/3831796))
* chore: update CHANGELOG.md for merged changes ([02c5d47](https://github.com/CloudPirates-io/helm-charts/commit/02c5d47))
* chore: update CHANGELOG.md for merged changes ([2c04385](https://github.com/CloudPirates-io/helm-charts/commit/2c04385))
* chore: auto-generate values.schema.json (#790) ([39d877a](https://github.com/CloudPirates-io/helm-charts/commit/39d877a))

## 0.4.1 (2026-01-01)

* chore: update CHANGELOG.md for merged changes ([be92c3a](https://github.com/CloudPirates-io/helm-charts/commit/be92c3a))
* chore: update CHANGELOG.md for merged changes ([655b893](https://github.com/CloudPirates-io/helm-charts/commit/655b893))
* [zookeeper]: fix typos and set automountServiceAccountToken to false (#789) ([343fb3d](https://github.com/CloudPirates-io/helm-charts/commit/343fb3d))

## 0.3.10 (2025-12-23)

* chore: update CHANGELOG.md for merged changes ([f4e9ecf](https://github.com/CloudPirates-io/helm-charts/commit/f4e9ecf))
* chore: update CHANGELOG.md for merged changes ([1935e6a](https://github.com/CloudPirates-io/helm-charts/commit/1935e6a))
* Final fix for supporting migration from bitnami zookeeper (#778) ([474ab06](https://github.com/CloudPirates-io/helm-charts/commit/474ab06))

## 0.3.9 (2025-12-23)

* chore: update CHANGELOG.md for merged changes ([16be02d](https://github.com/CloudPirates-io/helm-charts/commit/16be02d))
* chore: update CHANGELOG.md for merged changes ([9dc8772](https://github.com/CloudPirates-io/helm-charts/commit/9dc8772))
* fix(zookeeper): add apiVersion and kind to volumeClaimTemplates to prevent OutOfSync on Server-Side-Apply with ArgoCD (#777) ([6800e29](https://github.com/CloudPirates-io/helm-charts/commit/6800e29))
* chore: update CHANGELOG.md for merged changes ([b8318da](https://github.com/CloudPirates-io/helm-charts/commit/b8318da))
* chore: auto-generate values.schema.json (#769) ([ac71b04](https://github.com/CloudPirates-io/helm-charts/commit/ac71b04))

## 0.3.8 (2025-12-21)

* Add support for Bitnami Zookeeper migration with multiple replicas (#768) ([65c0764](https://github.com/CloudPirates-io/helm-charts/commit/65c0764))
* chore: update CHANGELOG.md for merged changes ([525494a](https://github.com/CloudPirates-io/helm-charts/commit/525494a))
* chore: update CHANGELOG.md for merged changes ([cd5cb04](https://github.com/CloudPirates-io/helm-charts/commit/cd5cb04))
* chore: auto-generate values.schema.json (#764) ([5a39be4](https://github.com/CloudPirates-io/helm-charts/commit/5a39be4))

## 0.3.7 (2025-12-17)

* chore: update CHANGELOG.md for merged changes ([ee986d5](https://github.com/CloudPirates-io/helm-charts/commit/ee986d5))
* chore: update CHANGELOG.md for merged changes ([ee8d729](https://github.com/CloudPirates-io/helm-charts/commit/ee8d729))
* Add dataDir option to override path to data folder (#763) ([092def6](https://github.com/CloudPirates-io/helm-charts/commit/092def6))

## 0.3.6 (2025-12-11)

* chore: update CHANGELOG.md for merged changes ([79d5eaa](https://github.com/CloudPirates-io/helm-charts/commit/79d5eaa))
* chore: update CHANGELOG.md for merged changes ([87cca85](https://github.com/CloudPirates-io/helm-charts/commit/87cca85))
* [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba))

## 0.3.5 (2025-12-06)

* chore: update CHANGELOG.md for merged changes ([d0daaa6](https://github.com/CloudPirates-io/helm-charts/commit/d0daaa6))
* chore: update CHANGELOG.md for merged changes ([c9c2ccd](https://github.com/CloudPirates-io/helm-charts/commit/c9c2ccd))
* Update zookeeper statefulset to use existing peristent volume claim if set (#698) ([1bf1992](https://github.com/CloudPirates-io/helm-charts/commit/1bf1992))

## 0.3.4 (2025-12-04)

* chore: update CHANGELOG.md for merged changes ([f13ea15](https://github.com/CloudPirates-io/helm-charts/commit/f13ea15))
* chore: update CHANGELOG.md for merged changes ([3c33f3e](https://github.com/CloudPirates-io/helm-charts/commit/3c33f3e))
* fix network policy switch (#690) ([f7b8ae2](https://github.com/CloudPirates-io/helm-charts/commit/f7b8ae2))

## 0.3.3 (2025-12-01)

* chore: update CHANGELOG.md for merged changes ([acb75b9](https://github.com/CloudPirates-io/helm-charts/commit/acb75b9))
* chore: update CHANGELOG.md for merged changes ([834af35](https://github.com/CloudPirates-io/helm-charts/commit/834af35))
* chore: update CHANGELOG.md for merged changes ([b8d24f9](https://github.com/CloudPirates-io/helm-charts/commit/b8d24f9))
* chore: update CHANGELOG.md for merged changes ([80d4036](https://github.com/CloudPirates-io/helm-charts/commit/80d4036))
* Update charts/zookeeper/values.yaml zookeeper (#604) ([2586190](https://github.com/CloudPirates-io/helm-charts/commit/2586190))

## 0.3.2 (2025-11-13)

* chore: update CHANGELOG.md for merged changes ([96c472e](https://github.com/CloudPirates-io/helm-charts/commit/96c472e))
* chore: update CHANGELOG.md for merged changes ([9923048](https://github.com/CloudPirates-io/helm-charts/commit/9923048))
* chore: update CHANGELOG.md for merged changes ([271f84b](https://github.com/CloudPirates-io/helm-charts/commit/271f84b))

## 0.3.1 (2025-11-12)

* Update charts/zookeeper/values.yaml zookeeper (#590) ([ac259f3](https://github.com/CloudPirates-io/helm-charts/commit/ac259f3))
* chore: update CHANGELOG.md for merged changes ([170dd6a](https://github.com/CloudPirates-io/helm-charts/commit/170dd6a))
* chore: update CHANGELOG.md for merged changes ([9227d83](https://github.com/CloudPirates-io/helm-charts/commit/9227d83))
* [etcd, rabbitmq, redis, zookeeper] add signature verification documentation to readme (#476) ([91c7310](https://github.com/CloudPirates-io/helm-charts/commit/91c7310))
* chore: update CHANGELOG.md for merged changes ([8260788](https://github.com/CloudPirates-io/helm-charts/commit/8260788))
* chore: update CHANGELOG.md for merged changes ([402f7bd](https://github.com/CloudPirates-io/helm-charts/commit/402f7bd))

## 0.3.0 (2025-10-28)

* chore: auto-generate values.schema.json for updated charts (#455) ([aec6840](https://github.com/CloudPirates-io/helm-charts/commit/aec6840))
* chore: update CHANGELOG.md for merged changes ([f9c3ff0](https://github.com/CloudPirates-io/helm-charts/commit/f9c3ff0))
* chore: update CHANGELOG.md for merged changes ([db2d800](https://github.com/CloudPirates-io/helm-charts/commit/db2d800))

## 0.2.1 (2025-10-23)

* chore: update CHANGELOG.md for merged changes ([c80ea42](https://github.com/CloudPirates-io/helm-charts/commit/c80ea42))
* chore: update CHANGELOG.md for merged changes ([8ccb4bb](https://github.com/CloudPirates-io/helm-charts/commit/8ccb4bb))
* chore: update CHANGELOG.md for merged changes ([1a4f87b](https://github.com/CloudPirates-io/helm-charts/commit/1a4f87b))
* chore: update CHANGELOG.md for merged changes ([da866ca](https://github.com/CloudPirates-io/helm-charts/commit/da866ca))
* chore: update CHANGELOG.md for merged changes ([b54c4f1](https://github.com/CloudPirates-io/helm-charts/commit/b54c4f1))
* chore: update CHANGELOG.md for merged changes ([5a2ed20](https://github.com/CloudPirates-io/helm-charts/commit/5a2ed20))
* chore: update CHANGELOG.md for merged changes ([3361964](https://github.com/CloudPirates-io/helm-charts/commit/3361964))
* chore: update CHANGELOG.md for merged changes ([7f61172](https://github.com/CloudPirates-io/helm-charts/commit/7f61172))
* chore: update CHANGELOG.md for merged changes ([1ec9aab](https://github.com/CloudPirates-io/helm-charts/commit/1ec9aab))
* chore: update CHANGELOG.md for merged changes ([c9ff4ec](https://github.com/CloudPirates-io/helm-charts/commit/c9ff4ec))
* chore: update CHANGELOG.md for merged changes ([86f1d25](https://github.com/CloudPirates-io/helm-charts/commit/86f1d25))

## 0.2.0 (2025-10-14)

* Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))
* chore: update CHANGELOG.md for merged changes ([84cf67b](https://github.com/CloudPirates-io/helm-charts/commit/84cf67b))
* chore: update CHANGELOG.md for all charts via manual trigger ([6974964](https://github.com/CloudPirates-io/helm-charts/commit/6974964))
* chore: update CHANGELOG.md for merged changes ([da69e0e](https://github.com/CloudPirates-io/helm-charts/commit/da69e0e))
* chore: update CHANGELOG.md for merged changes ([5da1b15](https://github.com/CloudPirates-io/helm-charts/commit/5da1b15))

## 0.1.7 (2025-10-13)

* add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))

## 0.1.6 (2025-10-09)

* Update charts/zookeeper/values.yaml zookeeper to v3.9.4 (patch) (#267) ([df3b9e3](https://github.com/CloudPirates-io/helm-charts/commit/df3b9e3))

## 0.1.5 (2025-10-01)

* Fix/allow zookeeper to scale to 0 replicas (#196) ([7403e9d](https://github.com/CloudPirates-io/helm-charts/commit/7403e9d))
* trigger pipeline without version-upgrade (#191) ([819492c](https://github.com/CloudPirates-io/helm-charts/commit/819492c))

## 0.1.4 (2025-09-30)

* [Nginx] Change nginx and zookeeper security-context to use helper-function (#169) ([b581bc7](https://github.com/CloudPirates-io/helm-charts/commit/b581bc7))

## 0.1.3 (2025-09-26)

* #170 fix for command whitelist (#171) ([ebd91d8](https://github.com/CloudPirates-io/helm-charts/commit/ebd91d8))

## 0.1.2 (2025-09-26)


## 0.1.1 (2025-09-25)

* add networkpolicy and poddisruptionbudget (#2) (#155) ([2a84b43](https://github.com/CloudPirates-io/helm-charts/commit/2a84b43))

## 0.1.0 (2025-09-11)

* Initial tagged release
