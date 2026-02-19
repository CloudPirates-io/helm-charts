# Changelog

All notable changes to this chart will be documented in this file.

## [cluster-operator-0.2.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))
- [rabbitmq]: Adjust default podManagementPolicy to parallel (#1000) ([e396ff60](https://github.com/CloudPirates-io/helm-charts/commit/e396ff60))
- Allow configuration of the resources for the initContainers (#1004) ([4427cf9a](https://github.com/CloudPirates-io/helm-charts/commit/4427cf9a))

## [cluster-operator-0.1.7] - 2026-02-12


## [cluster-operator-0.1.6] - 2026-02-12

- Update charts/rabbitmq/values.yaml rabbitmq (#984) ([14485f32](https://github.com/CloudPirates-io/helm-charts/commit/14485f32))
- Rabbitmq extra objects linting (#980) ([a5b5e8ba](https://github.com/CloudPirates-io/helm-charts/commit/a5b5e8ba))
- Update charts/rabbitmq/values.yaml rabbitmq (#977) ([512735b8](https://github.com/CloudPirates-io/helm-charts/commit/512735b8))
- [rabbitmq]: Update README to better reflect queue balancing ([174a9649](https://github.com/CloudPirates-io/helm-charts/commit/174a9649))
- Update charts/rabbitmq/values.yaml rabbitmq (#956) ([d8dad6e3](https://github.com/CloudPirates-io/helm-charts/commit/d8dad6e3))
- The management.load_definitions is deprecated and we should use definitions.local.path now (#954) ([c35081b1](https://github.com/CloudPirates-io/helm-charts/commit/c35081b1))
- [busybox] Update image to b3255e7 (#941) ([987aa3e6](https://github.com/CloudPirates-io/helm-charts/commit/987aa3e6))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))
- Fix template scope in installPlugins range block (#927) ([b4521bd1](https://github.com/CloudPirates-io/helm-charts/commit/b4521bd1))
- Update charts/rabbitmq/values.yaml rabbitmq (#889) ([39f2c6cc](https://github.com/CloudPirates-io/helm-charts/commit/39f2c6cc))

## [cluster-operator-0.1.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))
- add option to set mountPath for data volume (#902) ([7d892f90](https://github.com/CloudPirates-io/helm-charts/commit/7d892f90))
- Add detailed metrics support (#804) (#901) ([96a74acb](https://github.com/CloudPirates-io/helm-charts/commit/96a74acb))
- [curlimages/curl] Update image to v8.18.0 (#890) ([90346133](https://github.com/CloudPirates-io/helm-charts/commit/90346133))
- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.3 (patch) (#891) ([6b77a8a4](https://github.com/CloudPirates-io/helm-charts/commit/6b77a8a4))
- [rabbitmq]: Sidecar container watching configmap (#873) ([b7a421a7](https://github.com/CloudPirates-io/helm-charts/commit/b7a421a7))
- [busybox] Update image to e226d63 (#884) ([7624bab3](https://github.com/CloudPirates-io/helm-charts/commit/7624bab3))
- [busybox] Update image to b86c79d (#882) ([4783a362](https://github.com/CloudPirates-io/helm-charts/commit/4783a362))
- Update charts/rabbitmq/values.yaml rabbitmq (#872) ([ce338164](https://github.com/CloudPirates-io/helm-charts/commit/ce338164))
- Update charts/rabbitmq/values.yaml rabbitmq (#856) ([2712d85c](https://github.com/CloudPirates-io/helm-charts/commit/2712d85c))

## [cluster-operator-0.1.4] - 2026-01-19

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))
- queuebalancing schema types (#831) ([f1f1fbff](https://github.com/CloudPirates-io/helm-charts/commit/f1f1fbff))
- queues not balanced #653 ([a9f6a5d3](https://github.com/CloudPirates-io/helm-charts/commit/a9f6a5d3))

## [cluster-operator-0.1.3] - 2026-01-09

- Update README.md : ha cluster config and chart update infos (#826) ([54caf600](https://github.com/CloudPirates-io/helm-charts/commit/54caf600))
- Update charts/rabbitmq/values.yaml rabbitmq (#821) ([11cd6b1c](https://github.com/CloudPirates-io/helm-charts/commit/11cd6b1c))
- [busybox] Update image to 2383baa (#818) ([83791f20](https://github.com/CloudPirates-io/helm-charts/commit/83791f20))
- queues not balanced #653 ([b3e74ada](https://github.com/CloudPirates-io/helm-charts/commit/b3e74ada))

## [cluster-operator-0.1.2] - 2026-01-05

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.2 (patch) (#760) ([3ddf1ed7](https://github.com/CloudPirates-io/helm-charts/commit/3ddf1ed7))

## [cluster-operator-0.1.1] - 2025-12-16

- Add externalTrafficPolicy and allocateLoadBalancerNodePorts to service spec (#730) ([22ec7feb](https://github.com/CloudPirates-io/helm-charts/commit/22ec7feb))
- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba9](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba9))
- Add ServiceAccount automountServiceAccountToken configuration (#673) ([c9f8f249](https://github.com/CloudPirates-io/helm-charts/commit/c9f8f249))
- [busybox] Update image to d80cd69 (#709) ([68fc5f87](https://github.com/CloudPirates-io/helm-charts/commit/68fc5f87))
- [universal] fix statefulset pvc labels (#696) ([b87dbc7a](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7a))
- [universal] add labels to statefulset pvc-templates (#681) ([87624a55](https://github.com/CloudPirates-io/helm-charts/commit/87624a55))

## [cluster-operator-0.1.0] - 2025-12-01


## [0.16.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.15.11] - 2026-02-12

- [rabbitmq]: Adjust default podManagementPolicy to parallel (#1000) ([e396ff60](https://github.com/CloudPirates-io/helm-charts/commit/e396ff60))

## [0.15.10] - 2026-02-12

- Allow configuration of the resources for the initContainers (#1004) ([4427cf9a](https://github.com/CloudPirates-io/helm-charts/commit/4427cf9a))

## [0.15.9] - 2026-02-11

- Update charts/rabbitmq/values.yaml rabbitmq (#984) ([14485f32](https://github.com/CloudPirates-io/helm-charts/commit/14485f32))

## [0.15.8] - 2026-02-11

- Rabbitmq extra objects linting (#980) ([a5b5e8ba](https://github.com/CloudPirates-io/helm-charts/commit/a5b5e8ba))

## [0.15.7] - 2026-02-06

- Update charts/rabbitmq/values.yaml rabbitmq (#977) ([512735b8](https://github.com/CloudPirates-io/helm-charts/commit/512735b8))

## [0.15.6] - 2026-02-04

- [rabbitmq]: Update README to better reflect queue balancing ([174a9649](https://github.com/CloudPirates-io/helm-charts/commit/174a9649))
- Update charts/rabbitmq/values.yaml rabbitmq (#956) ([d8dad6e3](https://github.com/CloudPirates-io/helm-charts/commit/d8dad6e3))

## [0.15.5] - 2026-02-04

- The management.load_definitions is deprecated and we should use definitions.local.path now (#954) ([c35081b1](https://github.com/CloudPirates-io/helm-charts/commit/c35081b1))

## [0.15.4] - 2026-02-03

- [busybox] Update image to b3255e7 (#941) ([987aa3e6](https://github.com/CloudPirates-io/helm-charts/commit/987aa3e6))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.15.3] - 2026-01-30

- Fix template scope in installPlugins range block (#927) ([b4521bd1](https://github.com/CloudPirates-io/helm-charts/commit/b4521bd1))

## [0.15.2] - 2026-01-28

- Update charts/rabbitmq/values.yaml rabbitmq (#889) ([39f2c6cc](https://github.com/CloudPirates-io/helm-charts/commit/39f2c6cc))

## [0.15.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.15.0] - 2026-01-27

- add option to set mountPath for data volume (#902) ([7d892f90](https://github.com/CloudPirates-io/helm-charts/commit/7d892f90))

## [0.14.0] - 2026-01-26

- Add detailed metrics support (#804) (#901) ([96a74acb](https://github.com/CloudPirates-io/helm-charts/commit/96a74acb))

## [0.13.2] - 2026-01-26

- [curlimages/curl] Update image to v8.18.0 (#890) ([90346133](https://github.com/CloudPirates-io/helm-charts/commit/90346133))

## [0.13.1] - 2026-01-26

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.3 (patch) (#891) ([6b77a8a4](https://github.com/CloudPirates-io/helm-charts/commit/6b77a8a4))

## [0.13.0] - 2026-01-22

- [rabbitmq]: Sidecar container watching configmap (#873) ([b7a421a7](https://github.com/CloudPirates-io/helm-charts/commit/b7a421a7))

## [0.12.4] - 2026-01-22

- [busybox] Update image to e226d63 (#884) ([7624bab3](https://github.com/CloudPirates-io/helm-charts/commit/7624bab3))

## [0.12.3] - 2026-01-22

- [busybox] Update image to b86c79d (#882) ([4783a362](https://github.com/CloudPirates-io/helm-charts/commit/4783a362))

## [0.12.2] - 2026-01-21

- Update charts/rabbitmq/values.yaml rabbitmq (#872) ([ce338164](https://github.com/CloudPirates-io/helm-charts/commit/ce338164))

## [0.12.1] - 2026-01-19

- Update charts/rabbitmq/values.yaml rabbitmq (#856) ([2712d85c](https://github.com/CloudPirates-io/helm-charts/commit/2712d85c))

## [0.12.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))

## [0.11.5] - 2026-01-12

- queuebalancing schema types (#831) ([f1f1fbff](https://github.com/CloudPirates-io/helm-charts/commit/f1f1fbff))

## [0.11.4] - 2026-01-10

- queues not balanced #653 ([a9f6a5d3](https://github.com/CloudPirates-io/helm-charts/commit/a9f6a5d3))

## [0.11.3] - 2026-01-09

- Update README.md : ha cluster config and chart update infos (#826) ([54caf600](https://github.com/CloudPirates-io/helm-charts/commit/54caf600))

## [0.11.2] - 2026-01-08

- Update charts/rabbitmq/values.yaml rabbitmq (#821) ([11cd6b1c](https://github.com/CloudPirates-io/helm-charts/commit/11cd6b1c))

## [0.11.1] - 2026-01-08

- [busybox] Update image to 2383baa (#818) ([83791f20](https://github.com/CloudPirates-io/helm-charts/commit/83791f20))

## [0.11.0] - 2026-01-08

- queues not balanced #653 ([b3e74ada](https://github.com/CloudPirates-io/helm-charts/commit/b3e74ada))

## [0.10.2] - 2025-12-22

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.2 (patch) (#760) ([3ddf1ed7](https://github.com/CloudPirates-io/helm-charts/commit/3ddf1ed7))

## [0.10.1] - 2025-12-12

- Add externalTrafficPolicy and allocateLoadBalancerNodePorts to service spec (#730) ([22ec7feb](https://github.com/CloudPirates-io/helm-charts/commit/22ec7feb))

## [0.10.0] - 2025-12-11

- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba9](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba9))

## [0.9.0] - 2025-12-11

- Add ServiceAccount automountServiceAccountToken configuration (#673) ([c9f8f249](https://github.com/CloudPirates-io/helm-charts/commit/c9f8f249))

## [0.8.1] - 2025-12-09

- [busybox] Update image to d80cd69 (#709) ([68fc5f87](https://github.com/CloudPirates-io/helm-charts/commit/68fc5f87))

## [0.8.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7a](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7a))

## [0.7.10] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a55](https://github.com/CloudPirates-io/helm-charts/commit/87624a55))

## [0.7.9] - 2025-11-19

- [rabbitmq]: calculate memoryHighWatermark based on pods total memory instead of nodes total memory ([1a25f286](https://github.com/CloudPirates-io/helm-charts/commit/1a25f286))
- add values type for schema generation (#617) ([8633ab88](https://github.com/CloudPirates-io/helm-charts/commit/8633ab88))

## [0.7.8] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))
- Update charts/rabbitmq/values.yaml rabbitmq (#589) ([2a76df9b](https://github.com/CloudPirates-io/helm-charts/commit/2a76df9b))
- Update charts/rabbitmq/values.yaml rabbitmq (#580) ([bcf55139](https://github.com/CloudPirates-io/helm-charts/commit/bcf55139))

## [0.7.7] - 2025-11-07

- [rabbitmq]: Fix several inconsistencies ([673823a4](https://github.com/CloudPirates-io/helm-charts/commit/673823a4))

## [0.7.6] - 2025-11-01

- Update charts/rabbitmq/values.yaml rabbitmq (#523) ([a23a7315](https://github.com/CloudPirates-io/helm-charts/commit/a23a7315))

## [0.7.5] - 2025-10-30

- Update charts/rabbitmq/values.yaml rabbitmq (#509) ([532e1f58](https://github.com/CloudPirates-io/helm-charts/commit/532e1f58))

## [0.7.4] - 2025-10-30

- [busybox] Update image to e3652a0 (#497) ([db92f8f0](https://github.com/CloudPirates-io/helm-charts/commit/db92f8f0))

## [0.7.3] - 2025-10-29

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.0 (minor) (#480) ([dcef8f33](https://github.com/CloudPirates-io/helm-charts/commit/dcef8f33))

## [0.7.2] - 2025-10-29

- [busybox] Update image to fba0711 (#489) ([fb93a199](https://github.com/CloudPirates-io/helm-charts/commit/fb93a199))
- Update charts/rabbitmq/values.yaml rabbitmq to v4.1.5 (patch) (#479) ([090a6b0f](https://github.com/CloudPirates-io/helm-charts/commit/090a6b0f))

## [0.7.1] - 2025-10-28

- [etcd, rabbitmq, redis, zookeeper] add signature verification documentation to readme (#476) ([91c73105](https://github.com/CloudPirates-io/helm-charts/commit/91c73105))

## [0.7.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.6.1] - 2025-10-26

- Redis / Rabbitmq: add lifecyle hooks ([b2537768](https://github.com/CloudPirates-io/helm-charts/commit/b2537768))

## [0.6.0] - 2025-10-26

- Adding existing claim as a feature with PVC ([336c4fb9](https://github.com/CloudPirates-io/helm-charts/commit/336c4fb9))

## [0.5.5] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.5.4] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))

## [0.5.3] - 2025-10-17

- Update charts/rabbitmq/values.yaml rabbitmq (#401) ([d3645017](https://github.com/CloudPirates-io/helm-charts/commit/d3645017))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.5.2] - 2025-10-15

- [busybox] Update image to 2f590fc (#391) ([e215e3cf](https://github.com/CloudPirates-io/helm-charts/commit/e215e3cf))

## [0.5.1] - 2025-10-15

- rabbitmq - Add labeling to persistent volume claim template (#389) ([6ca30c98](https://github.com/CloudPirates-io/helm-charts/commit/6ca30c98))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.4.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.4.0] - 2025-10-13

- [rabbitmq]: Rabbitmq Loging + levels (#355) ([9c661bf0](https://github.com/CloudPirates-io/helm-charts/commit/9c661bf0))

## [0.3.7] - 2025-10-13

- use the same default readiness probes as bitnami chart (#356) ([5eac28e6](https://github.com/CloudPirates-io/helm-charts/commit/5eac28e6))

## [0.3.6] - 2025-10-10

- Update charts/rabbitmq/values.yaml rabbitmq (#339) ([1c06f2e1](https://github.com/CloudPirates-io/helm-charts/commit/1c06f2e1))
- add traffic distribution and option to source definitions from existingSecret (#334) ([af00fe0c](https://github.com/CloudPirates-io/helm-charts/commit/af00fe0c))

## [0.3.5] - 2025-10-10

- Update charts/rabbitmq/values.yaml rabbitmq (#321) ([986eff5a](https://github.com/CloudPirates-io/helm-charts/commit/986eff5a))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))

## [0.3.4] - 2025-10-09

- [redis , rabbitmq]: Add podAnnotations (#294) ([6d788697](https://github.com/CloudPirates-io/helm-charts/commit/6d788697))

## [0.3.3] - 2025-10-09

- [rabbitmq]: add option to handle definitions via chart (#286) ([54251311](https://github.com/CloudPirates-io/helm-charts/commit/54251311))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))
- [rabbitmq]: Fix auth disable erlang cookie (#248) ([9abf5478](https://github.com/CloudPirates-io/helm-charts/commit/9abf5478))

## [0.3.2] - 2025-10-09

- Feature/renovate fix (#256) ([0d364d0b](https://github.com/CloudPirates-io/helm-charts/commit/0d364d0b))

## [0.3.1] - 2025-10-06

- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 8c31e22 (#204) ([dd82ffee](https://github.com/CloudPirates-io/helm-charts/commit/dd82ffee))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))

## [0.3.0] - 2025-10-06

- make rabbitmq run on openshift (#201) ([df4deebc](https://github.com/CloudPirates-io/helm-charts/commit/df4deebc))

## [0.2.13] - 2025-10-02

- Add automatically generated fields to volumeClaimTemplates (#210) ([2c31a431](https://github.com/CloudPirates-io/helm-charts/commit/2c31a431))

## [0.2.12] - 2025-09-24

- docs(rabbitmq): update readme ([3006a9e5](https://github.com/CloudPirates-io/helm-charts/commit/3006a9e5))
- feat(rabbitmq): fix podLabels ([e5af6396](https://github.com/CloudPirates-io/helm-charts/commit/e5af6396))
- feat(rabbitmq): fix podLabels duplication ([ad3a30ba](https://github.com/CloudPirates-io/helm-charts/commit/ad3a30ba))
- feat(rabbit): add podLabels ([0bbb86c8](https://github.com/CloudPirates-io/helm-charts/commit/0bbb86c8))
- Update CHANGELOG.md ([b2893ca6](https://github.com/CloudPirates-io/helm-charts/commit/b2893ca6))
- chore: remove commonAnnotation ([2a9c6660](https://github.com/CloudPirates-io/helm-charts/commit/2a9c6660))
- chore: fix no new line character at the end of file ([0c4d0180](https://github.com/CloudPirates-io/helm-charts/commit/0c4d0180))
- Update CHANGELOG.md ([6f9ff216](https://github.com/CloudPirates-io/helm-charts/commit/6f9ff216))
- chore: fix no new line character at the end of file ([917d39ad](https://github.com/CloudPirates-io/helm-charts/commit/917d39ad))
- chore: fix spaces ([a0a3394c](https://github.com/CloudPirates-io/helm-charts/commit/a0a3394c))
- feat(rabbitmq): add new values for PDB, RBAC, ServiceAccount and STS ([b1506ca7](https://github.com/CloudPirates-io/helm-charts/commit/b1506ca7))
- feat(rabbitmq): add sts podManagementPolicy in value ([4ec745db](https://github.com/CloudPirates-io/helm-charts/commit/4ec745db))

## [0.2.11] - 2025-09-18

- Update CHANGELOG.md ([9be9185f](https://github.com/CloudPirates-io/helm-charts/commit/9be9185f))
- Bump chart version ([d26f2477](https://github.com/CloudPirates-io/helm-charts/commit/d26f2477))
- Update CHANGELOG.md ([61e7883d](https://github.com/CloudPirates-io/helm-charts/commit/61e7883d))
- Resolve merge conflicts ([6921f339](https://github.com/CloudPirates-io/helm-charts/commit/6921f339))
- Remove incorrectly pushed file ([b03c2308](https://github.com/CloudPirates-io/helm-charts/commit/b03c2308))
- Fix copy rabbitmq plugins ([9d1b0edd](https://github.com/CloudPirates-io/helm-charts/commit/9d1b0edd))

## [0.2.10] - 2025-09-18

- Update CHANGELOG.md ([cf7c15ea](https://github.com/CloudPirates-io/helm-charts/commit/cf7c15ea))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([05458987](https://github.com/CloudPirates-io/helm-charts/commit/05458987))
- Update CHANGELOG.md ([88006d09](https://github.com/CloudPirates-io/helm-charts/commit/88006d09))
- Update CHANGELOG.md ([1b168e68](https://github.com/CloudPirates-io/helm-charts/commit/1b168e68))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([94ff4bdd](https://github.com/CloudPirates-io/helm-charts/commit/94ff4bdd))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([bfbc729b](https://github.com/CloudPirates-io/helm-charts/commit/bfbc729b))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([ed381e06](https://github.com/CloudPirates-io/helm-charts/commit/ed381e06))

## [0.2.9] - 2025-09-18

- Update CHANGELOG.md ([5df0a6f2](https://github.com/CloudPirates-io/helm-charts/commit/5df0a6f2))
- Bump chart version ([e697ed59](https://github.com/CloudPirates-io/helm-charts/commit/e697ed59))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 85cb76f ([9d6e3c52](https://github.com/CloudPirates-io/helm-charts/commit/9d6e3c52))

## [0.2.8] - 2025-09-17

- Update CHANGELOG.md ([9354db5d](https://github.com/CloudPirates-io/helm-charts/commit/9354db5d))
- working ([0c29e1e1](https://github.com/CloudPirates-io/helm-charts/commit/0c29e1e1))

## [0.2.7] - 2025-09-16

- Update CHANGELOG.md ([cd341c87](https://github.com/CloudPirates-io/helm-charts/commit/cd341c87))
- Bump chart version ([9f722c51](https://github.com/CloudPirates-io/helm-charts/commit/9f722c51))
- [busybox] chore(deps): update docker.io/busybox:1.37.0 Docker digest to d82f458 ([a6990a6e](https://github.com/CloudPirates-io/helm-charts/commit/a6990a6e))

## [0.2.6] - 2025-09-16

- Update CHANGELOG.md ([60217566](https://github.com/CloudPirates-io/helm-charts/commit/60217566))
- Bump chart version ([81827c86](https://github.com/CloudPirates-io/helm-charts/commit/81827c86))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 2d92ad8 ([2afff899](https://github.com/CloudPirates-io/helm-charts/commit/2afff899))

## [0.2.5] - 2025-09-15

- Update CHANGELOG.md ([622f5c5e](https://github.com/CloudPirates-io/helm-charts/commit/622f5c5e))
- Bump Chart Version ([2be6653a](https://github.com/CloudPirates-io/helm-charts/commit/2be6653a))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 0f83c90 ([554ccc0d](https://github.com/CloudPirates-io/helm-charts/commit/554ccc0d))

## [0.2.4] - 2025-09-11

- Update CHANGELOG.md ([7c4f20f3](https://github.com/CloudPirates-io/helm-charts/commit/7c4f20f3))
- Bump chart version ([8e9f2118](https://github.com/CloudPirates-io/helm-charts/commit/8e9f2118))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to ba622d4 ([daeed6af](https://github.com/CloudPirates-io/helm-charts/commit/daeed6af))

## [0.2.3] - 2025-09-11

- Update CHANGELOG.md ([b579d1b1](https://github.com/CloudPirates-io/helm-charts/commit/b579d1b1))
- Bump chart version ([8637a3e4](https://github.com/CloudPirates-io/helm-charts/commit/8637a3e4))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 4788f7d ([1bdfe1c5](https://github.com/CloudPirates-io/helm-charts/commit/1bdfe1c5))

## [0.2.0] - 2025-09-10

- Update CHANGELOG.md ([7e42a1ed](https://github.com/CloudPirates-io/helm-charts/commit/7e42a1ed))
- feat: add support to automatically download and enable 3rd party plugins ([c677de3d](https://github.com/CloudPirates-io/helm-charts/commit/c677de3d))

## [0.1.7] - 2025-09-10

- Update CHANGELOG.md ([0d009c01](https://github.com/CloudPirates-io/helm-charts/commit/0d009c01))
- fix: add missing @ for sha image reference ([7abe06a4](https://github.com/CloudPirates-io/helm-charts/commit/7abe06a4))

## [0.1.6] - 2025-09-10

- Update CHANGELOG.md ([ab4655e4](https://github.com/CloudPirates-io/helm-charts/commit/ab4655e4))
- feat: add securityContext spec for the initContainer ([3c6ca133](https://github.com/CloudPirates-io/helm-charts/commit/3c6ca133))

## [0.1.5] - 2025-09-10

- Update CHANGELOG.md ([be6bf346](https://github.com/CloudPirates-io/helm-charts/commit/be6bf346))
- Bump version and sha ([0bf09251](https://github.com/CloudPirates-io/helm-charts/commit/0bf09251))
- Update CHANGELOG.md ([9112d4b4](https://github.com/CloudPirates-io/helm-charts/commit/9112d4b4))
- Bump chart version ([2cae2fb2](https://github.com/CloudPirates-io/helm-charts/commit/2cae2fb2))
- Implement fix ([33fecf87](https://github.com/CloudPirates-io/helm-charts/commit/33fecf87))

## [0.1.4] - 2025-09-09

- Update CHANGELOG.md ([ac217ce6](https://github.com/CloudPirates-io/helm-charts/commit/ac217ce6))
- fix: allow setting a clusterdomain different than the default ([963a8c58](https://github.com/CloudPirates-io/helm-charts/commit/963a8c58))

## [0.1.3] - 2025-09-09

- Reimplement chown ([d68af5ef](https://github.com/CloudPirates-io/helm-charts/commit/d68af5ef))
- Remove ownership change for .erlang.cookie ([723a45c3](https://github.com/CloudPirates-io/helm-charts/commit/723a45c3))
- Fix YAML syntax in statefulset.yaml ([ee881046](https://github.com/CloudPirates-io/helm-charts/commit/ee881046))
- Update CHANGELOG.md ([57947980](https://github.com/CloudPirates-io/helm-charts/commit/57947980))
- fix unit test ([80eba486](https://github.com/CloudPirates-io/helm-charts/commit/80eba486))
- Lintin works? ([0938b7cf](https://github.com/CloudPirates-io/helm-charts/commit/0938b7cf))
- Bump version ([9427e8d5](https://github.com/CloudPirates-io/helm-charts/commit/9427e8d5))
- Fix erlang cookie copy / access rights ([54c8ab83](https://github.com/CloudPirates-io/helm-charts/commit/54c8ab83))

## [0.1.2] - 2025-09-08

- Update CHANGELOG.md ([bcde9db9](https://github.com/CloudPirates-io/helm-charts/commit/bcde9db9))
- Update CHANGELOG.md ([a0217a19](https://github.com/CloudPirates-io/helm-charts/commit/a0217a19))
- Update version ([bb928b4d](https://github.com/CloudPirates-io/helm-charts/commit/bb928b4d))
- Update appVersion ([b7d28b01](https://github.com/CloudPirates-io/helm-charts/commit/b7d28b01))
- Update CHANGELOG.md ([59ea4e51](https://github.com/CloudPirates-io/helm-charts/commit/59ea4e51))
- Bump RabbitMQ to latests stable ([14d0222c](https://github.com/CloudPirates-io/helm-charts/commit/14d0222c))

## [0.1.1] - 2025-09-08

- Update CHANGELOG.md ([63b1299e](https://github.com/CloudPirates-io/helm-charts/commit/63b1299e))
- Fix erlang.cookie creation ([640e725e](https://github.com/CloudPirates-io/helm-charts/commit/640e725e))

## [0.1.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f90](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f90))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.0.3] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0a](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0a))
- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.0.2] - 2025-08-26

- Initial release

