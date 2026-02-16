# Changelog

All notable changes to this chart will be documented in this file.

## [0.10.4] - 2026-02-11

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.5 (patch) (#992) ([ab5a714](https://github.com/CloudPirates-io/helm-charts/commit/ab5a714))

## [0.10.3] - 2026-02-03

- [mongodb]: properly mount replicaset secret (#947) ([2d04bbb](https://github.com/CloudPirates-io/helm-charts/commit/2d04bbb))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.10.2] - 2026-01-29

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.4 (patch) (#922) ([81c610d](https://github.com/CloudPirates-io/helm-charts/commit/81c610d))

## [0.10.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.10.0] - 2026-01-22

- [mongodb]: introduce new value replicaSet.extraInit.disableTelemetry (#881) ([aa526cf](https://github.com/CloudPirates-io/helm-charts/commit/aa526cf))

## [0.9.2] - 2026-01-22

- [mongodb]: enable replicaSet.[key,keySecretName] (#880) ([5baa210](https://github.com/CloudPirates-io/helm-charts/commit/5baa210))

## [0.9.1] - 2026-01-19

- [mongo] Update charts/mongodb/values.yaml mongo (#855) ([c27a625](https://github.com/CloudPirates-io/helm-charts/commit/c27a625))

## [0.9.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.8.0] - 2026-01-13

- add replication architecture (#829) ([7845f5f](https://github.com/CloudPirates-io/helm-charts/commit/7845f5f))

## [0.7.1] - 2025-12-22

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.3 (patch) (#770) ([ce2ec34](https://github.com/CloudPirates-io/helm-charts/commit/ce2ec34))
- [mongo] Update charts/mongodb/values.yaml mongo (#717) ([b5a1e22](https://github.com/CloudPirates-io/helm-charts/commit/b5a1e22))

## [0.7.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))

## [0.6.6] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [0.6.5] - 2025-11-25

- [percona/mongodb_exporter] Update image to v0.47.2 (#656) ([e3cebb5](https://github.com/CloudPirates-io/helm-charts/commit/e3cebb5))

## [0.6.4] - 2025-11-20

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.2 (patch) (#640) ([a29d777](https://github.com/CloudPirates-io/helm-charts/commit/a29d777))

## [0.6.3] - 2025-11-17

- [mongodb/redis/posgres] Add subPath option when using existingClaim (#613) ([8aa277e](https://github.com/CloudPirates-io/helm-charts/commit/8aa277e))
- [mongo] Update charts/mongodb/values.yaml mongo (#599) ([3f5d30f](https://github.com/CloudPirates-io/helm-charts/commit/3f5d30f))

## [0.6.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))
- [mongo] Update charts/mongodb/values.yaml mongo (#588) ([a197ff8](https://github.com/CloudPirates-io/helm-charts/commit/a197ff8))

## [0.6.1] - 2025-10-29

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.1 (minor) (#488) ([9986888](https://github.com/CloudPirates-io/helm-charts/commit/9986888))

## [0.6.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))
- Update README.md (#468) ([26c7a1c](https://github.com/CloudPirates-io/helm-charts/commit/26c7a1c))

## [0.5.6] - 2025-10-26

- [mongo] Update charts/mongodb/values.yaml mongo (#460) ([f8dad75](https://github.com/CloudPirates-io/helm-charts/commit/f8dad75))

## [0.5.5] - 2025-10-24

- Allow to set custom command and args (#457) ([06d8f66](https://github.com/CloudPirates-io/helm-charts/commit/06d8f66))

## [0.5.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.5.3] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))

## [0.5.2] - 2025-10-22

- Fix no auth error in init script (#440) ([54b7221](https://github.com/CloudPirates-io/helm-charts/commit/54b7221))
- [universal] fix all appversions in charts (#417) ([b8debeb](https://github.com/CloudPirates-io/helm-charts/commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))

## [0.5.1] - 2025-10-15

- [mongo] Update charts/mongodb/values.yaml mongo (#392) ([6802f43](https://github.com/CloudPirates-io/helm-charts/commit/6802f43))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.4.2] - 2025-10-10

- [mongo] Update charts/mongodb/values.yaml mongo (#319) ([ecf445f](https://github.com/CloudPirates-io/helm-charts/commit/ecf445f))

## [0.4.1] - 2025-10-09

- fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))

## [0.4.0] - 2025-10-09

- feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))

## [0.3.3] - 2025-10-09

- makes configmap name dynamic (#279) ([6dd10a9](https://github.com/CloudPirates-io/helm-charts/commit/6dd10a9))

## [0.3.2] - 2025-10-09

- [mongo] Update charts/mongodb/values.yaml mongo to v8.0.15 (patch) (#262) ([2fc1f1a](https://github.com/CloudPirates-io/helm-charts/commit/2fc1f1a))

## [0.3.1] - 2025-10-08

- update values.schema.json (#242) ([f973e47](https://github.com/CloudPirates-io/helm-charts/commit/f973e47))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/CloudPirates-io/helm-charts/commit/8a4003f))

## [0.3.0] - 2025-10-02

- make mongodb run on openshift (#202) ([b654629](https://github.com/CloudPirates-io/helm-charts/commit/b654629))
- [redis] return fqdn for sentinel master lookup (#156) ([00b9882](https://github.com/CloudPirates-io/helm-charts/commit/00b9882))

## [0.2.0] - 2025-09-25

- add custom user creation at initialization (#153) ([772d18f](https://github.com/CloudPirates-io/helm-charts/commit/772d18f))

## [0.1.9] - 2025-09-16

- Update CHANGELOG.md ([72601e5](https://github.com/CloudPirates-io/helm-charts/commit/72601e5))
- Bump chart version ([77f76af](https://github.com/CloudPirates-io/helm-charts/commit/77f76af))
- [mongo] chore(deps): update docker.io/mongo:8.0.13 Docker digest to cf340b1 ([3fe0172](https://github.com/CloudPirates-io/helm-charts/commit/3fe0172))

## [0.1.8] - 2025-09-11

- Update CHANGELOG.md ([5c9f4d0](https://github.com/CloudPirates-io/helm-charts/commit/5c9f4d0))
- Bump chart version ([159ba82](https://github.com/CloudPirates-io/helm-charts/commit/159ba82))
- [mongo] chore(deps): update docker.io/mongo:8.0.13 Docker digest to 7acbcf3 ([37cb0a1](https://github.com/CloudPirates-io/helm-charts/commit/37cb0a1))

## [0.1.7] - 2025-09-09

- Update CHANGELOG.md ([3174cb2](https://github.com/CloudPirates-io/helm-charts/commit/3174cb2))
- Bump chart version ([98d3ee6](https://github.com/CloudPirates-io/helm-charts/commit/98d3ee6))
- Update docker.io/mongo:8.0.13 Docker digest to c750922 ([cbd41d9](https://github.com/CloudPirates-io/helm-charts/commit/cbd41d9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.1.6] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.1.5] - 2025-08-26

- Initial release

