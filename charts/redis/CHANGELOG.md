# Changelog


## 0.7.0 (2025-10-14)

* Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))
* chore: update CHANGELOG.md for merged changes ([84cf67b](https://github.com/CloudPirates-io/helm-charts/commit/84cf67b))
* chore: update CHANGELOG.md for all charts via manual trigger ([6974964](https://github.com/CloudPirates-io/helm-charts/commit/6974964))
* chore: update CHANGELOG.md for merged changes ([63b7bfa](https://github.com/CloudPirates-io/helm-charts/commit/63b7bfa))
* chore: update CHANGELOG.md for merged changes ([da69e0e](https://github.com/CloudPirates-io/helm-charts/commit/da69e0e))
* chore: update CHANGELOG.md for merged changes ([5da1b15](https://github.com/CloudPirates-io/helm-charts/commit/5da1b15))

## 0.6.4 (2025-10-13)


## 0.6.3 (2025-10-10)

* feat: use "common.namespace" (#332) ([6dd8563](https://github.com/CloudPirates-io/helm-charts/commit/6dd8563))

## 0.6.2 (2025-10-09)

* fix: better IPv6 compatibility (#296) ([1d3543c](https://github.com/CloudPirates-io/helm-charts/commit/1d3543c))

## 0.6.1 (2025-10-09)

* [redis , rabbitmq]: Add podAnnotations (#294) ([6d78869](https://github.com/CloudPirates-io/helm-charts/commit/6d78869))
* add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))

## 0.6.0 (2025-10-09)

* Include podLabels in redis statefulset (#274) ([024da55](https://github.com/CloudPirates-io/helm-charts/commit/024da55))

## 0.5.7 (2025-10-09)

* Update charts/redis/values.yaml redis to v8.2.2 (patch) (#264) ([f699d00](https://github.com/CloudPirates-io/helm-charts/commit/f699d00))

## 0.5.6 (2025-10-08)

* [oliver006/redis_exporter] Update oliver006/redis_exporter to v1.78.0 (#235) ([508fd61](https://github.com/CloudPirates-io/helm-charts/commit/508fd61))

## 0.5.5 (2025-10-08)

* Update redis to v8.2.2 (#233) ([363468b](https://github.com/CloudPirates-io/helm-charts/commit/363468b))

## 0.5.4 (2025-10-08)

* [redis]: fix dual stack networking issues (#227) ([381bd76](https://github.com/CloudPirates-io/helm-charts/commit/381bd76))

## 0.5.3 (2025-10-06)

* Add automatically generated fields to volumeClaimTemplates (#218) ([5f4142b](https://github.com/CloudPirates-io/helm-charts/commit/5f4142b))

## 0.5.2 (2025-10-06)

* chore(deps): update redis:8.2.1 Docker digest to 5fa2edb (#188) ([6a72e00](https://github.com/CloudPirates-io/helm-charts/commit/6a72e00))

## 0.5.1 (2025-10-06)

* chore(deps): update docker.io/redis:8.2.1 Docker digest to 5fa2edb (#187) ([fe21dc2](https://github.com/CloudPirates-io/helm-charts/commit/fe21dc2))

## 0.5.0 (2025-10-01)

* make redis run on openshift (#193) ([cc4d3c3](https://github.com/CloudPirates-io/helm-charts/commit/cc4d3c3))

## 0.4.6 (2025-09-25)

* return fqdn for sentinel master lookup (#156) ([00b9882](https://github.com/CloudPirates-io/helm-charts/commit/00b9882))

## 0.4.5 (2025-09-24)

* Update CHANGELOG.md ([7691aa0](https://github.com/CloudPirates-io/helm-charts/commit/7691aa0))
* requirepass for sentinel cli operations when password is set ([60d1b5c](https://github.com/CloudPirates-io/helm-charts/commit/60d1b5c))
* Update CHANGELOG.md ([fcf698f](https://github.com/CloudPirates-io/helm-charts/commit/fcf698f))
* Update CHANGELOG.md ([1afe498](https://github.com/CloudPirates-io/helm-charts/commit/1afe498))
* Update CHANGELOG.md ([0da41aa](https://github.com/CloudPirates-io/helm-charts/commit/0da41aa))
* Update CHANGELOG.md ([8425f12](https://github.com/CloudPirates-io/helm-charts/commit/8425f12))
* Update CHANGELOG.md ([2753a1e](https://github.com/CloudPirates-io/helm-charts/commit/2753a1e))

## 0.4.4 (2025-09-23)

* Update CHANGELOG.md ([f6ea97b](https://github.com/CloudPirates-io/helm-charts/commit/f6ea97b))
* Update CHANGELOG.md ([9bd42ad](https://github.com/CloudPirates-io/helm-charts/commit/9bd42ad))
* [redis]: Persistent volume claim retentionpolicy ([1f708a5](https://github.com/CloudPirates-io/helm-charts/commit/1f708a5))

## 0.4.3 (2025-09-23)

* Update CHANGELOG.md ([497514f](https://github.com/CloudPirates-io/helm-charts/commit/497514f))
* add volumeMounts option for sentinel container ([8499307](https://github.com/CloudPirates-io/helm-charts/commit/8499307))

## 0.4.2 (2025-09-23)

* Update CHANGELOG.md ([18008d2](https://github.com/CloudPirates-io/helm-charts/commit/18008d2))
* bump up chart patch version ([c436c6d](https://github.com/CloudPirates-io/helm-charts/commit/c436c6d))
* Add topologySpreadConstraints option to the chart ([9c9eeeb](https://github.com/CloudPirates-io/helm-charts/commit/9c9eeeb))

## 0.4.1 (2025-09-23)

* bump up chart patch version ([a5c9dfb](https://github.com/CloudPirates-io/helm-charts/commit/a5c9dfb))
* Add metrics section to the README ([14a37bc](https://github.com/CloudPirates-io/helm-charts/commit/14a37bc))

## 0.4.0 (2025-09-22)

* Fix reviews ([87c780c](https://github.com/CloudPirates-io/helm-charts/commit/87c780c))
* Update CHANGELOG.md ([dfaff03](https://github.com/CloudPirates-io/helm-charts/commit/dfaff03))
* Implement redis service monitoring ([3aec93d](https://github.com/CloudPirates-io/helm-charts/commit/3aec93d))

## 0.3.3 (2025-09-18)

* Update CHANGELOG.md ([e60664c](https://github.com/CloudPirates-io/helm-charts/commit/e60664c))
* chore: bump chart version ([b8bec46](https://github.com/CloudPirates-io/helm-charts/commit/b8bec46))
* feat: bind resource to init-container resources from values ([014db83](https://github.com/CloudPirates-io/helm-charts/commit/014db83))
* feat: add init container resources configurable values ([852ac34](https://github.com/CloudPirates-io/helm-charts/commit/852ac34))

## 0.3.2 (2025-09-18)

* Update CHANGELOG.md ([025e4b2](https://github.com/CloudPirates-io/helm-charts/commit/025e4b2))
* Fix lint ([9943a66](https://github.com/CloudPirates-io/helm-charts/commit/9943a66))
* Bump chart version ([a892492](https://github.com/CloudPirates-io/helm-charts/commit/a892492))
* Fix pod not restarting after configmap change ([8181649](https://github.com/CloudPirates-io/helm-charts/commit/8181649))

## 0.3.1 (2025-09-17)

* Update CHANGELOG.md ([a4c0fd0](https://github.com/CloudPirates-io/helm-charts/commit/a4c0fd0))
* fix sentinel conditions. set default to standalone ([bf935fa](https://github.com/CloudPirates-io/helm-charts/commit/bf935fa))

## 0.3.0 (2025-09-15)

* Decrease defaults ([572cba9](https://github.com/CloudPirates-io/helm-charts/commit/572cba9))
* Bitnami style fail over script ([9b9a395](https://github.com/CloudPirates-io/helm-charts/commit/9b9a395))
* Unhardcode ips ([b6e0a4e](https://github.com/CloudPirates-io/helm-charts/commit/b6e0a4e))
* Implement suggested improvements ([aeac191](https://github.com/CloudPirates-io/helm-charts/commit/aeac191))
* Improve defaults ([b964825](https://github.com/CloudPirates-io/helm-charts/commit/b964825))
* Configurable recheck values ([cf31961](https://github.com/CloudPirates-io/helm-charts/commit/cf31961))
* Full rework ([a8f4e56](https://github.com/CloudPirates-io/helm-charts/commit/a8f4e56))
* Update CHANGELOG.md ([103dbd5](https://github.com/CloudPirates-io/helm-charts/commit/103dbd5))
* Sync on restart if sentinel available ([628128e](https://github.com/CloudPirates-io/helm-charts/commit/628128e))
* Minor improvements ([016dee2](https://github.com/CloudPirates-io/helm-charts/commit/016dee2))
* Update CHANGELOG.md ([4657370](https://github.com/CloudPirates-io/helm-charts/commit/4657370))
* Fix invalid master detection ([f1545d9](https://github.com/CloudPirates-io/helm-charts/commit/f1545d9))
* Fix roles ([9f6cd01](https://github.com/CloudPirates-io/helm-charts/commit/9f6cd01))
* Update CHANGELOG.md ([e572ff3](https://github.com/CloudPirates-io/helm-charts/commit/e572ff3))
* fix lint ([c9a0e4f](https://github.com/CloudPirates-io/helm-charts/commit/c9a0e4f))
* Bump chart version ([a6ac908](https://github.com/CloudPirates-io/helm-charts/commit/a6ac908))
* Implement redis sentinal functionality ([70d64d5](https://github.com/CloudPirates-io/helm-charts/commit/70d64d5))

## 0.2.1 (2025-09-09)

* Update CHANGELOG.md ([507c187](https://github.com/CloudPirates-io/helm-charts/commit/507c187))
* Bump version ([43dceb2](https://github.com/CloudPirates-io/helm-charts/commit/43dceb2))
* Update docker.io/redis:8.2.1 Docker digest to acb90ce ([eb469b0](https://github.com/CloudPirates-io/helm-charts/commit/eb469b0))

## 0.2.0 (2025-09-02)

* bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
* add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## 0.1.8 (2025-08-31)

* Update CHANGELOG.md ([d1c5ba2](https://github.com/CloudPirates-io/helm-charts/commit/d1c5ba2))
* Add support for statefulset priorityclassname ([b5847dd](https://github.com/CloudPirates-io/helm-charts/commit/b5847dd))

## 0.1.7 (2025-08-28)

* Update CHANGELOG.md ([26bf940](https://github.com/CloudPirates-io/helm-charts/commit/26bf940))
* Bump chart version ([395c7d5](https://github.com/CloudPirates-io/helm-charts/commit/395c7d5))
* Fix typo in readme ([cce0ea8](https://github.com/CloudPirates-io/helm-charts/commit/cce0ea8))

## 0.1.6 (2025-08-27)

* Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
* Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## 0.1.5 (2025-08-26)

* Initial tagged release
