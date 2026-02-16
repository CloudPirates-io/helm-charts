# Changelog

All notable changes to this chart will be documented in this file.

## [0.15.4] - 2026-02-12

- [oliver006/redis_exporter] Update charts/valkey/values.yaml oliver006/redis_exporter to v1.81.0 (minor) (#996) ([20245de](https://github.com/CloudPirates-io/helm-charts/commit/20245de))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.15.3] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.15.2] - 2026-01-27

- [oliver006/redis_exporter] Update charts/valkey/values.yaml oliver006/redis_exporter to v1.80.2 (patch) (#907) ([b8b2721](https://github.com/CloudPirates-io/helm-charts/commit/b8b2721))

## [0.15.1] - 2026-01-20

- Add registry configuration for Sentinel image (#866) ([e462527](https://github.com/CloudPirates-io/helm-charts/commit/e462527))

## [0.15.0] - 2026-01-15

- [etcd,mariadb,rustfs,timescaledb,valkey] add existingClaim (#846) ([17e0af0](https://github.com/CloudPirates-io/helm-charts/commit/17e0af0))

## [0.14.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.13.0] - 2025-12-11

- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba))

## [0.12.0] - 2025-12-10

- Port #615, #639, #701 & fix custom config never being used (#715) ([58035e4](https://github.com/CloudPirates-io/helm-charts/commit/58035e4))

## [0.11.1] - 2025-12-06

- [valkey/valkey] Update charts/valkey/values.yaml valkey/valkey (#694) ([beb428d](https://github.com/CloudPirates-io/helm-charts/commit/beb428d))

## [0.11.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))

## [0.10.3] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [0.10.2] - 2025-11-25

- [oliver006/redis_exporter] Update charts/valkey/values.yaml oliver006/redis_exporter to v1.80.1 (patch) (#647) ([fa2654b](https://github.com/CloudPirates-io/helm-charts/commit/fa2654b))

## [0.10.1] - 2025-11-25

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))

## [0.10.0] - 2025-11-07

- [valkey]: Support TLS ([3b0b609](https://github.com/CloudPirates-io/helm-charts/commit/3b0b609))

## [0.9.2] - 2025-11-03

- [valkey]: fix broken statement ([49a9fe9](https://github.com/CloudPirates-io/helm-charts/commit/49a9fe9))

## [0.9.1] - 2025-11-03

- [oliver006/redis_exporter] Update charts/valkey/values.yaml oliver006/redis_exporter to v1.80.0 (minor) (#531) ([57d1caf](https://github.com/CloudPirates-io/helm-charts/commit/57d1caf))

## [0.9.0] - 2025-10-31

- [valkey]: Valkey HA (#518) ([d8b1bbe](https://github.com/CloudPirates-io/helm-charts/commit/d8b1bbe))

## [0.8.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.7.1] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.7.0] - 2025-10-22

- [valkey/valkey] Update charts/valkey/values.yaml valkey/valkey to v9 (major) (#442) ([75276a8](https://github.com/CloudPirates-io/helm-charts/commit/75276a8))

## [0.6.2] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [universal] fix all appversions in charts (#417) ([b8debeb](https://github.com/CloudPirates-io/helm-charts/commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))

## [0.6.1] - 2025-10-17

- [oliver006/redis_exporter] Update charts/valkey/values.yaml oliver006/redis_exporter to v1.79.0 (minor) (#407) ([7c0e2b3](https://github.com/CloudPirates-io/helm-charts/commit/7c0e2b3))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.6.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.5.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.5.0] - 2025-10-10

- feat: add metrics exporter (#342) ([e6b474b](https://github.com/CloudPirates-io/helm-charts/commit/e6b474b))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))

## [0.4.1] - 2025-10-09

- [valkey/valkey] Update charts/valkey/values.yaml valkey/valkey to v8.1.4 (patch) (#266) ([b52fedf](https://github.com/CloudPirates-io/helm-charts/commit/b52fedf))

## [0.4.0] - 2025-10-06

- make valkey run on openshift (#206) ([b1f530c](https://github.com/CloudPirates-io/helm-charts/commit/b1f530c))
- [rabbitmq] make rabbitmq run on openshift (#201) ([df4deeb](https://github.com/CloudPirates-io/helm-charts/commit/df4deeb))

## [0.3.2] - 2025-09-16

- Update CHANGELOG.md ([3005f2f](https://github.com/CloudPirates-io/helm-charts/commit/3005f2f))
- Oops, wrong bump ([1d2fefa](https://github.com/CloudPirates-io/helm-charts/commit/1d2fefa))
- Fix scheduling directives with disabled persistance ([7485b37](https://github.com/CloudPirates-io/helm-charts/commit/7485b37))

## [0.3.1] - 2025-09-12

- Update CHANGELOG.md ([36da816](https://github.com/CloudPirates-io/helm-charts/commit/36da816))
- fix templating of `affinity`, `nodeSelector` and `tolerations` values ([e98c8ea](https://github.com/CloudPirates-io/helm-charts/commit/e98c8ea))

## [0.3.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.2.0] - 2025-09-02

- Update serviceaccount config to disable automatic creation, add missing ns ([77281c6](https://github.com/CloudPirates-io/helm-charts/commit/77281c6))
- Add support for serviceAccount ([16ac6b3](https://github.com/CloudPirates-io/helm-charts/commit/16ac6b3))

## [0.1.7] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.1.6] - 2025-08-26

- Initial release

