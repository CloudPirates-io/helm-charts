# Changelog

All notable changes to this chart will be documented in this file.

## [cluster-operator-0.1.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))
- add option to set mountPath for data volume (#902) ([7d892f9](https://github.com/CloudPirates-io/helm-charts/commit/7d892f9))
- Add detailed metrics support (#804) (#901) ([96a74ac](https://github.com/CloudPirates-io/helm-charts/commit/96a74ac))
- [curlimages/curl] Update image to v8.18.0 (#890) ([9034613](https://github.com/CloudPirates-io/helm-charts/commit/9034613))
- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.3 (patch) (#891) ([6b77a8a](https://github.com/CloudPirates-io/helm-charts/commit/6b77a8a))
- [rabbitmq]: Sidecar container watching configmap (#873) ([b7a421a](https://github.com/CloudPirates-io/helm-charts/commit/b7a421a))
- [busybox] Update image to e226d63 (#884) ([7624bab](https://github.com/CloudPirates-io/helm-charts/commit/7624bab))
- [busybox] Update image to b86c79d (#882) ([4783a36](https://github.com/CloudPirates-io/helm-charts/commit/4783a36))
- Update charts/rabbitmq/values.yaml rabbitmq (#872) ([ce33816](https://github.com/CloudPirates-io/helm-charts/commit/ce33816))
- Update charts/rabbitmq/values.yaml rabbitmq (#856) ([2712d85](https://github.com/CloudPirates-io/helm-charts/commit/2712d85))

## [cluster-operator-0.1.4] - 2026-01-19

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))
- queuebalancing schema types (#831) ([f1f1fbf](https://github.com/CloudPirates-io/helm-charts/commit/f1f1fbf))
- queues not balanced #653 ([a9f6a5d](https://github.com/CloudPirates-io/helm-charts/commit/a9f6a5d))

## [cluster-operator-0.1.3] - 2026-01-09

- Update README.md : ha cluster config and chart update infos (#826) ([54caf60](https://github.com/CloudPirates-io/helm-charts/commit/54caf60))
- Update charts/rabbitmq/values.yaml rabbitmq (#821) ([11cd6b1](https://github.com/CloudPirates-io/helm-charts/commit/11cd6b1))
- [busybox] Update image to 2383baa (#818) ([83791f2](https://github.com/CloudPirates-io/helm-charts/commit/83791f2))
- queues not balanced #653 ([b3e74ad](https://github.com/CloudPirates-io/helm-charts/commit/b3e74ad))

## [cluster-operator-0.1.2] - 2026-01-05

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.2 (patch) (#760) ([3ddf1ed](https://github.com/CloudPirates-io/helm-charts/commit/3ddf1ed))

## [cluster-operator-0.1.1] - 2025-12-16

- Add externalTrafficPolicy and allocateLoadBalancerNodePorts to service spec (#730) ([22ec7fe](https://github.com/CloudPirates-io/helm-charts/commit/22ec7fe))
- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba))
- Add ServiceAccount automountServiceAccountToken configuration (#673) ([c9f8f24](https://github.com/CloudPirates-io/helm-charts/commit/c9f8f24))
- [busybox] Update image to d80cd69 (#709) ([68fc5f8](https://github.com/CloudPirates-io/helm-charts/commit/68fc5f8))
- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))
- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [cluster-operator-0.1.0] - 2025-12-01


## [0.15.7] - 2026-02-06

- Update charts/rabbitmq/values.yaml rabbitmq (#977) ([512735b](https://github.com/CloudPirates-io/helm-charts/commit/512735b))

## [0.15.6] - 2026-02-04

- [rabbitmq]: Update README to better reflect queue balancing ([174a964](https://github.com/CloudPirates-io/helm-charts/commit/174a964))
- Update charts/rabbitmq/values.yaml rabbitmq (#956) ([d8dad6e](https://github.com/CloudPirates-io/helm-charts/commit/d8dad6e))

## [0.15.5] - 2026-02-04

- The management.load_definitions is deprecated and we should use definitions.local.path now (#954) ([c35081b](https://github.com/CloudPirates-io/helm-charts/commit/c35081b))

## [0.15.4] - 2026-02-03

- [busybox] Update image to b3255e7 (#941) ([987aa3e](https://github.com/CloudPirates-io/helm-charts/commit/987aa3e))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.15.3] - 2026-01-30

- Fix template scope in installPlugins range block (#927) ([b4521bd](https://github.com/CloudPirates-io/helm-charts/commit/b4521bd))

## [0.15.2] - 2026-01-28

- Update charts/rabbitmq/values.yaml rabbitmq (#889) ([39f2c6c](https://github.com/CloudPirates-io/helm-charts/commit/39f2c6c))

## [0.15.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.15.0] - 2026-01-27

- add option to set mountPath for data volume (#902) ([7d892f9](https://github.com/CloudPirates-io/helm-charts/commit/7d892f9))

## [0.14.0] - 2026-01-26

- Add detailed metrics support (#804) (#901) ([96a74ac](https://github.com/CloudPirates-io/helm-charts/commit/96a74ac))

## [0.13.2] - 2026-01-26

- [curlimages/curl] Update image to v8.18.0 (#890) ([9034613](https://github.com/CloudPirates-io/helm-charts/commit/9034613))

## [0.13.1] - 2026-01-26

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.3 (patch) (#891) ([6b77a8a](https://github.com/CloudPirates-io/helm-charts/commit/6b77a8a))

## [0.13.0] - 2026-01-22

- [rabbitmq]: Sidecar container watching configmap (#873) ([b7a421a](https://github.com/CloudPirates-io/helm-charts/commit/b7a421a))

## [0.12.4] - 2026-01-22

- [busybox] Update image to e226d63 (#884) ([7624bab](https://github.com/CloudPirates-io/helm-charts/commit/7624bab))

## [0.12.3] - 2026-01-22

- [busybox] Update image to b86c79d (#882) ([4783a36](https://github.com/CloudPirates-io/helm-charts/commit/4783a36))

## [0.12.2] - 2026-01-21

- Update charts/rabbitmq/values.yaml rabbitmq (#872) ([ce33816](https://github.com/CloudPirates-io/helm-charts/commit/ce33816))

## [0.12.1] - 2026-01-19

- Update charts/rabbitmq/values.yaml rabbitmq (#856) ([2712d85](https://github.com/CloudPirates-io/helm-charts/commit/2712d85))

## [0.12.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.11.5] - 2026-01-12

- queuebalancing schema types (#831) ([f1f1fbf](https://github.com/CloudPirates-io/helm-charts/commit/f1f1fbf))

## [0.11.4] - 2026-01-10

- queues not balanced #653 ([a9f6a5d](https://github.com/CloudPirates-io/helm-charts/commit/a9f6a5d))

## [0.11.3] - 2026-01-09

- Update README.md : ha cluster config and chart update infos (#826) ([54caf60](https://github.com/CloudPirates-io/helm-charts/commit/54caf60))

## [0.11.2] - 2026-01-08

- Update charts/rabbitmq/values.yaml rabbitmq (#821) ([11cd6b1](https://github.com/CloudPirates-io/helm-charts/commit/11cd6b1))

## [0.11.1] - 2026-01-08

- [busybox] Update image to 2383baa (#818) ([83791f2](https://github.com/CloudPirates-io/helm-charts/commit/83791f2))

## [0.11.0] - 2026-01-08

- queues not balanced #653 ([b3e74ad](https://github.com/CloudPirates-io/helm-charts/commit/b3e74ad))

## [0.10.2] - 2025-12-22

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.2 (patch) (#760) ([3ddf1ed](https://github.com/CloudPirates-io/helm-charts/commit/3ddf1ed))

## [0.10.1] - 2025-12-12

- Add externalTrafficPolicy and allocateLoadBalancerNodePorts to service spec (#730) ([22ec7fe](https://github.com/CloudPirates-io/helm-charts/commit/22ec7fe))

## [0.10.0] - 2025-12-11

- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba))

## [0.9.0] - 2025-12-11

- Add ServiceAccount automountServiceAccountToken configuration (#673) ([c9f8f24](https://github.com/CloudPirates-io/helm-charts/commit/c9f8f24))

## [0.8.1] - 2025-12-09

- [busybox] Update image to d80cd69 (#709) ([68fc5f8](https://github.com/CloudPirates-io/helm-charts/commit/68fc5f8))

## [0.8.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))

## [0.7.10] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [0.7.9] - 2025-11-19

- [rabbitmq]: calculate memoryHighWatermark based on pods total memory instead of nodes total memory ([1a25f28](https://github.com/CloudPirates-io/helm-charts/commit/1a25f28))
- add values type for schema generation (#617) ([8633ab8](https://github.com/CloudPirates-io/helm-charts/commit/8633ab8))

## [0.7.8] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))
- Update charts/rabbitmq/values.yaml rabbitmq (#589) ([2a76df9](https://github.com/CloudPirates-io/helm-charts/commit/2a76df9))
- Update charts/rabbitmq/values.yaml rabbitmq (#580) ([bcf5513](https://github.com/CloudPirates-io/helm-charts/commit/bcf5513))

## [0.7.7] - 2025-11-07

- [rabbitmq]: Fix several inconsistencies ([673823a](https://github.com/CloudPirates-io/helm-charts/commit/673823a))

## [0.7.6] - 2025-11-01

- Update charts/rabbitmq/values.yaml rabbitmq (#523) ([a23a731](https://github.com/CloudPirates-io/helm-charts/commit/a23a731))

## [0.7.5] - 2025-10-30

- Update charts/rabbitmq/values.yaml rabbitmq (#509) ([532e1f5](https://github.com/CloudPirates-io/helm-charts/commit/532e1f5))

## [0.7.4] - 2025-10-30

- [busybox] Update image to e3652a0 (#497) ([db92f8f](https://github.com/CloudPirates-io/helm-charts/commit/db92f8f))

## [0.7.3] - 2025-10-29

- Update charts/rabbitmq/values.yaml rabbitmq to v4.2.0 (minor) (#480) ([dcef8f3](https://github.com/CloudPirates-io/helm-charts/commit/dcef8f3))

## [0.7.2] - 2025-10-29

- [busybox] Update image to fba0711 (#489) ([fb93a19](https://github.com/CloudPirates-io/helm-charts/commit/fb93a19))
- Update charts/rabbitmq/values.yaml rabbitmq to v4.1.5 (patch) (#479) ([090a6b0](https://github.com/CloudPirates-io/helm-charts/commit/090a6b0))

## [0.7.1] - 2025-10-28

- [etcd, rabbitmq, redis, zookeeper] add signature verification documentation to readme (#476) ([91c7310](https://github.com/CloudPirates-io/helm-charts/commit/91c7310))

## [0.7.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.6.1] - 2025-10-26

- Redis / Rabbitmq: add lifecyle hooks ([b253776](https://github.com/CloudPirates-io/helm-charts/commit/b253776))

## [0.6.0] - 2025-10-26

- Adding existing claim as a feature with PVC ([336c4fb](https://github.com/CloudPirates-io/helm-charts/commit/336c4fb))

## [0.5.5] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.5.4] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))

## [0.5.3] - 2025-10-17

- Update charts/rabbitmq/values.yaml rabbitmq (#401) ([d364501](https://github.com/CloudPirates-io/helm-charts/commit/d364501))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))

## [0.5.2] - 2025-10-15

- [busybox] Update image to 2f590fc (#391) ([e215e3c](https://github.com/CloudPirates-io/helm-charts/commit/e215e3c))

## [0.5.1] - 2025-10-15

- rabbitmq - Add labeling to persistent volume claim template (#389) ([6ca30c9](https://github.com/CloudPirates-io/helm-charts/commit/6ca30c9))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.4.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.4.0] - 2025-10-13

- [rabbitmq]: Rabbitmq Loging + levels (#355) ([9c661bf](https://github.com/CloudPirates-io/helm-charts/commit/9c661bf))

## [0.3.7] - 2025-10-13

- use the same default readiness probes as bitnami chart (#356) ([5eac28e](https://github.com/CloudPirates-io/helm-charts/commit/5eac28e))

## [0.3.6] - 2025-10-10

- Update charts/rabbitmq/values.yaml rabbitmq (#339) ([1c06f2e](https://github.com/CloudPirates-io/helm-charts/commit/1c06f2e))
- add traffic distribution and option to source definitions from existingSecret (#334) ([af00fe0](https://github.com/CloudPirates-io/helm-charts/commit/af00fe0))

## [0.3.5] - 2025-10-10

- Update charts/rabbitmq/values.yaml rabbitmq (#321) ([986eff5](https://github.com/CloudPirates-io/helm-charts/commit/986eff5))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))

## [0.3.4] - 2025-10-09

- [redis , rabbitmq]: Add podAnnotations (#294) ([6d78869](https://github.com/CloudPirates-io/helm-charts/commit/6d78869))

## [0.3.3] - 2025-10-09

- [rabbitmq]: add option to handle definitions via chart (#286) ([5425131](https://github.com/CloudPirates-io/helm-charts/commit/5425131))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))
- [rabbitmq]: Fix auth disable erlang cookie (#248) ([9abf547](https://github.com/CloudPirates-io/helm-charts/commit/9abf547))

## [0.3.2] - 2025-10-09

- Feature/renovate fix (#256) ([0d364d0](https://github.com/CloudPirates-io/helm-charts/commit/0d364d0))

## [0.3.1] - 2025-10-06

- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 8c31e22 (#204) ([dd82ffe](https://github.com/CloudPirates-io/helm-charts/commit/dd82ffe))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))

## [0.3.0] - 2025-10-06

- make rabbitmq run on openshift (#201) ([df4deeb](https://github.com/CloudPirates-io/helm-charts/commit/df4deeb))

## [0.2.13] - 2025-10-02

- Add automatically generated fields to volumeClaimTemplates (#210) ([2c31a43](https://github.com/CloudPirates-io/helm-charts/commit/2c31a43))

## [0.2.12] - 2025-09-24

- docs(rabbitmq): update readme ([3006a9e](https://github.com/CloudPirates-io/helm-charts/commit/3006a9e))
- feat(rabbitmq): fix podLabels ([e5af639](https://github.com/CloudPirates-io/helm-charts/commit/e5af639))
- feat(rabbitmq): fix podLabels duplication ([ad3a30b](https://github.com/CloudPirates-io/helm-charts/commit/ad3a30b))
- feat(rabbit): add podLabels ([0bbb86c](https://github.com/CloudPirates-io/helm-charts/commit/0bbb86c))
- Update CHANGELOG.md ([b2893ca](https://github.com/CloudPirates-io/helm-charts/commit/b2893ca))
- chore: remove commonAnnotation ([2a9c666](https://github.com/CloudPirates-io/helm-charts/commit/2a9c666))
- chore: fix no new line character at the end of file ([0c4d018](https://github.com/CloudPirates-io/helm-charts/commit/0c4d018))
- Update CHANGELOG.md ([6f9ff21](https://github.com/CloudPirates-io/helm-charts/commit/6f9ff21))
- chore: fix no new line character at the end of file ([917d39a](https://github.com/CloudPirates-io/helm-charts/commit/917d39a))
- chore: fix spaces ([a0a3394](https://github.com/CloudPirates-io/helm-charts/commit/a0a3394))
- feat(rabbitmq): add new values for PDB, RBAC, ServiceAccount and STS ([b1506ca](https://github.com/CloudPirates-io/helm-charts/commit/b1506ca))
- feat(rabbitmq): add sts podManagementPolicy in value ([4ec745d](https://github.com/CloudPirates-io/helm-charts/commit/4ec745d))

## [0.2.11] - 2025-09-18

- Update CHANGELOG.md ([9be9185](https://github.com/CloudPirates-io/helm-charts/commit/9be9185))
- Bump chart version ([d26f247](https://github.com/CloudPirates-io/helm-charts/commit/d26f247))
- Update CHANGELOG.md ([61e7883](https://github.com/CloudPirates-io/helm-charts/commit/61e7883))
- Resolve merge conflicts ([6921f33](https://github.com/CloudPirates-io/helm-charts/commit/6921f33))
- Remove incorrectly pushed file ([b03c230](https://github.com/CloudPirates-io/helm-charts/commit/b03c230))
- Fix copy rabbitmq plugins ([9d1b0ed](https://github.com/CloudPirates-io/helm-charts/commit/9d1b0ed))

## [0.2.10] - 2025-09-18

- Update CHANGELOG.md ([cf7c15e](https://github.com/CloudPirates-io/helm-charts/commit/cf7c15e))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([0545898](https://github.com/CloudPirates-io/helm-charts/commit/0545898))
- Update CHANGELOG.md ([88006d0](https://github.com/CloudPirates-io/helm-charts/commit/88006d0))
- Update CHANGELOG.md ([1b168e6](https://github.com/CloudPirates-io/helm-charts/commit/1b168e6))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([94ff4bd](https://github.com/CloudPirates-io/helm-charts/commit/94ff4bd))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([bfbc729](https://github.com/CloudPirates-io/helm-charts/commit/bfbc729))
- feat(rabbitmq): add support for extraPorts in Service and StatefulSet ([ed381e0](https://github.com/CloudPirates-io/helm-charts/commit/ed381e0))

## [0.2.9] - 2025-09-18

- Update CHANGELOG.md ([5df0a6f](https://github.com/CloudPirates-io/helm-charts/commit/5df0a6f))
- Bump chart version ([e697ed5](https://github.com/CloudPirates-io/helm-charts/commit/e697ed5))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 85cb76f ([9d6e3c5](https://github.com/CloudPirates-io/helm-charts/commit/9d6e3c5))

## [0.2.8] - 2025-09-17

- Update CHANGELOG.md ([9354db5](https://github.com/CloudPirates-io/helm-charts/commit/9354db5))
- working ([0c29e1e](https://github.com/CloudPirates-io/helm-charts/commit/0c29e1e))

## [0.2.7] - 2025-09-16

- Update CHANGELOG.md ([cd341c8](https://github.com/CloudPirates-io/helm-charts/commit/cd341c8))
- Bump chart version ([9f722c5](https://github.com/CloudPirates-io/helm-charts/commit/9f722c5))
- [busybox] chore(deps): update docker.io/busybox:1.37.0 Docker digest to d82f458 ([a6990a6](https://github.com/CloudPirates-io/helm-charts/commit/a6990a6))

## [0.2.6] - 2025-09-16

- Update CHANGELOG.md ([6021756](https://github.com/CloudPirates-io/helm-charts/commit/6021756))
- Bump chart version ([81827c8](https://github.com/CloudPirates-io/helm-charts/commit/81827c8))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 2d92ad8 ([2afff89](https://github.com/CloudPirates-io/helm-charts/commit/2afff89))

## [0.2.5] - 2025-09-15

- Update CHANGELOG.md ([622f5c5](https://github.com/CloudPirates-io/helm-charts/commit/622f5c5))
- Bump Chart Version ([2be6653](https://github.com/CloudPirates-io/helm-charts/commit/2be6653))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 0f83c90 ([554ccc0](https://github.com/CloudPirates-io/helm-charts/commit/554ccc0))

## [0.2.4] - 2025-09-11

- Update CHANGELOG.md ([7c4f20f](https://github.com/CloudPirates-io/helm-charts/commit/7c4f20f))
- Bump chart version ([8e9f211](https://github.com/CloudPirates-io/helm-charts/commit/8e9f211))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to ba622d4 ([daeed6a](https://github.com/CloudPirates-io/helm-charts/commit/daeed6a))

## [0.2.3] - 2025-09-11

- Update CHANGELOG.md ([b579d1b](https://github.com/CloudPirates-io/helm-charts/commit/b579d1b))
- Bump chart version ([8637a3e](https://github.com/CloudPirates-io/helm-charts/commit/8637a3e))
- chore(deps): update docker.io/rabbitmq:4.1.4-management Docker digest to 4788f7d ([1bdfe1c](https://github.com/CloudPirates-io/helm-charts/commit/1bdfe1c))

## [0.2.0] - 2025-09-10

- Update CHANGELOG.md ([7e42a1e](https://github.com/CloudPirates-io/helm-charts/commit/7e42a1e))
- feat: add support to automatically download and enable 3rd party plugins ([c677de3](https://github.com/CloudPirates-io/helm-charts/commit/c677de3))

## [0.1.7] - 2025-09-10

- Update CHANGELOG.md ([0d009c0](https://github.com/CloudPirates-io/helm-charts/commit/0d009c0))
- fix: add missing @ for sha image reference ([7abe06a](https://github.com/CloudPirates-io/helm-charts/commit/7abe06a))

## [0.1.6] - 2025-09-10

- Update CHANGELOG.md ([ab4655e](https://github.com/CloudPirates-io/helm-charts/commit/ab4655e))
- feat: add securityContext spec for the initContainer ([3c6ca13](https://github.com/CloudPirates-io/helm-charts/commit/3c6ca13))

## [0.1.5] - 2025-09-10

- Update CHANGELOG.md ([be6bf34](https://github.com/CloudPirates-io/helm-charts/commit/be6bf34))
- Bump version and sha ([0bf0925](https://github.com/CloudPirates-io/helm-charts/commit/0bf0925))
- Update CHANGELOG.md ([9112d4b](https://github.com/CloudPirates-io/helm-charts/commit/9112d4b))
- Bump chart version ([2cae2fb](https://github.com/CloudPirates-io/helm-charts/commit/2cae2fb))
- Implement fix ([33fecf8](https://github.com/CloudPirates-io/helm-charts/commit/33fecf8))

## [0.1.4] - 2025-09-09

- Update CHANGELOG.md ([ac217ce](https://github.com/CloudPirates-io/helm-charts/commit/ac217ce))
- fix: allow setting a clusterdomain different than the default ([963a8c5](https://github.com/CloudPirates-io/helm-charts/commit/963a8c5))

## [0.1.3] - 2025-09-09

- Reimplement chown ([d68af5e](https://github.com/CloudPirates-io/helm-charts/commit/d68af5e))
- Remove ownership change for .erlang.cookie ([723a45c](https://github.com/CloudPirates-io/helm-charts/commit/723a45c))
- Fix YAML syntax in statefulset.yaml ([ee88104](https://github.com/CloudPirates-io/helm-charts/commit/ee88104))
- Update CHANGELOG.md ([5794798](https://github.com/CloudPirates-io/helm-charts/commit/5794798))
- fix unit test ([80eba48](https://github.com/CloudPirates-io/helm-charts/commit/80eba48))
- Lintin works? ([0938b7c](https://github.com/CloudPirates-io/helm-charts/commit/0938b7c))
- Bump version ([9427e8d](https://github.com/CloudPirates-io/helm-charts/commit/9427e8d))
- Fix erlang cookie copy / access rights ([54c8ab8](https://github.com/CloudPirates-io/helm-charts/commit/54c8ab8))

## [0.1.2] - 2025-09-08

- Update CHANGELOG.md ([bcde9db](https://github.com/CloudPirates-io/helm-charts/commit/bcde9db))
- Update CHANGELOG.md ([a0217a1](https://github.com/CloudPirates-io/helm-charts/commit/a0217a1))
- Update version ([bb928b4](https://github.com/CloudPirates-io/helm-charts/commit/bb928b4))
- Update appVersion ([b7d28b0](https://github.com/CloudPirates-io/helm-charts/commit/b7d28b0))
- Update CHANGELOG.md ([59ea4e5](https://github.com/CloudPirates-io/helm-charts/commit/59ea4e5))
- Bump RabbitMQ to latests stable ([14d0222](https://github.com/CloudPirates-io/helm-charts/commit/14d0222))

## [0.1.1] - 2025-09-08

- Update CHANGELOG.md ([63b1299](https://github.com/CloudPirates-io/helm-charts/commit/63b1299))
- Fix erlang.cookie creation ([640e725](https://github.com/CloudPirates-io/helm-charts/commit/640e725))

## [0.1.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.0.3] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.0.2] - 2025-08-26

- Initial release

