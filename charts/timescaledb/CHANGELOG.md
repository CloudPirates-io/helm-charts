# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.0] - 2026-01-29

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb to v2.25.0 (minor) (#924) ([998ff12](https://github.com/CloudPirates-io/helm-charts/commit/998ff12))

## [0.8.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.8.0] - 2026-01-15

- [etcd,mariadb,rustfs,timescaledb,valkey] add existingClaim (#846) ([17e0af0](https://github.com/CloudPirates-io/helm-charts/commit/17e0af0))

## [0.7.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.6.2] - 2026-01-08

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb (#822) ([adc651a](https://github.com/CloudPirates-io/helm-charts/commit/adc651a))

## [0.6.1] - 2025-12-06

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb to v2.24.0 (minor) (#686) ([98bfa73](https://github.com/CloudPirates-io/helm-charts/commit/98bfa73))

## [0.6.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))

## [0.5.4] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [0.5.3] - 2025-11-14

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb to v2.23.1 (patch) (#596) ([7c36cd1](https://github.com/CloudPirates-io/helm-charts/commit/7c36cd1))

## [0.5.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))

## [0.5.1] - 2025-10-30

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb to v2.23.0 (minor) (#498) ([af305d0](https://github.com/CloudPirates-io/helm-charts/commit/af305d0))

## [0.5.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.4.2] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.4.1] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [universal] Feature/update appversion automatically (#423) ([43a5d2d](https://github.com/CloudPirates-io/helm-charts/commit/43a5d2d))
- [universal] fix all appversions in charts (#417) ([b8debeb](https://github.com/CloudPirates-io/helm-charts/commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.4.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.3.2] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))

## [0.3.1] - 2025-10-09

- [timescale/timescaledb] Update charts/timescaledb/values.yaml timescale/timescaledb to v2.22.1 (patch) (#265) ([df11e54](https://github.com/CloudPirates-io/helm-charts/commit/df11e54))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/CloudPirates-io/helm-charts/commit/8a4003f))

## [0.3.0] - 2025-10-02

- make timescaledb run on openshift (#205) ([250b562](https://github.com/CloudPirates-io/helm-charts/commit/250b562))

## [0.2.2] - 2025-09-26

- [timescale/timescaledb] chore(deps): update docker.io/timescale/timescaledb:2.22.0-pg17 Docker digest to bd55a8c (#167) ([b8ca89e](https://github.com/CloudPirates-io/helm-charts/commit/b8ca89e))

## [0.2.1] - 2025-09-08

- Update CHANGELOG.md ([147c2f6](https://github.com/CloudPirates-io/helm-charts/commit/147c2f6))
- Update CHANGELOG.md ([de23d89](https://github.com/CloudPirates-io/helm-charts/commit/de23d89))
- Update appVersion ([377966d](https://github.com/CloudPirates-io/helm-charts/commit/377966d))
- Update CHANGELOG.md ([4d63d23](https://github.com/CloudPirates-io/helm-charts/commit/4d63d23))
- Bump Timescaledb to latests stable ([d096653](https://github.com/CloudPirates-io/helm-charts/commit/d096653))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.1.1] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.1.0] - 2025-08-26

- Initial release

