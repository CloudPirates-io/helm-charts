# Changelog

All notable changes to this chart will be documented in this file.

## [0.14.4] - 2026-02-11

- Allow extra containers in the keycloak pod (#988) ([daf57f8](https://github.com/CloudPirates-io/helm-charts/commit/daf57f8))

## [0.14.3] - 2026-02-06

- [postgres] Update initContainers.waitForPostgres.repository to 1090bc3 (#966) ([1717514](https://github.com/CloudPirates-io/helm-charts/commit/1717514))

## [0.14.2] - 2026-02-04

- [postgres] Update initContainers.waitForPostgres.repository to v18 (#959) ([97c8f34](https://github.com/CloudPirates-io/helm-charts/commit/97c8f34))

## [0.14.1] - 2026-02-04

- [mariadb] Update initContainers.waitForMariadb.repository to v12.1.2 (#957) ([7542e66](https://github.com/CloudPirates-io/helm-charts/commit/7542e66))

## [0.14.0] - 2026-02-04

- [keycloak]: Align init container images with global registry, add resource configuration, and improve realm import handling (#946) ([4a70951](https://github.com/CloudPirates-io/helm-charts/commit/4a70951))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.13.6] - 2026-01-30

- [keycloak]: Allow prepending arguments to keycloak (#925) ([c536f47](https://github.com/CloudPirates-io/helm-charts/commit/c536f47))

## [0.13.5] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.13.4] - 2026-01-27

- [keycloak]: Allow empty database type string (#912) ([2244324](https://github.com/CloudPirates-io/helm-charts/commit/2244324))

## [0.13.3] - 2026-01-27

- [keycloak]: Remove unused secret (#911) ([8371cd1](https://github.com/CloudPirates-io/helm-charts/commit/8371cd1))

## [0.13.2] - 2026-01-26

- [keycloak]: Try to fix keycloak startup probe/s (#900) ([1cd74cb](https://github.com/CloudPirates-io/helm-charts/commit/1cd74cb))

## [0.13.1] - 2026-01-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.2 (patch) (#892) ([3899ff2](https://github.com/CloudPirates-io/helm-charts/commit/3899ff2))

## [0.13.0] - 2026-01-19

- [keycloak]: Add simultaneous support for http and https (#863) ([bb671a5](https://github.com/CloudPirates-io/helm-charts/commit/bb671a5))

## [0.12.0] - 2026-01-19

- [keycloak]: Move to stateful set (#859) ([76ed920](https://github.com/CloudPirates-io/helm-charts/commit/76ed920))

## [0.11.5] - 2026-01-19

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.1 (patch) (#860) ([8b8713d](https://github.com/CloudPirates-io/helm-charts/commit/8b8713d))

## [0.11.4] - 2026-01-08

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.5.0 (minor) (#823) ([7e1eb1c](https://github.com/CloudPirates-io/helm-charts/commit/7e1eb1c))

## [0.11.3] - 2025-12-04

- Apply preserveThemes and preserveProviders to the deployment for volume mounts (#689) ([58d54a8](https://github.com/CloudPirates-io/helm-charts/commit/58d54a8))

## [0.11.2] - 2025-12-01

- quote dnsnames for certificates (#678) ([1dde1f7](https://github.com/CloudPirates-io/helm-charts/commit/1dde1f7))

## [0.11.1] - 2025-12-01

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.7 (patch) (#664) ([3224ae7](https://github.com/CloudPirates-io/helm-charts/commit/3224ae7))

## [0.11.0] - 2025-11-26

- Fix/allow realm import on production mode (#668) ([be3939e](https://github.com/CloudPirates-io/helm-charts/commit/be3939e))

## [0.10.2] - 2025-11-26

- Use correct metrics path if httpRelativePath is set (#666) ([87276ae](https://github.com/CloudPirates-io/helm-charts/commit/87276ae))

## [0.10.1] - 2025-11-26

- Preserve themes and providers options (#660) ([1bf70b4](https://github.com/CloudPirates-io/helm-charts/commit/1bf70b4))

## [0.10.0] - 2025-11-25

- Add support for PriorityClass (#651) ([0aaf369](https://github.com/CloudPirates-io/helm-charts/commit/0aaf369))

## [0.9.1] - 2025-11-24

- [Keycloak[ improve subchart variables (#652) ([e1c50c6](https://github.com/CloudPirates-io/helm-charts/commit/e1c50c6))

## [0.9.0] - 2025-11-24

- Keycloak/subchart variables (#649) ([bb0520a](https://github.com/CloudPirates-io/helm-charts/commit/bb0520a))

## [0.8.8] - 2025-11-24

- Fix JDBC connection string when using mssql database (#643) (#644) ([639db93](https://github.com/CloudPirates-io/helm-charts/commit/639db93))
- fix: correct installation command in the  (#646) ([b88029b](https://github.com/CloudPirates-io/helm-charts/commit/b88029b))

## [0.8.7] - 2025-11-22

- Make resources apply to initContainers (#645) ([35f4ac3](https://github.com/CloudPirates-io/helm-charts/commit/35f4ac3))

## [0.8.6] - 2025-11-13

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.5 (patch) (#593) ([a4cfe0c](https://github.com/CloudPirates-io/helm-charts/commit/a4cfe0c))

## [0.8.5] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))

## [0.8.4] - 2025-11-11

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.4 (patch) (#563) ([c65d420](https://github.com/CloudPirates-io/helm-charts/commit/c65d420))

## [0.8.3] - 2025-11-11

- add truststoreExistingSecretKey, add truststorePassword to env-Vars (#574) ([9c97080](https://github.com/CloudPirates-io/helm-charts/commit/9c97080))

## [0.8.2] - 2025-11-05

- [keycloak]: Fix mariadb configuration (#544) ([6cec40c](https://github.com/CloudPirates-io/helm-charts/commit/6cec40c))

## [0.8.1] - 2025-11-02

- [keycloak]: Fix https settings in keycloak when disabling http (#530) ([b0c34f6](https://github.com/CloudPirates-io/helm-charts/commit/b0c34f6))

## [0.8.0] - 2025-10-30

- Provide empty mounts for themes and providers (#504) ([4d2f107](https://github.com/CloudPirates-io/helm-charts/commit/4d2f107))

## [0.7.1] - 2025-10-29

- fix: use metrics service targetPort configuration (#493) ([bd3cc53](https://github.com/CloudPirates-io/helm-charts/commit/bd3cc53))

## [0.7.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.6.8] - 2025-10-27

- add mssql support (#469) ([11cdbfb](https://github.com/CloudPirates-io/helm-charts/commit/11cdbfb))

## [0.6.7] - 2025-10-26

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.2 (patch) (#453) ([52a01c8](https://github.com/CloudPirates-io/helm-charts/commit/52a01c8))

## [0.6.6] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.6.5] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [universal] fix all appversions in charts (#417) ([b8debeb](https://github.com/CloudPirates-io/helm-charts/commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))

## [0.6.4] - 2025-10-17

- realm import (#402) ([4257b8b](https://github.com/CloudPirates-io/helm-charts/commit/4257b8b))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))

## [0.6.3] - 2025-10-17

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.1 (patch) (#400) ([c6f2ca2](https://github.com/CloudPirates-io/helm-charts/commit/c6f2ca2))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))

## [0.6.2] - 2025-10-14

- Add support for templating hostname and hostnameAdmin (#390) ([133f4d5](https://github.com/CloudPirates-io/helm-charts/commit/133f4d5))

## [0.6.1] - 2025-10-14

- [keycloak]: Implement TLS in keycloak (#373) ([04abaee](https://github.com/CloudPirates-io/helm-charts/commit/04abaee))

## [0.6.0] - 2025-10-14

- [universal] All charts use cloudpirates prefix (#378) ([7485c19](https://github.com/CloudPirates-io/helm-charts/commit/7485c19))

## [0.5.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))

## [0.5.0] - 2025-10-13

- feat: add metrics (#368) ([cf5aba0](https://github.com/CloudPirates-io/helm-charts/commit/cf5aba0))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.4.0] - 2025-10-10

- Import realm (#219) ([f7ff0cf](https://github.com/CloudPirates-io/helm-charts/commit/f7ff0cf))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))
- [keycloak]: Fix invalid documentation (#283) ([59f3d3c](https://github.com/CloudPirates-io/helm-charts/commit/59f3d3c))

## [0.3.2] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.4.0 (minor) (#270) ([b107e1b](https://github.com/CloudPirates-io/helm-charts/commit/b107e1b))

## [0.3.1] - 2025-10-09

- [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.3.5 (patch) (#261) ([360de40](https://github.com/CloudPirates-io/helm-charts/commit/360de40))

## [0.3.0] - 2025-10-08

- make keycloak run on openshift (#225) ([9b4f896](https://github.com/CloudPirates-io/helm-charts/commit/9b4f896))

## [0.2.1] - 2025-10-07

- default http relative path to '/' to fix argocd deployment (#221) ([bdb1946](https://github.com/CloudPirates-io/helm-charts/commit/bdb1946))

## [0.2.0] - 2025-10-06

- Add support for extra volumes, volumeMounts and initContainers (#215) ([16afcfe](https://github.com/CloudPirates-io/helm-charts/commit/16afcfe))

## [0.1.12] - 2025-10-06

- [mariadb] chore(deps): update mariadb:12.0.2 Docker digest to 03a03a6 (#208) ([01a6ad1](https://github.com/CloudPirates-io/helm-charts/commit/01a6ad1))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))

## [0.1.11] - 2025-10-06

- Allow keycloak to have a relative path (#216) ([0237457](https://github.com/CloudPirates-io/helm-charts/commit/0237457))

## [0.1.10] - 2025-10-02

- [postgres] chore(deps): update postgres:17.6 Docker digest to e6a4209 (#173) ([beb0b40](https://github.com/CloudPirates-io/helm-charts/commit/beb0b40))

## [0.1.9] - 2025-10-02

- add topologySpreadConstraints and trafficDistribution opti… (#209) ([c777fca](https://github.com/CloudPirates-io/helm-charts/commit/c777fca))

## [0.1.8] - 2025-09-30

- Feature/command customize (#186) ([a458e15](https://github.com/CloudPirates-io/helm-charts/commit/a458e15))

## [0.1.7] - 2025-09-29

- replace deprecated 'proxy' with new proxy parameters (#183) ([d850b7b](https://github.com/CloudPirates-io/helm-charts/commit/d850b7b))

## [0.1.6] - 2025-09-26

- [postgres] chore(deps): update postgres:17.6 Docker digest to 0b6428e (#162) ([6293612](https://github.com/CloudPirates-io/helm-charts/commit/6293612))

## [0.1.5] - 2025-09-25

- add support for extra env vars from an existing secret (#158) ([263604f](https://github.com/CloudPirates-io/helm-charts/commit/263604f))
- Update CHANGELOG.md ([b7572a8](https://github.com/CloudPirates-io/helm-charts/commit/b7572a8))
- Update CHANGELOG.md ([245f9b6](https://github.com/CloudPirates-io/helm-charts/commit/245f9b6))
- Update CHANGELOG.md ([0bf9f75](https://github.com/CloudPirates-io/helm-charts/commit/0bf9f75))

## [0.1.4] - 2025-09-24

- Update CHANGELOG.md ([03d476e](https://github.com/CloudPirates-io/helm-charts/commit/03d476e))
- Bump the correct thing ([35e7901](https://github.com/CloudPirates-io/helm-charts/commit/35e7901))
- [postgres] chore(deps): update postgres:17.6 Docker digest to 0f4f200 ([b4a6a30](https://github.com/CloudPirates-io/helm-charts/commit/b4a6a30))
- Update CHANGELOG.md ([20c19bb](https://github.com/CloudPirates-io/helm-charts/commit/20c19bb))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([68435aa](https://github.com/CloudPirates-io/helm-charts/commit/68435aa))
- Fix resolving template expressions in extraobjects ([12a1cb5](https://github.com/CloudPirates-io/helm-charts/commit/12a1cb5))

## [0.1.2] - 2025-09-22

- Update CHANGELOG.md ([b8adca8](https://github.com/CloudPirates-io/helm-charts/commit/b8adca8))
- Fix chart version bump ([aae07b1](https://github.com/CloudPirates-io/helm-charts/commit/aae07b1))
- Fix deprecated env vars warning ([50d9fa0](https://github.com/CloudPirates-io/helm-charts/commit/50d9fa0))

## [0.1.1] - 2025-09-19

- Update CHANGELOG.md ([62e51b9](https://github.com/CloudPirates-io/helm-charts/commit/62e51b9))
- add readme documentation and values.schema.json ([369448b](https://github.com/CloudPirates-io/helm-charts/commit/369448b))
- Update CHANGELOG.md ([54f725e](https://github.com/CloudPirates-io/helm-charts/commit/54f725e))
- Update CHANGELOG.md ([2ed9b3f](https://github.com/CloudPirates-io/helm-charts/commit/2ed9b3f))
- Update CHANGELOG.md ([2178148](https://github.com/CloudPirates-io/helm-charts/commit/2178148))

## [0.1.0] - 2025-09-17

- Initial release

