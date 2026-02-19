# Changelog

All notable changes to this chart will be documented in this file.

## [0.12.2] - 2026-02-18

- [mongo] Update charts/mongodb/values.yaml mongo (#1031) ([f242e63e](https://github.com/CloudPirates-io/helm-charts/commit/f242e63e))

## [0.12.1] - 2026-02-17

- [mongodb]: Fix unauthed probes causing giant log files (#1027) ([a5325f24](https://github.com/CloudPirates-io/helm-charts/commit/a5325f24))

## [0.12.0] - 2026-02-17

- [mongodb]: Support sharded clusters (#1008) ([a56b3f11](https://github.com/CloudPirates-io/helm-charts/commit/a56b3f11))

## [0.11.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.10.5] - 2026-02-12

- [percona/mongodb_exporter] Update image to v0.48.0 (#995) ([046c7826](https://github.com/CloudPirates-io/helm-charts/commit/046c7826))

## [0.10.4] - 2026-02-11

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.5 (patch) (#992) ([ab5a7145](https://github.com/CloudPirates-io/helm-charts/commit/ab5a7145))

## [0.10.3] - 2026-02-03

- [mongodb]: properly mount replicaset secret (#947) ([2d04bbb4](https://github.com/CloudPirates-io/helm-charts/commit/2d04bbb4))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.10.2] - 2026-01-29

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.4 (patch) (#922) ([81c610df](https://github.com/CloudPirates-io/helm-charts/commit/81c610df))

## [0.10.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.10.0] - 2026-01-22

- [mongodb]: introduce new value replicaSet.extraInit.disableTelemetry (#881) ([aa526cf7](https://github.com/CloudPirates-io/helm-charts/commit/aa526cf7))

## [0.9.2] - 2026-01-22

- [mongodb]: enable replicaSet.[key,keySecretName] (#880) ([5baa2103](https://github.com/CloudPirates-io/helm-charts/commit/5baa2103))

## [0.9.1] - 2026-01-19

- [mongo] Update charts/mongodb/values.yaml mongo (#855) ([c27a6257](https://github.com/CloudPirates-io/helm-charts/commit/c27a6257))

## [0.9.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))

## [0.8.0] - 2026-01-13

- add replication architecture (#829) ([7845f5f9](https://github.com/CloudPirates-io/helm-charts/commit/7845f5f9))

## [0.7.1] - 2025-12-22

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.3 (patch) (#770) ([ce2ec348](https://github.com/CloudPirates-io/helm-charts/commit/ce2ec348))
- [mongo] Update charts/mongodb/values.yaml mongo (#717) ([b5a1e22e](https://github.com/CloudPirates-io/helm-charts/commit/b5a1e22e))

## [0.7.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7a](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7a))

## [0.6.6] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a55](https://github.com/CloudPirates-io/helm-charts/commit/87624a55))

## [0.6.5] - 2025-11-25

- [percona/mongodb_exporter] Update image to v0.47.2 (#656) ([e3cebb5a](https://github.com/CloudPirates-io/helm-charts/commit/e3cebb5a))

## [0.6.4] - 2025-11-20

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.2 (patch) (#640) ([a29d7777](https://github.com/CloudPirates-io/helm-charts/commit/a29d7777))

## [0.6.3] - 2025-11-17

- [mongodb/redis/posgres] Add subPath option when using existingClaim (#613) ([8aa277e1](https://github.com/CloudPirates-io/helm-charts/commit/8aa277e1))
- [mongo] Update charts/mongodb/values.yaml mongo (#599) ([3f5d30f7](https://github.com/CloudPirates-io/helm-charts/commit/3f5d30f7))

## [0.6.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))
- [mongo] Update charts/mongodb/values.yaml mongo (#588) ([a197ff84](https://github.com/CloudPirates-io/helm-charts/commit/a197ff84))

## [0.6.1] - 2025-10-29

- [mongo] Update charts/mongodb/values.yaml mongo to v8.2.1 (minor) (#488) ([9986888c](https://github.com/CloudPirates-io/helm-charts/commit/9986888c))

## [0.6.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))
- Update README.md (#468) ([26c7a1c7](https://github.com/CloudPirates-io/helm-charts/commit/26c7a1c7))

## [0.5.6] - 2025-10-26

- [mongo] Update charts/mongodb/values.yaml mongo (#460) ([f8dad75f](https://github.com/CloudPirates-io/helm-charts/commit/f8dad75f))

## [0.5.5] - 2025-10-24

- Allow to set custom command and args (#457) ([06d8f66d](https://github.com/CloudPirates-io/helm-charts/commit/06d8f66d))

## [0.5.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.5.3] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))

## [0.5.2] - 2025-10-22

- Fix no auth error in init script (#440) ([54b72215](https://github.com/CloudPirates-io/helm-charts/commit/54b72215))
- [universal] fix all appversions in charts (#417) ([b8debebf](https://github.com/CloudPirates-io/helm-charts/commit/b8debebf))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.5.1] - 2025-10-15

- [mongo] Update charts/mongodb/values.yaml mongo (#392) ([6802f435](https://github.com/CloudPirates-io/helm-charts/commit/6802f435))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.4.2] - 2025-10-10

- [mongo] Update charts/mongodb/values.yaml mongo (#319) ([ecf445f3](https://github.com/CloudPirates-io/helm-charts/commit/ecf445f3))

## [0.4.1] - 2025-10-09

- fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))

## [0.4.0] - 2025-10-09

- feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))

## [0.3.3] - 2025-10-09

- makes configmap name dynamic (#279) ([6dd10a98](https://github.com/CloudPirates-io/helm-charts/commit/6dd10a98))

## [0.3.2] - 2025-10-09

- [mongo] Update charts/mongodb/values.yaml mongo to v8.0.15 (patch) (#262) ([2fc1f1a9](https://github.com/CloudPirates-io/helm-charts/commit/2fc1f1a9))

## [0.3.1] - 2025-10-08

- update values.schema.json (#242) ([f973e47a](https://github.com/CloudPirates-io/helm-charts/commit/f973e47a))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003ff](https://github.com/CloudPirates-io/helm-charts/commit/8a4003ff))

## [0.3.0] - 2025-10-02

- make mongodb run on openshift (#202) ([b654629a](https://github.com/CloudPirates-io/helm-charts/commit/b654629a))
- [redis] return fqdn for sentinel master lookup (#156) ([00b9882f](https://github.com/CloudPirates-io/helm-charts/commit/00b9882f))

## [0.2.0] - 2025-09-25

- add custom user creation at initialization (#153) ([772d18f9](https://github.com/CloudPirates-io/helm-charts/commit/772d18f9))

## [0.1.9] - 2025-09-16

- Update CHANGELOG.md ([72601e5e](https://github.com/CloudPirates-io/helm-charts/commit/72601e5e))
- Bump chart version ([77f76afe](https://github.com/CloudPirates-io/helm-charts/commit/77f76afe))
- [mongo] chore(deps): update docker.io/mongo:8.0.13 Docker digest to cf340b1 ([3fe01724](https://github.com/CloudPirates-io/helm-charts/commit/3fe01724))

## [0.1.8] - 2025-09-11

- Update CHANGELOG.md ([5c9f4d01](https://github.com/CloudPirates-io/helm-charts/commit/5c9f4d01))
- Bump chart version ([159ba827](https://github.com/CloudPirates-io/helm-charts/commit/159ba827))
- [mongo] chore(deps): update docker.io/mongo:8.0.13 Docker digest to 7acbcf3 ([37cb0a13](https://github.com/CloudPirates-io/helm-charts/commit/37cb0a13))

## [0.1.7] - 2025-09-09

- Update CHANGELOG.md ([3174cb2c](https://github.com/CloudPirates-io/helm-charts/commit/3174cb2c))
- Bump chart version ([98d3ee6c](https://github.com/CloudPirates-io/helm-charts/commit/98d3ee6c))
- Update docker.io/mongo:8.0.13 Docker digest to c750922 ([cbd41d9a](https://github.com/CloudPirates-io/helm-charts/commit/cbd41d9a))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.1.6] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0a](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0a))
- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.1.5] - 2025-08-26

- Initial release

