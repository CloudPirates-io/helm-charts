# Changelog

All notable changes to this chart will be documented in this file.

## [0.15.1] - 2026-02-18

- [mariadb] Update initContainers.waitForMariadb.repository to b1cb255 (#1030) ([270c00a1](https://github.com/CloudPirates-io/helm-charts/commit/270c00a1))

## [0.15.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.14.8] - 2026-02-16

- [mariadb] Update initContainers.waitForMariadb.repository to v12.2.2 (#1013) ([042b064c](https://github.com/CloudPirates-io/helm-charts/commit/042b064c))

## [0.14.7] - 2026-02-16

- [postgres] Update initContainers.waitForPostgres.repository to v18.2 (#1011) ([ec3a7dd9](https://github.com/CloudPirates-io/helm-charts/commit/ec3a7dd9))

## [0.14.6] - 2026-02-11

- [mariadb] Update initContainers.waitForMariadb.repository to e487701 (#990) ([951cd245](https://github.com/CloudPirates-io/helm-charts/commit/951cd245))

## [0.14.5] - 2026-02-11

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.3 (patch) (#991) ([81e423d0](https://github.com/CloudPirates-io/helm-charts/commit/81e423d0))

## [0.14.4] - 2026-02-11

- Allow extra containers in the keycloak pod (#988) ([daf57f89](https://github.com/CloudPirates-io/helm-charts/commit/daf57f89))

## [0.14.3] - 2026-02-06

- [postgres] Update initContainers.waitForPostgres.repository to 1090bc3 (#966) ([17175140](https://github.com/CloudPirates-io/helm-charts/commit/17175140))

## [0.14.2] - 2026-02-04

- [postgres] Update initContainers.waitForPostgres.repository to v18 (#959) ([97c8f340](https://github.com/CloudPirates-io/helm-charts/commit/97c8f340))

## [0.14.1] - 2026-02-04

- [mariadb] Update initContainers.waitForMariadb.repository to v12.1.2 (#957) ([7542e666](https://github.com/CloudPirates-io/helm-charts/commit/7542e666))

## [0.14.0] - 2026-02-04

- [keycloak]: Align init container images with global registry, add resource configuration, and improve realm import handling (#946) ([4a709517](https://github.com/CloudPirates-io/helm-charts/commit/4a709517))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.13.6] - 2026-01-30

- [keycloak]: Allow prepending arguments to keycloak (#925) ([c536f477](https://github.com/CloudPirates-io/helm-charts/commit/c536f477))

## [0.13.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.13.4] - 2026-01-27

- [keycloak]: Allow empty database type string (#912) ([22443246](https://github.com/CloudPirates-io/helm-charts/commit/22443246))

## [0.13.3] - 2026-01-27

- [keycloak]: Remove unused secret (#911) ([8371cd12](https://github.com/CloudPirates-io/helm-charts/commit/8371cd12))

## [0.13.2] - 2026-01-26

- [keycloak]: Try to fix keycloak startup probe/s (#900) ([1cd74cb1](https://github.com/CloudPirates-io/helm-charts/commit/1cd74cb1))

## [0.13.1] - 2026-01-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.2 (patch) (#892) ([3899ff2a](https://github.com/CloudPirates-io/helm-charts/commit/3899ff2a))

## [0.13.0] - 2026-01-19

- [keycloak]: Add simultaneous support for http and https (#863) ([bb671a54](https://github.com/CloudPirates-io/helm-charts/commit/bb671a54))

## [0.12.0] - 2026-01-19

- [keycloak]: Move to stateful set (#859) ([76ed920b](https://github.com/CloudPirates-io/helm-charts/commit/76ed920b))

## [0.11.5] - 2026-01-19

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.1 (patch) (#860) ([8b8713de](https://github.com/CloudPirates-io/helm-charts/commit/8b8713de))

## [0.11.4] - 2026-01-08

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.0 (minor) (#823) ([7e1eb1c3](https://github.com/CloudPirates-io/helm-charts/commit/7e1eb1c3))

## [0.11.3] - 2025-12-04

- Apply preserveThemes and preserveProviders to the deployment for volume mounts (#689) ([58d54a8e](https://github.com/CloudPirates-io/helm-charts/commit/58d54a8e))

## [0.11.2] - 2025-12-01

- quote dnsnames for certificates (#678) ([1dde1f74](https://github.com/CloudPirates-io/helm-charts/commit/1dde1f74))

## [0.11.1] - 2025-12-01

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.7 (patch) (#664) ([3224ae7e](https://github.com/CloudPirates-io/helm-charts/commit/3224ae7e))

## [0.11.0] - 2025-11-26

- Fix/allow realm import on production mode (#668) ([be3939e2](https://github.com/CloudPirates-io/helm-charts/commit/be3939e2))

## [0.10.2] - 2025-11-26

- Use correct metrics path if httpRelativePath is set (#666) ([87276ae0](https://github.com/CloudPirates-io/helm-charts/commit/87276ae0))

## [0.10.1] - 2025-11-26

- Preserve themes and providers options (#660) ([1bf70b43](https://github.com/CloudPirates-io/helm-charts/commit/1bf70b43))

## [0.10.0] - 2025-11-25

- Add support for PriorityClass (#651) ([0aaf369c](https://github.com/CloudPirates-io/helm-charts/commit/0aaf369c))

## [0.9.1] - 2025-11-24

- [Keycloak[ improve subchart variables (#652) ([e1c50c62](https://github.com/CloudPirates-io/helm-charts/commit/e1c50c62))

## [0.9.0] - 2025-11-24

- Keycloak/subchart variables (#649) ([bb0520ae](https://github.com/CloudPirates-io/helm-charts/commit/bb0520ae))

## [0.8.8] - 2025-11-24

- Fix JDBC connection string when using mssql database (#643) (#644) ([639db937](https://github.com/CloudPirates-io/helm-charts/commit/639db937))
- fix: correct installation command in the  (#646) ([b88029b1](https://github.com/CloudPirates-io/helm-charts/commit/b88029b1))

## [0.8.7] - 2025-11-22

- Make resources apply to initContainers (#645) ([35f4ac3d](https://github.com/CloudPirates-io/helm-charts/commit/35f4ac3d))

## [0.8.6] - 2025-11-13

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.5 (patch) (#593) ([a4cfe0cf](https://github.com/CloudPirates-io/helm-charts/commit/a4cfe0cf))

## [0.8.5] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))

## [0.8.4] - 2025-11-11

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.4 (patch) (#563) ([c65d420a](https://github.com/CloudPirates-io/helm-charts/commit/c65d420a))

## [0.8.3] - 2025-11-11

- add truststoreExistingSecretKey, add truststorePassword to env-Vars (#574) ([9c97080a](https://github.com/CloudPirates-io/helm-charts/commit/9c97080a))

## [0.8.2] - 2025-11-05

- [keycloak]: Fix mariadb configuration (#544) ([6cec40ce](https://github.com/CloudPirates-io/helm-charts/commit/6cec40ce))

## [0.8.1] - 2025-11-02

- [keycloak]: Fix https settings in keycloak when disabling http (#530) ([b0c34f63](https://github.com/CloudPirates-io/helm-charts/commit/b0c34f63))

## [0.8.0] - 2025-10-30

- Provide empty mounts for themes and providers (#504) ([4d2f107c](https://github.com/CloudPirates-io/helm-charts/commit/4d2f107c))

## [0.7.1] - 2025-10-29

- fix: use metrics service targetPort configuration (#493) ([bd3cc53c](https://github.com/CloudPirates-io/helm-charts/commit/bd3cc53c))

## [0.7.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.6.8] - 2025-10-27

- add mssql support (#469) ([11cdbfba](https://github.com/CloudPirates-io/helm-charts/commit/11cdbfba))

## [0.6.7] - 2025-10-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.2 (patch) (#453) ([52a01c81](https://github.com/CloudPirates-io/helm-charts/commit/52a01c81))

## [0.6.6] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.6.5] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))
- [universal] fix all appversions in charts (#417) ([b8debebf](https://github.com/CloudPirates-io/helm-charts/commit/b8debebf))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))

## [0.6.4] - 2025-10-17

- realm import (#402) ([4257b8b5](https://github.com/CloudPirates-io/helm-charts/commit/4257b8b5))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))

## [0.6.3] - 2025-10-17

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.1 (patch) (#400) ([c6f2ca2b](https://github.com/CloudPirates-io/helm-charts/commit/c6f2ca2b))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.6.2] - 2025-10-14

- Add support for templating hostname and hostnameAdmin (#390) ([133f4d52](https://github.com/CloudPirates-io/helm-charts/commit/133f4d52))

## [0.6.1] - 2025-10-14

- [keycloak]: Implement TLS in keycloak (#373) ([04abaee6](https://github.com/CloudPirates-io/helm-charts/commit/04abaee6))

## [0.6.0] - 2025-10-14

- [universal] All charts use cloudpirates prefix (#378) ([7485c190](https://github.com/CloudPirates-io/helm-charts/commit/7485c190))

## [0.5.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))

## [0.5.0] - 2025-10-13

- feat: add metrics (#368) ([cf5aba07](https://github.com/CloudPirates-io/helm-charts/commit/cf5aba07))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.4.0] - 2025-10-10

- Import realm (#219) ([f7ff0cf3](https://github.com/CloudPirates-io/helm-charts/commit/f7ff0cf3))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))
- [keycloak]: Fix invalid documentation (#283) ([59f3d3ce](https://github.com/CloudPirates-io/helm-charts/commit/59f3d3ce))

## [0.3.2] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.0 (minor) (#270) ([b107e1bc](https://github.com/CloudPirates-io/helm-charts/commit/b107e1bc))

## [0.3.1] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.3.5 (patch) (#261) ([360de40f](https://github.com/CloudPirates-io/helm-charts/commit/360de40f))

## [0.3.0] - 2025-10-08

- make keycloak run on openshift (#225) ([9b4f8961](https://github.com/CloudPirates-io/helm-charts/commit/9b4f8961))

## [0.2.1] - 2025-10-07

- default http relative path to '/' to fix argocd deployment (#221) ([bdb1946e](https://github.com/CloudPirates-io/helm-charts/commit/bdb1946e))

## [0.2.0] - 2025-10-06

- Add support for extra volumes, volumeMounts and initContainers (#215) ([16afcfe8](https://github.com/CloudPirates-io/helm-charts/commit/16afcfe8))

## [0.1.12] - 2025-10-06

- [mariadb] chore(deps): update mariadb:12.0.2 Docker digest to 03a03a6 (#208) ([01a6ad1c](https://github.com/CloudPirates-io/helm-charts/commit/01a6ad1c))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))

## [0.1.11] - 2025-10-06

- Allow keycloak to have a relative path (#216) ([02374578](https://github.com/CloudPirates-io/helm-charts/commit/02374578))

## [0.1.10] - 2025-10-02

- [postgres] chore(deps): update postgres:17.6 Docker digest to e6a4209 (#173) ([beb0b401](https://github.com/CloudPirates-io/helm-charts/commit/beb0b401))

## [0.1.9] - 2025-10-02

- add topologySpreadConstraints and trafficDistribution opti… (#209) ([c777fca0](https://github.com/CloudPirates-io/helm-charts/commit/c777fca0))

## [0.1.8] - 2025-09-30

- Feature/command customize (#186) ([a458e151](https://github.com/CloudPirates-io/helm-charts/commit/a458e151))

## [0.1.7] - 2025-09-29

- replace deprecated 'proxy' with new proxy parameters (#183) ([d850b7bf](https://github.com/CloudPirates-io/helm-charts/commit/d850b7bf))

## [0.1.6] - 2025-09-26

- [postgres] chore(deps): update postgres:17.6 Docker digest to 0b6428e (#162) ([6293612b](https://github.com/CloudPirates-io/helm-charts/commit/6293612b))

## [0.1.5] - 2025-09-25

- add support for extra env vars from an existing secret (#158) ([263604f9](https://github.com/CloudPirates-io/helm-charts/commit/263604f9))
- Update CHANGELOG.md ([b7572a82](https://github.com/CloudPirates-io/helm-charts/commit/b7572a82))
- Update CHANGELOG.md ([245f9b6f](https://github.com/CloudPirates-io/helm-charts/commit/245f9b6f))
- Update CHANGELOG.md ([0bf9f75f](https://github.com/CloudPirates-io/helm-charts/commit/0bf9f75f))

## [0.1.4] - 2025-09-24

- Update CHANGELOG.md ([03d476ea](https://github.com/CloudPirates-io/helm-charts/commit/03d476ea))
- Bump the correct thing ([35e7901a](https://github.com/CloudPirates-io/helm-charts/commit/35e7901a))
- [postgres] chore(deps): update postgres:17.6 Docker digest to 0f4f200 ([b4a6a304](https://github.com/CloudPirates-io/helm-charts/commit/b4a6a304))
- Update CHANGELOG.md ([20c19bbd](https://github.com/CloudPirates-io/helm-charts/commit/20c19bbd))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([68435aa2](https://github.com/CloudPirates-io/helm-charts/commit/68435aa2))
- Fix resolving template expressions in extraobjects ([12a1cb5f](https://github.com/CloudPirates-io/helm-charts/commit/12a1cb5f))

## [0.1.2] - 2025-09-22

- Update CHANGELOG.md ([b8adca8c](https://github.com/CloudPirates-io/helm-charts/commit/b8adca8c))
- Fix chart version bump ([aae07b13](https://github.com/CloudPirates-io/helm-charts/commit/aae07b13))
- Fix deprecated env vars warning ([50d9fa07](https://github.com/CloudPirates-io/helm-charts/commit/50d9fa07))

## [0.1.1] - 2025-09-19

- Update CHANGELOG.md ([62e51b9d](https://github.com/CloudPirates-io/helm-charts/commit/62e51b9d))
- add readme documentation and values.schema.json ([369448b0](https://github.com/CloudPirates-io/helm-charts/commit/369448b0))
- Update CHANGELOG.md ([54f725e5](https://github.com/CloudPirates-io/helm-charts/commit/54f725e5))
- Update CHANGELOG.md ([2ed9b3f0](https://github.com/CloudPirates-io/helm-charts/commit/2ed9b3f0))
- Update CHANGELOG.md ([21781482](https://github.com/CloudPirates-io/helm-charts/commit/21781482))

## [0.1.0] - 2025-09-17

- Initial release

