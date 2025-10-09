# Changelog

## 0.6.0 (2025-10-09)

* [redis] Include podLabels in redis statefulset ([#274](https://github.com/CloudPirates-io/helm-charts/pull/274))

## <small>0.5.7 (2025-10-09)</small>

* Update charts/redis/values.yaml redis to v8.2.2 (patch) (#264) ([f699d00](https://github.com/anjomro/helm-charts/commit/f699d00)), closes [#264](https://github.com/anjomro/helm-charts/issues/264)

## <small>0.5.6 (2025-10-08)</small>

* [oliver006/redis_exporter] Update oliver006/redis_exporter to v1.78.0 (#235) ([508fd61](https://github.com/anjomro/helm-charts/commit/508fd61)), closes [#235](https://github.com/anjomro/helm-charts/issues/235)

## <small>0.5.5 (2025-10-08)</small>

* Update redis to v8.2.2 (#233) ([363468b](https://github.com/anjomro/helm-charts/commit/363468b)), closes [#233](https://github.com/anjomro/helm-charts/issues/233)

## <small>0.5.4 (2025-10-08)</small>

* [redis]: fix dual stack networking issues (#227) ([381bd76](https://github.com/anjomro/helm-charts/commit/381bd76)), closes [#227](https://github.com/anjomro/helm-charts/issues/227)

## <small>0.5.3 (2025-10-06)</small>

* Add automatically generated fields to volumeClaimTemplates (#218) ([5f4142b](https://github.com/anjomro/helm-charts/commit/5f4142b)), closes [#218](https://github.com/anjomro/helm-charts/issues/218)

## <small>0.5.2 (2025-10-06)</small>

* chore(deps): update redis:8.2.1 Docker digest to 5fa2edb (#188) ([6a72e00](https://github.com/anjomro/helm-charts/commit/6a72e00)), closes [#188](https://github.com/anjomro/helm-charts/issues/188)

## <small>0.5.1 (2025-10-06)</small>

* chore(deps): update docker.io/redis:8.2.1 Docker digest to 5fa2edb (#187) ([fe21dc2](https://github.com/anjomro/helm-charts/commit/fe21dc2)), closes [#187](https://github.com/anjomro/helm-charts/issues/187)

## 0.5.0 (2025-10-01)

* make redis run on openshift (#193) ([cc4d3c3](https://github.com/anjomro/helm-charts/commit/cc4d3c3)), closes [#193](https://github.com/anjomro/helm-charts/issues/193)

## <small>0.4.6 (2025-09-25)</small>

* Add metrics section to the README ([14a37bc](https://github.com/anjomro/helm-charts/commit/14a37bc))
* Add topologySpreadConstraints option to the chart ([9c9eeeb](https://github.com/anjomro/helm-charts/commit/9c9eeeb))
* add volumeMounts option for sentinel container ([8499307](https://github.com/anjomro/helm-charts/commit/8499307))
* bump up chart patch version ([c436c6d](https://github.com/anjomro/helm-charts/commit/c436c6d))
* bump up chart patch version ([a5c9dfb](https://github.com/anjomro/helm-charts/commit/a5c9dfb))
* fix sentinel conditions. set default to standalone ([bf935fa](https://github.com/anjomro/helm-charts/commit/bf935fa))
* Implement redis service monitoring ([3aec93d](https://github.com/anjomro/helm-charts/commit/3aec93d))
* requirepass for sentinel cli operations when password is set ([60d1b5c](https://github.com/anjomro/helm-charts/commit/60d1b5c))
* return fqdn for sentinel master lookup (#156) ([00b9882](https://github.com/anjomro/helm-charts/commit/00b9882)), closes [#156](https://github.com/anjomro/helm-charts/issues/156)
* [redis]: Persistent volume claim retentionpolicy ([1f708a5](https://github.com/anjomro/helm-charts/commit/1f708a5))
* Bitnami style fail over script ([9b9a395](https://github.com/anjomro/helm-charts/commit/9b9a395))
* Bump chart version ([a892492](https://github.com/anjomro/helm-charts/commit/a892492))
* Bump chart version ([a6ac908](https://github.com/anjomro/helm-charts/commit/a6ac908))
* Bump version ([43dceb2](https://github.com/anjomro/helm-charts/commit/43dceb2))
* Configurable recheck values ([cf31961](https://github.com/anjomro/helm-charts/commit/cf31961))
* Decrease defaults ([572cba9](https://github.com/anjomro/helm-charts/commit/572cba9))
* Fix invalid master detection ([f1545d9](https://github.com/anjomro/helm-charts/commit/f1545d9))
* fix lint ([c9a0e4f](https://github.com/anjomro/helm-charts/commit/c9a0e4f))
* Fix lint ([9943a66](https://github.com/anjomro/helm-charts/commit/9943a66))
* Fix pod not restarting after configmap change ([8181649](https://github.com/anjomro/helm-charts/commit/8181649))
* Fix reviews ([87c780c](https://github.com/anjomro/helm-charts/commit/87c780c))
* Fix roles ([9f6cd01](https://github.com/anjomro/helm-charts/commit/9f6cd01))
* Full rework ([a8f4e56](https://github.com/anjomro/helm-charts/commit/a8f4e56))
* Implement redis sentinal functionality ([70d64d5](https://github.com/anjomro/helm-charts/commit/70d64d5))
* Implement suggested improvements ([aeac191](https://github.com/anjomro/helm-charts/commit/aeac191))
* Improve defaults ([b964825](https://github.com/anjomro/helm-charts/commit/b964825))
* Minor improvements ([016dee2](https://github.com/anjomro/helm-charts/commit/016dee2))
* Sync on restart if sentinel available ([628128e](https://github.com/anjomro/helm-charts/commit/628128e))
* Unhardcode ips ([b6e0a4e](https://github.com/anjomro/helm-charts/commit/b6e0a4e))
* Update CHANGELOG.md ([7691aa0](https://github.com/anjomro/helm-charts/commit/7691aa0))
* Update CHANGELOG.md ([fcf698f](https://github.com/anjomro/helm-charts/commit/fcf698f))
* Update CHANGELOG.md ([1afe498](https://github.com/anjomro/helm-charts/commit/1afe498))
* Update CHANGELOG.md ([0da41aa](https://github.com/anjomro/helm-charts/commit/0da41aa))
* Update CHANGELOG.md ([8425f12](https://github.com/anjomro/helm-charts/commit/8425f12))
* Update CHANGELOG.md ([2753a1e](https://github.com/anjomro/helm-charts/commit/2753a1e))
* Update CHANGELOG.md ([f6ea97b](https://github.com/anjomro/helm-charts/commit/f6ea97b))
* Update CHANGELOG.md ([9bd42ad](https://github.com/anjomro/helm-charts/commit/9bd42ad))
* Update CHANGELOG.md ([497514f](https://github.com/anjomro/helm-charts/commit/497514f))
* Update CHANGELOG.md ([18008d2](https://github.com/anjomro/helm-charts/commit/18008d2))
* Update CHANGELOG.md ([dfaff03](https://github.com/anjomro/helm-charts/commit/dfaff03))
* Update CHANGELOG.md ([e60664c](https://github.com/anjomro/helm-charts/commit/e60664c))
* Update CHANGELOG.md ([025e4b2](https://github.com/anjomro/helm-charts/commit/025e4b2))
* Update CHANGELOG.md ([a4c0fd0](https://github.com/anjomro/helm-charts/commit/a4c0fd0))
* Update CHANGELOG.md ([103dbd5](https://github.com/anjomro/helm-charts/commit/103dbd5))
* Update CHANGELOG.md ([4657370](https://github.com/anjomro/helm-charts/commit/4657370))
* Update CHANGELOG.md ([e572ff3](https://github.com/anjomro/helm-charts/commit/e572ff3))
* Update CHANGELOG.md ([507c187](https://github.com/anjomro/helm-charts/commit/507c187))
* Update docker.io/redis:8.2.1 Docker digest to acb90ce ([eb469b0](https://github.com/anjomro/helm-charts/commit/eb469b0))
* chore: bump chart version ([b8bec46](https://github.com/anjomro/helm-charts/commit/b8bec46))
* feat: add init container resources configurable values ([852ac34](https://github.com/anjomro/helm-charts/commit/852ac34))
* feat: bind resource to init-container resources from values ([014db83](https://github.com/anjomro/helm-charts/commit/014db83))

## 0.2.0 (2025-09-02)

* add extraObject array to all charts ([34772b7](https://github.com/anjomro/helm-charts/commit/34772b7))
* bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/anjomro/helm-charts/commit/aaa57f9))

## <small>0.1.8 (2025-08-31)</small>

* Add support for statefulset priorityclassname ([b5847dd](https://github.com/anjomro/helm-charts/commit/b5847dd))
* Update CHANGELOG.md ([d1c5ba2](https://github.com/anjomro/helm-charts/commit/d1c5ba2))

## <small>0.1.7 (2025-08-28)</small>

* add readme and values.schema.json ([873286c](https://github.com/anjomro/helm-charts/commit/873286c))
* Fix typo in readme ([cce0ea8](https://github.com/anjomro/helm-charts/commit/cce0ea8))
* fix version ([2701959](https://github.com/anjomro/helm-charts/commit/2701959))
* Refactor chart ([33323aa](https://github.com/anjomro/helm-charts/commit/33323aa))
* Update chart to 0.1.1 ([5fa15b9](https://github.com/anjomro/helm-charts/commit/5fa15b9))
* Update version to 8.2.1 / Fix readme ([5266eaf](https://github.com/anjomro/helm-charts/commit/5266eaf))
* Add ArtifactHub Badges to all Charts ([08b855b](https://github.com/anjomro/helm-charts/commit/08b855b))
* Add ArtifactHub repo config ([15180a8](https://github.com/anjomro/helm-charts/commit/15180a8))
* Add cosign signature READMEs ([5f82e7f](https://github.com/anjomro/helm-charts/commit/5f82e7f))
* Add extensive chart testing ([a46efac](https://github.com/anjomro/helm-charts/commit/a46efac))
* Add generated values.schema.json files from values.yaml ([aa79ac3](https://github.com/anjomro/helm-charts/commit/aa79ac3))
* Add initial Changelogs to all Charts ([68f10ca](https://github.com/anjomro/helm-charts/commit/68f10ca))
* Add LICENSE ([fdbf1ab](https://github.com/anjomro/helm-charts/commit/fdbf1ab))
* add logos to helm-charts ([fc70cdc](https://github.com/anjomro/helm-charts/commit/fc70cdc))
* Bump chart version ([395c7d5](https://github.com/anjomro/helm-charts/commit/395c7d5))
* Fix image tag/digest handling ([a5c982b](https://github.com/anjomro/helm-charts/commit/a5c982b))
* Fix imagePullSecrets format and pull always ([ce0d301](https://github.com/anjomro/helm-charts/commit/ce0d301))
* fix readme.md install text, update chart.yaml home-website ([3511582](https://github.com/anjomro/helm-charts/commit/3511582))
* Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/anjomro/helm-charts/commit/043c7e0))
* Format README files ([04aacab](https://github.com/anjomro/helm-charts/commit/04aacab))
* init, add mariadb, mongodb and redis chart ([8e44c83](https://github.com/anjomro/helm-charts/commit/8e44c83))
* Release new chart versions / update sources ([dbb0e45](https://github.com/anjomro/helm-charts/commit/dbb0e45))
* Remove leading $ from code blocks ([836b2e3](https://github.com/anjomro/helm-charts/commit/836b2e3))
* remove serviceaccounts from all charts ([be8f43a](https://github.com/anjomro/helm-charts/commit/be8f43a))
* Update CHANGELOG.md ([26bf940](https://github.com/anjomro/helm-charts/commit/26bf940))
* Update docker.io/redis Docker tag to v8.2.1 ([53db488](https://github.com/anjomro/helm-charts/commit/53db488))
* update readme, chart.yaml texts and descriptions ([0179046](https://github.com/anjomro/helm-charts/commit/0179046))
* Use lookup function for password where applicable ([dfb9a0e](https://github.com/anjomro/helm-charts/commit/dfb9a0e))
* fix: chart icon urls ([cc38c0d](https://github.com/anjomro/helm-charts/commit/cc38c0d))
