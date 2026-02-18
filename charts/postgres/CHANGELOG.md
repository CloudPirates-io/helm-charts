# Changelog

All notable changes to this chart will be documented in this file.

## [0.15.6] - 2026-02-16

- Update charts/postgres/values.yaml postgres to v18.2 (minor) (#1010) ([87eedb14](https://github.com/CloudPirates-io/helm-charts/commit/87eedb14))

## [0.15.5] - 2026-02-05

- Update charts/postgres/values.yaml postgres (#965) ([74575d5d](https://github.com/CloudPirates-io/helm-charts/commit/74575d5d))

## [0.15.4] - 2026-02-05

- [prometheuscommunity/postgres-exporter] Update charts/postgres/values.yaml prometheuscommunity/postgres-exporter to v0.19.0 (minor) (#964) ([71a3caea](https://github.com/CloudPirates-io/helm-charts/commit/71a3caea))

## [0.15.3] - 2026-02-04

- Update charts/postgres/values.yaml postgres (#952) ([831f5cf9](https://github.com/CloudPirates-io/helm-charts/commit/831f5cf9))

## [0.15.2] - 2026-02-03

- Update charts/postgres/values.yaml postgres (#943) ([233141ef](https://github.com/CloudPirates-io/helm-charts/commit/233141ef))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.15.1] - 2026-02-02

- Improve configuration documentation (#926) ([88904109](https://github.com/CloudPirates-io/helm-charts/commit/88904109))

## [0.15.0] - 2026-01-29

- WAL replication support (#923) ([2ee34847](https://github.com/CloudPirates-io/helm-charts/commit/2ee34847))

## [0.14.6] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.14.5] - 2026-01-21

- Add support for volumeName (#878) ([6524a9b8](https://github.com/CloudPirates-io/helm-charts/commit/6524a9b8))

## [0.14.4] - 2026-01-20

- POSTGRES_DB is empty if auth.database is not overridden (#869) ([8fbbdc4f](https://github.com/CloudPirates-io/helm-charts/commit/8fbbdc4f))

## [0.14.3] - 2026-01-20

- Explicitly set database name when creating custom user (#868) ([5f9a7088](https://github.com/CloudPirates-io/helm-charts/commit/5f9a7088))

## [0.14.2] - 2026-01-19

- Update charts/postgres/values.yaml postgres (#835) ([6ec9835c](https://github.com/CloudPirates-io/helm-charts/commit/6ec9835c))

## [0.14.1] - 2026-01-17

- fix schema-typing for args in values (#848) ([3b2a8137](https://github.com/CloudPirates-io/helm-charts/commit/3b2a8137))

## [0.14.0] - 2026-01-14

- Add support for docker hardened images (#837) ([8a5b21a8](https://github.com/CloudPirates-io/helm-charts/commit/8a5b21a8))

## [0.13.8] - 2026-01-08

- Update image digest to bfe50b2 (#817) ([3f1807b1](https://github.com/CloudPirates-io/helm-charts/commit/3f1807b1))

## [0.13.7] - 2026-01-08

- Fix detection of major version for "-" suffixed tags (#799) ([8fada5b8](https://github.com/CloudPirates-io/helm-charts/commit/8fada5b8))

## [0.13.6] - 2025-12-16

-  Add terminationGracePeriodSeconds (#754) ([e8cb0c2d](https://github.com/CloudPirates-io/helm-charts/commit/e8cb0c2d))

## [0.13.5] - 2025-12-15

- Support pgvector image tags (#744) ([8a69448c](https://github.com/CloudPirates-io/helm-charts/commit/8a69448c))

## [0.13.4] - 2025-12-12

- Bump postgres chart version to 0.13.4 ([7173689f](https://github.com/CloudPirates-io/helm-charts/commit/7173689f))
- Update charts/postgres/values.yaml postgres (#726) ([fd08dc9c](https://github.com/CloudPirates-io/helm-charts/commit/fd08dc9c))
- Re-release postgresql 0.13.2 ([1e6e97b1](https://github.com/CloudPirates-io/helm-charts/commit/1e6e97b1))

## [0.13.3] - 2025-12-11

- Add support for password secret reference only (#719) ([c4ccbb09](https://github.com/CloudPirates-io/helm-charts/commit/c4ccbb09))

## [0.13.2] - 2025-12-09

- Fix non crashloopbackoff on broken scripts ([35a5175b](https://github.com/CloudPirates-io/helm-charts/commit/35a5175b))

## [0.13.1] - 2025-12-09

- Update charts/postgres/values.yaml postgres (#712) ([a266333d](https://github.com/CloudPirates-io/helm-charts/commit/a266333d))

## [0.13.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7a](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7a))

## [0.12.4] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a55](https://github.com/CloudPirates-io/helm-charts/commit/87624a55))

## [0.12.3] - 2025-12-01

- fix nesting of auth.secretKeys.adminPasswordKey (#674) ([ed4f3e3e](https://github.com/CloudPirates-io/helm-charts/commit/ed4f3e3e))

## [0.12.2] - 2025-11-26

- added support for priorityClassName (#662) (#663) ([9a33e0c9](https://github.com/CloudPirates-io/helm-charts/commit/9a33e0c9))
- Update charts/postgres/values.yaml postgres (#623) ([412f9b46](https://github.com/CloudPirates-io/helm-charts/commit/412f9b46))
- [postgres]: Use correct variable foe admin pasword / key ([c0c832a5](https://github.com/CloudPirates-io/helm-charts/commit/c0c832a5))
- Update charts/postgres/values.yaml postgres (#606) ([ad573178](https://github.com/CloudPirates-io/helm-charts/commit/ad573178))

## [0.12.1] - 2025-11-17

- [mongodb/redis/posgres] Add subPath option when using existingClaim (#613) ([8aa277e1](https://github.com/CloudPirates-io/helm-charts/commit/8aa277e1))

## [0.12.0] - 2025-11-14

- Update charts/postgres/values.yaml postgres to v18.1 (minor) (#597) ([8d6d622d](https://github.com/CloudPirates-io/helm-charts/commit/8d6d622d))

## [0.11.7] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))
- Update charts/postgres/values.yaml postgres (#555) ([c5f85375](https://github.com/CloudPirates-io/helm-charts/commit/c5f85375))

## [0.11.6] - 2025-11-10

- fix: allow not to mount config (#573) ([5dac5518](https://github.com/CloudPirates-io/helm-charts/commit/5dac5518))

## [0.11.5] - 2025-11-07

- Config for NodePort port (#561) ([bae2da0f](https://github.com/CloudPirates-io/helm-charts/commit/bae2da0f))

## [0.11.4] - 2025-11-05

- Fix logic in init-scripts ConfigMap (#551) ([90d61df7](https://github.com/CloudPirates-io/helm-charts/commit/90d61df7))

## [0.11.3] - 2025-11-04

- Update charts/postgres/values.yaml postgres (#546) ([cd62d69c](https://github.com/CloudPirates-io/helm-charts/commit/cd62d69c))

## [0.11.2] - 2025-11-04

- Update charts/postgres/values.yaml postgres (#541) ([a94dd224](https://github.com/CloudPirates-io/helm-charts/commit/a94dd224))

## [0.11.1] - 2025-10-31

- [postgres]: fix nesting for auth.username & auth.secretKeys.passwordKey (#513) ([7692045e](https://github.com/CloudPirates-io/helm-charts/commit/7692045e))

## [0.11.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.10.7] - 2025-10-27

- add options to set service load balancer ip and external traffic policy (#475) ([a2db2ab1](https://github.com/CloudPirates-io/helm-charts/commit/a2db2ab1))

## [0.10.6] - 2025-10-27

- Mount config map when existing configmap is provided (#472) ([f5d08a5b](https://github.com/CloudPirates-io/helm-charts/commit/f5d08a5b))

## [0.10.5] - 2025-10-26

- Update charts/postgres/values.yaml postgres (#451) ([45d78b09](https://github.com/CloudPirates-io/helm-charts/commit/45d78b09))

## [0.10.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.10.3] - 2025-10-23

- Update charts/postgres/values.yaml postgres (#448) ([fdf19cfd](https://github.com/CloudPirates-io/helm-charts/commit/fdf19cfd))

## [0.10.2] - 2025-10-22

- Update charts/postgres/values.yaml postgres (#426) ([ae721903](https://github.com/CloudPirates-io/helm-charts/commit/ae721903))

## [0.10.1] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))
- [universal] Feature/update appversion automatically (#423) ([43a5d2d2](https://github.com/CloudPirates-io/helm-charts/commit/43a5d2d2))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.10.0] - 2025-10-14

- Add support for `extraVolumes` and `extraVolumeMounts` (#387) ([ed17601b](https://github.com/CloudPirates-io/helm-charts/commit/ed17601b))

## [0.9.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.8.3] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.8.2] - 2025-10-12

- fix: add connection details to secret (#350) ([066d248b](https://github.com/CloudPirates-io/helm-charts/commit/066d248b))

## [0.8.1] - 2025-10-10

- merged initscript to avoid mount error, fixed quote from preloadlibrary and ajusted custom mount for init scripts (#297) ([e49d4786](https://github.com/CloudPirates-io/helm-charts/commit/e49d4786))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))

## [0.8.0] - 2025-10-09

- feat: add metrics exporter (#285) ([b9ba6427](https://github.com/CloudPirates-io/helm-charts/commit/b9ba6427))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))

## [0.7.3] - 2025-10-09

- [postgres]: Init container implementation (#246) ([054112ba](https://github.com/CloudPirates-io/helm-charts/commit/054112ba))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003ff](https://github.com/CloudPirates-io/helm-charts/commit/8a4003ff))

## [0.7.2] - 2025-10-02

- chore(deps): update docker.io/postgres:18.0 Docker digest to 073e7c8 (#172) ([f4b12f41](https://github.com/CloudPirates-io/helm-charts/commit/f4b12f41))

## [0.7.1] - 2025-10-02

- implement support for existingClaim (#212) ([805d3f8e](https://github.com/CloudPirates-io/helm-charts/commit/805d3f8e))

## [0.7.0] - 2025-09-30

- make postgres run on openshift (#184) ([0396895c](https://github.com/CloudPirates-io/helm-charts/commit/0396895c))

## [0.6.1] - 2025-09-29

- update default postgres config files (#180) ([63855123](https://github.com/CloudPirates-io/helm-charts/commit/63855123))
- [postgres]: Default config (#163) ([fc0da25f](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25f))

## [0.6.0] - 2025-09-26


## [0.5.5] - 2025-09-29

- [postgres]: Default config (#163) ([fc0da25f](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25f))
- [postgres]: Fix invalid data dir path on postgres 18 (#165) ([75928928](https://github.com/CloudPirates-io/helm-charts/commit/75928928))

## [0.5.4] - 2025-09-26

- chore(deps): update docker.io/postgres:17.6 Docker digest to 0b6428e (#161) ([19462968](https://github.com/CloudPirates-io/helm-charts/commit/19462968))

## [0.5.3] - 2025-09-25

- support custom pg_hba.conf (#157) ([9f3ceead](https://github.com/CloudPirates-io/helm-charts/commit/9f3ceead))

## [0.5.2] - 2025-09-24

- Update CHANGELOG.md ([7749bebb](https://github.com/CloudPirates-io/helm-charts/commit/7749bebb))
- bump chart version to 0.5.2 ([8c805720](https://github.com/CloudPirates-io/helm-charts/commit/8c805720))
- bump chart version to 0.5.3 ([337480c1](https://github.com/CloudPirates-io/helm-charts/commit/337480c1))
- Update CHANGELOG.md ([b1ce7c7b](https://github.com/CloudPirates-io/helm-charts/commit/b1ce7c7b))
- Update CHANGELOG.md ([7df85ea8](https://github.com/CloudPirates-io/helm-charts/commit/7df85ea8))
- fix: Change default name for CUSTOM_PASSWORD ([f7e74dd0](https://github.com/CloudPirates-io/helm-charts/commit/f7e74dd0))

## [0.5.1] - 2025-09-24

- Update CHANGELOG.md ([3ac95928](https://github.com/CloudPirates-io/helm-charts/commit/3ac95928))
- Update CHANGELOG.md ([574c9dcb](https://github.com/CloudPirates-io/helm-charts/commit/574c9dcb))
- Bump chart version ([29077967](https://github.com/CloudPirates-io/helm-charts/commit/29077967))
- chore(deps): update docker.io/postgres:17.6 Docker digest to 0f4f200 ([6f0746ad](https://github.com/CloudPirates-io/helm-charts/commit/6f0746ad))
- Update CHANGELOG.md ([9c7f3770](https://github.com/CloudPirates-io/helm-charts/commit/9c7f3770))

## [0.5.0] - 2025-09-18

- Update CHANGELOG.md ([ee72020b](https://github.com/CloudPirates-io/helm-charts/commit/ee72020b))
- add support for custom user at initialisation with password and database ([62d9d0dc](https://github.com/CloudPirates-io/helm-charts/commit/62d9d0dc))

## [0.4.0] - 2025-09-16

- add support for extra env vars from secret ([f6bb0dcd](https://github.com/CloudPirates-io/helm-charts/commit/f6bb0dcd))

## [0.3.0] - 2025-09-16

- Update CHANGELOG.md ([8baa18db](https://github.com/CloudPirates-io/helm-charts/commit/8baa18db))
- bump chartversion to 0.3.0 ([9e0454c8](https://github.com/CloudPirates-io/helm-charts/commit/9e0454c8))
- update env-vars, initialisation values, remove unused auth values ([11a6947c](https://github.com/CloudPirates-io/helm-charts/commit/11a6947c))
- Update CHANGELOG.md ([3e905575](https://github.com/CloudPirates-io/helm-charts/commit/3e905575))
- fix admin postgres-password env-variable ([7b89fa4f](https://github.com/CloudPirates-io/helm-charts/commit/7b89fa4f))

## [0.2.8] - 2025-09-15

- bump postgres ([4cc47f28](https://github.com/CloudPirates-io/helm-charts/commit/4cc47f28))
- chore: add support for passing extra environment variables ([0951fdcd](https://github.com/CloudPirates-io/helm-charts/commit/0951fdcd))

## [0.2.7] - 2025-09-15

- chore: add support for db initialization scripts ([96c8215e](https://github.com/CloudPirates-io/helm-charts/commit/96c8215e))

## [0.2.6] - 2025-09-15

- chore: bump version ([33105e95](https://github.com/CloudPirates-io/helm-charts/commit/33105e95))
- chore: add support for persistentVolumeClaimRetentionPolicy ([2f73cfb7](https://github.com/CloudPirates-io/helm-charts/commit/2f73cfb7))

## [0.2.5] - 2025-09-10

- Update CHANGELOG.md ([65522d27](https://github.com/CloudPirates-io/helm-charts/commit/65522d27))
- Bump chart version ([9bd67d6c](https://github.com/CloudPirates-io/helm-charts/commit/9bd67d6c))
- chore(deps): update docker.io/postgres:17.6 Docker digest to feff5b2 ([8b89eda1](https://github.com/CloudPirates-io/helm-charts/commit/8b89eda1))

## [0.2.4] - 2025-09-09

- Update CHANGELOG.md ([0a899188](https://github.com/CloudPirates-io/helm-charts/commit/0a899188))
- bump chart version ([fc9c5640](https://github.com/CloudPirates-io/helm-charts/commit/fc9c5640))
- chore(deps): update docker.io/postgres:17.6 Docker digest to 8a56bef ([3546801a](https://github.com/CloudPirates-io/helm-charts/commit/3546801a))

## [0.2.3] - 2025-09-09

- Update CHANGELOG.md ([b82862d7](https://github.com/CloudPirates-io/helm-charts/commit/b82862d7))
- Bump chart version ([492acc92](https://github.com/CloudPirates-io/helm-charts/commit/492acc92))
- Update docker.io/postgres:17.6 Docker digest to 29574e2 ([12267607](https://github.com/CloudPirates-io/helm-charts/commit/12267607))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.2.2] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.2.1] - 2025-08-26

- added support for service account configuration (#15) ([541a9dfa](https://github.com/CloudPirates-io/helm-charts/commit/541a9dfa))

## [0.2.0] - 2025-08-26

- Initial release

