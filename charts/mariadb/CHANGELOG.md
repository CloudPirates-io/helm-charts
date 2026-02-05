# Changelog

All notable changes to this chart will be documented in this file.

## [0.13.3] - 2026-02-04

- [mariadb]: Fix both metric and initdb scripts in parallel (#960) ([2dc0439](../../commit/2dc0439))
- [all]: Update documentation to include proper cosign public key ([e42365d](../../commit/e42365d))
- Docs - correct Helm local install command (#932) ([c513c7a](../../commit/c513c7a))

## [0.13.2] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](../../commit/f8d134d))

## [0.13.1] - 2026-01-22

- [mariadb]: Implement network policies (#886) ([73ae9f8](../../commit/73ae9f8))

## [0.13.0] - 2026-01-21

- Add possibility to configure topologySpreadConstraints (#875) ([8fd1775](../../commit/8fd1775))

## [0.12.1] - 2026-01-19

- Update charts/mariadb/values.yaml mariadb (#853) ([238c925](../../commit/238c925))

## [0.12.0] - 2026-01-15

- [etcd,mariadb,rustfs,timescaledb,valkey] add existingClaim (#846) ([17e0af0](../../commit/17e0af0))

## [0.11.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](../../commit/b3d816f))

## [0.10.1] - 2025-12-15

- mariadb: dont enable metrics-exporter by default (#748) ([6e3d667](../../commit/6e3d667))

## [0.10.0] - 2025-12-12

- add metrics-exporter (#720) ([29c2378](../../commit/29c2378))

## [0.9.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](../../commit/b87dbc7))

## [0.8.1] - 2025-12-06

- Add template evaluation for initdbScriptsConfigMap (#697) ([56a2bb1](../../commit/56a2bb1))

## [0.8.0] - 2025-11-25

- Update charts/mariadb/values.yaml mariadb to v12.1.2 (minor) (#642) ([84a45fc](../../commit/84a45fc))

## [0.7.0] - 2025-11-18

- add support for serviceaccounts (#609) ([1e6d04f](../../commit/1e6d04f))
- Update charts/mariadb/values.yaml mariadb (#598) ([8ea69f6](../../commit/8ea69f6))

## [0.6.1] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](../../commit/e63f5f9))
- Update charts/mariadb/values.yaml mariadb (#579) ([dcf1d70](../../commit/dcf1d70))

## [0.6.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](../../commit/4aee7b4))

## [0.5.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](../../commit/cdb38db))

## [0.5.3] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](../../commit/c2b2024))

## [0.5.2] - 2025-10-21

- enhance stateful set with extra mounts (#420) ([d0bae40](../../commit/d0bae40))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](../../commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](../../commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](../../commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](../../commit/79d1439))

## [0.5.1] - 2025-10-15

- Bugfix/redis non cloudpirates prefix (#394) ([02e03ed](../../commit/02e03ed))

## [0.5.0] - 2025-10-14

- add galera cluster support for mariadb (#348) ([b7a63ee](../../commit/b7a63ee))

## [0.4.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](../../commit/87acfb1))

## [0.3.5] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](../../commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](../../commit/2e973c0))

## [0.3.4] - 2025-10-10

- Update charts/mariadb/values.yaml mariadb (#315) ([07101fe](../../commit/07101fe))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](../../commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](../../commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](../../commit/c931978))
- Hotfix schemas.json (#247) ([0900f81](../../commit/0900f81))

## [0.3.3] - 2025-10-08

- Add support for readOnlyRootFilesystem (#228) ([cdb58b2](../../commit/cdb58b2))

## [0.3.2] - 2025-10-06

- chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 03a03a6 (#207) ([e51e995](../../commit/e51e995))

## [0.3.1] - 2025-10-06

- use tpl to return existingConfigMap (#217) ([c7c2f4c](../../commit/c7c2f4c))

## [0.3.0] - 2025-09-29

- make mariadb run on openshift (#176) ([e2c3afb](../../commit/e2c3afb))

## [0.2.7] - 2025-09-16

- Update CHANGELOG.md ([bb96d54](../../commit/bb96d54))
- Bump chart version ([ea85028](../../commit/ea85028))
- chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 8a061ef ([ba48f7a](../../commit/ba48f7a))

## [0.2.6] - 2025-09-15

- Update CHANGELOG.md ([858838d](../../commit/858838d))
- fix pvc-labels ([aaf1b20](../../commit/aaf1b20))
- bump version to 0.2.6 ([51bcd26](../../commit/51bcd26))
- change statefulset pvc-template labels to not use common.labels ([780386b](../../commit/780386b))

## [0.2.5] - 2025-09-15

- Update CHANGELOG.md ([e5c8efd](../../commit/e5c8efd))
- fix statefulset pvc template ([b600627](../../commit/b600627))

## [0.2.4] - 2025-09-09

- Update CHANGELOG.md ([79570ff](../../commit/79570ff))
- Implement init script ([4b6ee98](../../commit/4b6ee98))
- Reverse version bump ([379dbfe](../../commit/379dbfe))

## [0.2.3] - 2025-09-09

- Update CHANGELOG.md ([7517a21](../../commit/7517a21))
- Bump MariaDB chart version to 0.2.3 ([10b1b7d](../../commit/10b1b7d))
- Bump chart version ([d2863aa](../../commit/d2863aa))
- Update docker.io/mariadb:12.0.2 Docker digest to a5af517 ([6322f06](../../commit/6322f06))

## [0.2.2] - 2025-09-08

- updated chart version ([f7b6496](../../commit/f7b6496))
- mariadb now respects full custom container security context settings memcached readme fixed, this option was not available ([770ea69](../../commit/770ea69))

## [0.2.1] - 2025-09-04

- Update CHANGELOG.md ([bcd1d8a](../../commit/bcd1d8a))
- add empty linting rule ([8be9283](../../commit/8be9283))
- Fix helpers.tpl ([201ecc7](../../commit/201ecc7))
- Update CHANGELOG.md ([9af2905](../../commit/9af2905))
- Implement default password ([c858a6b](../../commit/c858a6b))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](../../commit/aaa57f9))
- add extraObject array to all charts ([34772b7](../../commit/34772b7))

## [0.1.6] - 2025-08-27

- Fix linting for values.yaml ([504ac61](../../commit/504ac61))
- Fix values.yaml / Chart.yaml linting issues ([043c7e0](../../commit/043c7e0))
- Add initial Changelogs to all Charts ([68f10ca](../../commit/68f10ca))

## [0.1.5] - 2025-08-26

- Initial release

