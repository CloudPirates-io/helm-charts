# Changelog

All notable changes to this chart will be documented in this file.

## [0.14.2] - 2026-02-19

- [mariadb]: Extra args for health check (#1007) ([70f25144](https://github.com/CloudPirates-io/helm-charts/commit/70f25144))

## [0.14.1] - 2026-02-18

- Update charts/mariadb/values.yaml mariadb (#1029) ([ec472dae](https://github.com/CloudPirates-io/helm-charts/commit/ec472dae))

## [0.14.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.13.6] - 2026-02-16

- Update charts/mariadb/values.yaml mariadb to v12.2.2 (minor) (#1012) ([63c73fd8](https://github.com/CloudPirates-io/helm-charts/commit/63c73fd8))

## [0.13.5] - 2026-02-11

- Update charts/mariadb/values.yaml mariadb (#989) ([8439ce69](https://github.com/CloudPirates-io/helm-charts/commit/8439ce69))

## [0.13.4] - 2026-02-04

- [mariadb]: Modifyable startup command (#961) ([7eec6722](https://github.com/CloudPirates-io/helm-charts/commit/7eec6722))

## [0.13.3] - 2026-02-04

- [mariadb]: Fix both metric and initdb scripts in parallel (#960) ([2dc0439a](https://github.com/CloudPirates-io/helm-charts/commit/2dc0439a))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))
- Docs - correct Helm local install command (#932) ([c513c7a5](https://github.com/CloudPirates-io/helm-charts/commit/c513c7a5))

## [0.13.2] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.13.1] - 2026-01-22

- [mariadb]: Implement network policies (#886) ([73ae9f88](https://github.com/CloudPirates-io/helm-charts/commit/73ae9f88))

## [0.13.0] - 2026-01-21

- Add possibility to configure topologySpreadConstraints (#875) ([8fd17758](https://github.com/CloudPirates-io/helm-charts/commit/8fd17758))

## [0.12.1] - 2026-01-19

- Update charts/mariadb/values.yaml mariadb (#853) ([238c9250](https://github.com/CloudPirates-io/helm-charts/commit/238c9250))

## [0.12.0] - 2026-01-15

- [etcd,mariadb,rustfs,timescaledb,valkey] add existingClaim (#846) ([17e0af0f](https://github.com/CloudPirates-io/helm-charts/commit/17e0af0f))

## [0.11.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))

## [0.10.1] - 2025-12-15

- mariadb: dont enable metrics-exporter by default (#748) ([6e3d667e](https://github.com/CloudPirates-io/helm-charts/commit/6e3d667e))

## [0.10.0] - 2025-12-12

- add metrics-exporter (#720) ([29c23782](https://github.com/CloudPirates-io/helm-charts/commit/29c23782))

## [0.9.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7a](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7a))

## [0.8.1] - 2025-12-06

- Add template evaluation for initdbScriptsConfigMap (#697) ([56a2bb1b](https://github.com/CloudPirates-io/helm-charts/commit/56a2bb1b))

## [0.8.0] - 2025-11-25

- Update charts/mariadb/values.yaml mariadb to v12.1.2 (minor) (#642) ([84a45fc7](https://github.com/CloudPirates-io/helm-charts/commit/84a45fc7))

## [0.7.0] - 2025-11-18

- add support for serviceaccounts (#609) ([1e6d04f1](https://github.com/CloudPirates-io/helm-charts/commit/1e6d04f1))
- Update charts/mariadb/values.yaml mariadb (#598) ([8ea69f61](https://github.com/CloudPirates-io/helm-charts/commit/8ea69f61))

## [0.6.1] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))
- Update charts/mariadb/values.yaml mariadb (#579) ([dcf1d702](https://github.com/CloudPirates-io/helm-charts/commit/dcf1d702))

## [0.6.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.5.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.5.3] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))

## [0.5.2] - 2025-10-21

- enhance stateful set with extra mounts (#420) ([d0bae40c](https://github.com/CloudPirates-io/helm-charts/commit/d0bae40c))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.5.1] - 2025-10-15

- Bugfix/redis non cloudpirates prefix (#394) ([02e03ed6](https://github.com/CloudPirates-io/helm-charts/commit/02e03ed6))

## [0.5.0] - 2025-10-14

- add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.4.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.3.5] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.3.4] - 2025-10-10

- Update charts/mariadb/values.yaml mariadb (#315) ([07101fe8](https://github.com/CloudPirates-io/helm-charts/commit/07101fe8))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))
- Hotfix schemas.json (#247) ([0900f817](https://github.com/CloudPirates-io/helm-charts/commit/0900f817))

## [0.3.3] - 2025-10-08

- Add support for readOnlyRootFilesystem (#228) ([cdb58b26](https://github.com/CloudPirates-io/helm-charts/commit/cdb58b26))

## [0.3.2] - 2025-10-06

- chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 03a03a6 (#207) ([e51e9952](https://github.com/CloudPirates-io/helm-charts/commit/e51e9952))

## [0.3.1] - 2025-10-06

- use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))

## [0.3.0] - 2025-09-29

- make mariadb run on openshift (#176) ([e2c3afb1](https://github.com/CloudPirates-io/helm-charts/commit/e2c3afb1))

## [0.2.7] - 2025-09-16

- Update CHANGELOG.md ([bb96d542](https://github.com/CloudPirates-io/helm-charts/commit/bb96d542))
- Bump chart version ([ea850282](https://github.com/CloudPirates-io/helm-charts/commit/ea850282))
- chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 8a061ef ([ba48f7af](https://github.com/CloudPirates-io/helm-charts/commit/ba48f7af))

## [0.2.6] - 2025-09-15

- Update CHANGELOG.md ([858838d5](https://github.com/CloudPirates-io/helm-charts/commit/858838d5))
- fix pvc-labels ([aaf1b20c](https://github.com/CloudPirates-io/helm-charts/commit/aaf1b20c))
- bump version to 0.2.6 ([51bcd26b](https://github.com/CloudPirates-io/helm-charts/commit/51bcd26b))
- change statefulset pvc-template labels to not use common.labels ([780386b3](https://github.com/CloudPirates-io/helm-charts/commit/780386b3))

## [0.2.5] - 2025-09-15

- Update CHANGELOG.md ([e5c8efdd](https://github.com/CloudPirates-io/helm-charts/commit/e5c8efdd))
- fix statefulset pvc template ([b6006276](https://github.com/CloudPirates-io/helm-charts/commit/b6006276))

## [0.2.4] - 2025-09-09

- Update CHANGELOG.md ([79570ffb](https://github.com/CloudPirates-io/helm-charts/commit/79570ffb))
- Implement init script ([4b6ee98d](https://github.com/CloudPirates-io/helm-charts/commit/4b6ee98d))
- Reverse version bump ([379dbfe3](https://github.com/CloudPirates-io/helm-charts/commit/379dbfe3))

## [0.2.3] - 2025-09-09

- Update CHANGELOG.md ([7517a218](https://github.com/CloudPirates-io/helm-charts/commit/7517a218))
- Bump MariaDB chart version to 0.2.3 ([10b1b7d1](https://github.com/CloudPirates-io/helm-charts/commit/10b1b7d1))
- Bump chart version ([d2863aaf](https://github.com/CloudPirates-io/helm-charts/commit/d2863aaf))
- Update docker.io/mariadb:12.0.2 Docker digest to a5af517 ([6322f065](https://github.com/CloudPirates-io/helm-charts/commit/6322f065))

## [0.2.2] - 2025-09-08

- updated chart version ([f7b64964](https://github.com/CloudPirates-io/helm-charts/commit/f7b64964))
- mariadb now respects full custom container security context settings memcached readme fixed, this option was not available ([770ea692](https://github.com/CloudPirates-io/helm-charts/commit/770ea692))

## [0.2.1] - 2025-09-04

- Update CHANGELOG.md ([bcd1d8a9](https://github.com/CloudPirates-io/helm-charts/commit/bcd1d8a9))
- add empty linting rule ([8be92830](https://github.com/CloudPirates-io/helm-charts/commit/8be92830))
- Fix helpers.tpl ([201ecc7f](https://github.com/CloudPirates-io/helm-charts/commit/201ecc7f))
- Update CHANGELOG.md ([9af29051](https://github.com/CloudPirates-io/helm-charts/commit/9af29051))
- Implement default password ([c858a6b5](https://github.com/CloudPirates-io/helm-charts/commit/c858a6b5))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f90](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f90))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.1.6] - 2025-08-27

- Fix linting for values.yaml ([504ac619](https://github.com/CloudPirates-io/helm-charts/commit/504ac619))
- Fix values.yaml / Chart.yaml linting issues ([043c7e0a](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0a))
- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.1.5] - 2025-08-26

- Initial release

