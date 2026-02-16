# Changelog

All notable changes to this chart will be documented in this file.

## [0.15.4] - 2026-02-05

- [prometheuscommunity/postgres-exporter] Update charts/postgres/values.yaml prometheuscommunity/postgres-exporter to v0.19.0 (minor) (#964) ([71a3cae](https://github.com/CloudPirates-io/helm-charts/commit/71a3cae))

## [0.15.3] - 2026-02-04

- Update charts/postgres/values.yaml postgres (#952) ([831f5cf](https://github.com/CloudPirates-io/helm-charts/commit/831f5cf))

## [0.15.2] - 2026-02-03

- Update charts/postgres/values.yaml postgres (#943) ([233141e](https://github.com/CloudPirates-io/helm-charts/commit/233141e))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.15.1] - 2026-02-02

- Improve configuration documentation (#926) ([8890410](https://github.com/CloudPirates-io/helm-charts/commit/8890410))

## [0.15.0] - 2026-01-29

- WAL replication support (#923) ([2ee3484](https://github.com/CloudPirates-io/helm-charts/commit/2ee3484))

## [0.14.6] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.14.5] - 2026-01-21

- Add support for volumeName (#878) ([6524a9b](https://github.com/CloudPirates-io/helm-charts/commit/6524a9b))

## [0.14.4] - 2026-01-20

- POSTGRES_DB is empty if auth.database is not overridden (#869) ([8fbbdc4](https://github.com/CloudPirates-io/helm-charts/commit/8fbbdc4))

## [0.14.3] - 2026-01-20

- Explicitly set database name when creating custom user (#868) ([5f9a708](https://github.com/CloudPirates-io/helm-charts/commit/5f9a708))

## [0.14.2] - 2026-01-19

- Update charts/postgres/values.yaml postgres (#835) ([6ec9835](https://github.com/CloudPirates-io/helm-charts/commit/6ec9835))

## [0.14.1] - 2026-01-17

- fix schema-typing for args in values (#848) ([3b2a813](https://github.com/CloudPirates-io/helm-charts/commit/3b2a813))

## [0.14.0] - 2026-01-14

- Add support for docker hardened images (#837) ([8a5b21a](https://github.com/CloudPirates-io/helm-charts/commit/8a5b21a))

## [0.13.8] - 2026-01-08

- Update image digest to bfe50b2 (#817) ([3f1807b](https://github.com/CloudPirates-io/helm-charts/commit/3f1807b))

## [0.13.7] - 2026-01-08

- Fix detection of major version for "-" suffixed tags (#799) ([8fada5b](https://github.com/CloudPirates-io/helm-charts/commit/8fada5b))

## [0.13.6] - 2025-12-16

-  Add terminationGracePeriodSeconds (#754) ([e8cb0c2](https://github.com/CloudPirates-io/helm-charts/commit/e8cb0c2))

## [0.13.5] - 2025-12-15

- Support pgvector image tags (#744) ([8a69448](https://github.com/CloudPirates-io/helm-charts/commit/8a69448))

## [0.13.4] - 2025-12-12

- Bump postgres chart version to 0.13.4 ([7173689](https://github.com/CloudPirates-io/helm-charts/commit/7173689))
- Update charts/postgres/values.yaml postgres (#726) ([fd08dc9](https://github.com/CloudPirates-io/helm-charts/commit/fd08dc9))
- Re-release postgresql 0.13.2 ([1e6e97b](https://github.com/CloudPirates-io/helm-charts/commit/1e6e97b))

## [0.13.3] - 2025-12-11

- Add support for password secret reference only (#719) ([c4ccbb0](https://github.com/CloudPirates-io/helm-charts/commit/c4ccbb0))

## [0.13.2] - 2025-12-09

- Fix non crashloopbackoff on broken scripts ([35a5175](https://github.com/CloudPirates-io/helm-charts/commit/35a5175))

## [0.13.1] - 2025-12-09

- Update charts/postgres/values.yaml postgres (#712) ([a266333](https://github.com/CloudPirates-io/helm-charts/commit/a266333))

## [0.13.0] - 2025-12-06

- [universal] fix statefulset pvc labels (#696) ([b87dbc7](https://github.com/CloudPirates-io/helm-charts/commit/b87dbc7))

## [0.12.4] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a5](https://github.com/CloudPirates-io/helm-charts/commit/87624a5))

## [0.12.3] - 2025-12-01

- fix nesting of auth.secretKeys.adminPasswordKey (#674) ([ed4f3e3](https://github.com/CloudPirates-io/helm-charts/commit/ed4f3e3))

## [0.12.2] - 2025-11-26

- added support for priorityClassName (#662) (#663) ([9a33e0c](https://github.com/CloudPirates-io/helm-charts/commit/9a33e0c))
- Update charts/postgres/values.yaml postgres (#623) ([412f9b4](https://github.com/CloudPirates-io/helm-charts/commit/412f9b4))
- [postgres]: Use correct variable foe admin pasword / key ([c0c832a](https://github.com/CloudPirates-io/helm-charts/commit/c0c832a))
- Update charts/postgres/values.yaml postgres (#606) ([ad57317](https://github.com/CloudPirates-io/helm-charts/commit/ad57317))

## [0.12.1] - 2025-11-17

- [mongodb/redis/posgres] Add subPath option when using existingClaim (#613) ([8aa277e](https://github.com/CloudPirates-io/helm-charts/commit/8aa277e))

## [0.12.0] - 2025-11-14

- Update charts/postgres/values.yaml postgres to v18.1 (minor) (#597) ([8d6d622](https://github.com/CloudPirates-io/helm-charts/commit/8d6d622))

## [0.11.7] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))
- Update charts/postgres/values.yaml postgres (#555) ([c5f8537](https://github.com/CloudPirates-io/helm-charts/commit/c5f8537))

## [0.11.6] - 2025-11-10

- fix: allow not to mount config (#573) ([5dac551](https://github.com/CloudPirates-io/helm-charts/commit/5dac551))

## [0.11.5] - 2025-11-07

- Config for NodePort port (#561) ([bae2da0](https://github.com/CloudPirates-io/helm-charts/commit/bae2da0))

## [0.11.4] - 2025-11-05

- Fix logic in init-scripts ConfigMap (#551) ([90d61df](https://github.com/CloudPirates-io/helm-charts/commit/90d61df))

## [0.11.3] - 2025-11-04

- Update charts/postgres/values.yaml postgres (#546) ([cd62d69](https://github.com/CloudPirates-io/helm-charts/commit/cd62d69))

## [0.11.2] - 2025-11-04

- Update charts/postgres/values.yaml postgres (#541) ([a94dd22](https://github.com/CloudPirates-io/helm-charts/commit/a94dd22))

## [0.11.1] - 2025-10-31

- [postgres]: fix nesting for auth.username & auth.secretKeys.passwordKey (#513) ([7692045](https://github.com/CloudPirates-io/helm-charts/commit/7692045))

## [0.11.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.10.7] - 2025-10-27

- add options to set service load balancer ip and external traffic policy (#475) ([a2db2ab](https://github.com/CloudPirates-io/helm-charts/commit/a2db2ab))

## [0.10.6] - 2025-10-27

- Mount config map when existing configmap is provided (#472) ([f5d08a5](https://github.com/CloudPirates-io/helm-charts/commit/f5d08a5))

## [0.10.5] - 2025-10-26

- Update charts/postgres/values.yaml postgres (#451) ([45d78b0](https://github.com/CloudPirates-io/helm-charts/commit/45d78b0))

## [0.10.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.10.3] - 2025-10-23

- Update charts/postgres/values.yaml postgres (#448) ([fdf19cf](https://github.com/CloudPirates-io/helm-charts/commit/fdf19cf))

## [0.10.2] - 2025-10-22

- Update charts/postgres/values.yaml postgres (#426) ([ae72190](https://github.com/CloudPirates-io/helm-charts/commit/ae72190))

## [0.10.1] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [universal] Feature/update appversion automatically (#423) ([43a5d2d](https://github.com/CloudPirates-io/helm-charts/commit/43a5d2d))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))

## [0.10.0] - 2025-10-14

- Add support for `extraVolumes` and `extraVolumeMounts` (#387) ([ed17601](https://github.com/CloudPirates-io/helm-charts/commit/ed17601))

## [0.9.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.8.3] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.8.2] - 2025-10-12

- fix: add connection details to secret (#350) ([066d248](https://github.com/CloudPirates-io/helm-charts/commit/066d248))

## [0.8.1] - 2025-10-10

- merged initscript to avoid mount error, fixed quote from preloadlibrary and ajusted custom mount for init scripts (#297) ([e49d478](https://github.com/CloudPirates-io/helm-charts/commit/e49d478))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))

## [0.8.0] - 2025-10-09

- feat: add metrics exporter (#285) ([b9ba642](https://github.com/CloudPirates-io/helm-charts/commit/b9ba642))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))

## [0.7.3] - 2025-10-09

- [postgres]: Init container implementation (#246) ([054112b](https://github.com/CloudPirates-io/helm-charts/commit/054112b))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/CloudPirates-io/helm-charts/commit/8a4003f))

## [0.7.2] - 2025-10-02

- chore(deps): update docker.io/postgres:18.0 Docker digest to 073e7c8 (#172) ([f4b12f4](https://github.com/CloudPirates-io/helm-charts/commit/f4b12f4))

## [0.7.1] - 2025-10-02

- implement support for existingClaim (#212) ([805d3f8](https://github.com/CloudPirates-io/helm-charts/commit/805d3f8))

## [0.7.0] - 2025-09-30

- make postgres run on openshift (#184) ([0396895](https://github.com/CloudPirates-io/helm-charts/commit/0396895))

## [0.6.1] - 2025-09-29

- update default postgres config files (#180) ([6385512](https://github.com/CloudPirates-io/helm-charts/commit/6385512))
- [postgres]: Default config (#163) ([fc0da25](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25))

## [0.6.0] - 2025-09-26


## [0.5.5] - 2025-09-29

- [postgres]: Default config (#163) ([fc0da25](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25))
- [postgres]: Fix invalid data dir path on postgres 18 (#165) ([7592892](https://github.com/CloudPirates-io/helm-charts/commit/7592892))

## [0.5.4] - 2025-09-26

- chore(deps): update docker.io/postgres:17.6 Docker digest to 0b6428e (#161) ([1946296](https://github.com/CloudPirates-io/helm-charts/commit/1946296))

## [0.5.3] - 2025-09-25

- support custom pg_hba.conf (#157) ([9f3ceea](https://github.com/CloudPirates-io/helm-charts/commit/9f3ceea))

## [0.5.2] - 2025-09-24

- Update CHANGELOG.md ([7749beb](https://github.com/CloudPirates-io/helm-charts/commit/7749beb))
- bump chart version to 0.5.2 ([8c80572](https://github.com/CloudPirates-io/helm-charts/commit/8c80572))
- bump chart version to 0.5.3 ([337480c](https://github.com/CloudPirates-io/helm-charts/commit/337480c))
- Update CHANGELOG.md ([b1ce7c7](https://github.com/CloudPirates-io/helm-charts/commit/b1ce7c7))
- Update CHANGELOG.md ([7df85ea](https://github.com/CloudPirates-io/helm-charts/commit/7df85ea))
- fix: Change default name for CUSTOM_PASSWORD ([f7e74dd](https://github.com/CloudPirates-io/helm-charts/commit/f7e74dd))

## [0.5.1] - 2025-09-24

- Update CHANGELOG.md ([3ac9592](https://github.com/CloudPirates-io/helm-charts/commit/3ac9592))
- Update CHANGELOG.md ([574c9dc](https://github.com/CloudPirates-io/helm-charts/commit/574c9dc))
- Bump chart version ([2907796](https://github.com/CloudPirates-io/helm-charts/commit/2907796))
- chore(deps): update docker.io/postgres:17.6 Docker digest to 0f4f200 ([6f0746a](https://github.com/CloudPirates-io/helm-charts/commit/6f0746a))
- Update CHANGELOG.md ([9c7f377](https://github.com/CloudPirates-io/helm-charts/commit/9c7f377))

## [0.5.0] - 2025-09-18

- Update CHANGELOG.md ([ee72020](https://github.com/CloudPirates-io/helm-charts/commit/ee72020))
- add support for custom user at initialisation with password and database ([62d9d0d](https://github.com/CloudPirates-io/helm-charts/commit/62d9d0d))

## [0.4.0] - 2025-09-16

- add support for extra env vars from secret ([f6bb0dc](https://github.com/CloudPirates-io/helm-charts/commit/f6bb0dc))

## [0.3.0] - 2025-09-16

- Update CHANGELOG.md ([8baa18d](https://github.com/CloudPirates-io/helm-charts/commit/8baa18d))
- bump chartversion to 0.3.0 ([9e0454c](https://github.com/CloudPirates-io/helm-charts/commit/9e0454c))
- update env-vars, initialisation values, remove unused auth values ([11a6947](https://github.com/CloudPirates-io/helm-charts/commit/11a6947))
- Update CHANGELOG.md ([3e90557](https://github.com/CloudPirates-io/helm-charts/commit/3e90557))
- fix admin postgres-password env-variable ([7b89fa4](https://github.com/CloudPirates-io/helm-charts/commit/7b89fa4))

## [0.2.8] - 2025-09-15

- bump postgres ([4cc47f2](https://github.com/CloudPirates-io/helm-charts/commit/4cc47f2))
- chore: add support for passing extra environment variables ([0951fdc](https://github.com/CloudPirates-io/helm-charts/commit/0951fdc))

## [0.2.7] - 2025-09-15

- chore: add support for db initialization scripts ([96c8215](https://github.com/CloudPirates-io/helm-charts/commit/96c8215))

## [0.2.6] - 2025-09-15

- chore: bump version ([33105e9](https://github.com/CloudPirates-io/helm-charts/commit/33105e9))
- chore: add support for persistentVolumeClaimRetentionPolicy ([2f73cfb](https://github.com/CloudPirates-io/helm-charts/commit/2f73cfb))

## [0.2.5] - 2025-09-10

- Update CHANGELOG.md ([65522d2](https://github.com/CloudPirates-io/helm-charts/commit/65522d2))
- Bump chart version ([9bd67d6](https://github.com/CloudPirates-io/helm-charts/commit/9bd67d6))
- chore(deps): update docker.io/postgres:17.6 Docker digest to feff5b2 ([8b89eda](https://github.com/CloudPirates-io/helm-charts/commit/8b89eda))

## [0.2.4] - 2025-09-09

- Update CHANGELOG.md ([0a89918](https://github.com/CloudPirates-io/helm-charts/commit/0a89918))
- bump chart version ([fc9c564](https://github.com/CloudPirates-io/helm-charts/commit/fc9c564))
- chore(deps): update docker.io/postgres:17.6 Docker digest to 8a56bef ([3546801](https://github.com/CloudPirates-io/helm-charts/commit/3546801))

## [0.2.3] - 2025-09-09

- Update CHANGELOG.md ([b82862d](https://github.com/CloudPirates-io/helm-charts/commit/b82862d))
- Bump chart version ([492acc9](https://github.com/CloudPirates-io/helm-charts/commit/492acc9))
- Update docker.io/postgres:17.6 Docker digest to 29574e2 ([1226760](https://github.com/CloudPirates-io/helm-charts/commit/1226760))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.2.2] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.2.1] - 2025-08-26

- added support for service account configuration (#15) ([541a9df](https://github.com/CloudPirates-io/helm-charts/commit/541a9df))

## [0.2.0] - 2025-08-26

- Initial release

