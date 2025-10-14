# Changelog


## 0.9.0 (2025-10-14)

* Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))
* chore: update CHANGELOG.md for merged changes ([84cf67b](https://github.com/CloudPirates-io/helm-charts/commit/84cf67b))
* chore: update CHANGELOG.md for all charts via manual trigger ([6974964](https://github.com/CloudPirates-io/helm-charts/commit/6974964))
* chore: update CHANGELOG.md for merged changes ([63b7bfa](https://github.com/CloudPirates-io/helm-charts/commit/63b7bfa))
* chore: update CHANGELOG.md for merged changes ([da69e0e](https://github.com/CloudPirates-io/helm-charts/commit/da69e0e))
* chore: update CHANGELOG.md for merged changes ([5da1b15](https://github.com/CloudPirates-io/helm-charts/commit/5da1b15))

## 0.8.3 (2025-10-13)


## 0.8.2 (2025-10-12)

* fix: add connection details to secret (#350) ([066d248](https://github.com/CloudPirates-io/helm-charts/commit/066d248))

## 0.8.1 (2025-10-10)

* merged initscript to avoid mount error, fixed quote from preloadlibrary and ajusted custom mount for init scripts (#297) ([e49d478](https://github.com/CloudPirates-io/helm-charts/commit/e49d478))

## 0.8.0 (2025-10-09)

* feat: add metrics exporter (#285) ([b9ba642](https://github.com/CloudPirates-io/helm-charts/commit/b9ba642))
* add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))

## 0.7.3 (2025-10-09)

* [postgres]: Init container implementation (#246) ([054112b](https://github.com/CloudPirates-io/helm-charts/commit/054112b))
*  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/CloudPirates-io/helm-charts/commit/8a4003f))

## 0.7.2 (2025-10-02)

* chore(deps): update docker.io/postgres:18.0 Docker digest to 073e7c8 (#172) ([f4b12f4](https://github.com/CloudPirates-io/helm-charts/commit/f4b12f4))

## 0.7.1 (2025-10-02)

* implement support for existingClaim (#212) ([805d3f8](https://github.com/CloudPirates-io/helm-charts/commit/805d3f8))

## 0.7.0 (2025-09-30)

* make postgres run on openshift (#184) ([0396895](https://github.com/CloudPirates-io/helm-charts/commit/0396895))

## 0.6.1 (2025-09-29)

* update default postgres config files (#180) ([6385512](https://github.com/CloudPirates-io/helm-charts/commit/6385512))
* [postgres]: Default config (#163) ([fc0da25](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25))

## 0.6.0 (2025-09-26)

* No changes recorded

## 0.5.5 (2025-09-29)

* [postgres]: Default config (#163) ([fc0da25](https://github.com/CloudPirates-io/helm-charts/commit/fc0da25))
* [postgres]: Fix invalid data dir path on postgres 18 (#165) ([7592892](https://github.com/CloudPirates-io/helm-charts/commit/7592892))

## 0.5.4 (2025-09-26)

* chore(deps): update docker.io/postgres:17.6 Docker digest to 0b6428e (#161) ([1946296](https://github.com/CloudPirates-io/helm-charts/commit/1946296))

## 0.5.3 (2025-09-25)

* support custom pg_hba.conf (#157) ([9f3ceea](https://github.com/CloudPirates-io/helm-charts/commit/9f3ceea))

## 0.5.2 (2025-09-24)

* Update CHANGELOG.md ([7749beb](https://github.com/CloudPirates-io/helm-charts/commit/7749beb))
* bump chart version to 0.5.2 ([8c80572](https://github.com/CloudPirates-io/helm-charts/commit/8c80572))
* bump chart version to 0.5.3 ([337480c](https://github.com/CloudPirates-io/helm-charts/commit/337480c))
* Update CHANGELOG.md ([b1ce7c7](https://github.com/CloudPirates-io/helm-charts/commit/b1ce7c7))
* Update CHANGELOG.md ([7df85ea](https://github.com/CloudPirates-io/helm-charts/commit/7df85ea))
* fix: Change default name for CUSTOM_PASSWORD ([f7e74dd](https://github.com/CloudPirates-io/helm-charts/commit/f7e74dd))

## 0.5.1 (2025-09-24)

* Update CHANGELOG.md ([3ac9592](https://github.com/CloudPirates-io/helm-charts/commit/3ac9592))
* Update CHANGELOG.md ([574c9dc](https://github.com/CloudPirates-io/helm-charts/commit/574c9dc))
* Bump chart version ([2907796](https://github.com/CloudPirates-io/helm-charts/commit/2907796))
* chore(deps): update docker.io/postgres:17.6 Docker digest to 0f4f200 ([6f0746a](https://github.com/CloudPirates-io/helm-charts/commit/6f0746a))
* Update CHANGELOG.md ([9c7f377](https://github.com/CloudPirates-io/helm-charts/commit/9c7f377))

## 0.5.0 (2025-09-18)

* Update CHANGELOG.md ([ee72020](https://github.com/CloudPirates-io/helm-charts/commit/ee72020))
* add support for custom user at initialisation with password and database ([62d9d0d](https://github.com/CloudPirates-io/helm-charts/commit/62d9d0d))

## 0.4.0 (2025-09-16)

* add support for extra env vars from secret ([f6bb0dc](https://github.com/CloudPirates-io/helm-charts/commit/f6bb0dc))

## 0.3.0 (2025-09-16)

* Update CHANGELOG.md ([8baa18d](https://github.com/CloudPirates-io/helm-charts/commit/8baa18d))
* bump chartversion to 0.3.0 ([9e0454c](https://github.com/CloudPirates-io/helm-charts/commit/9e0454c))
* update env-vars, initialisation values, remove unused auth values ([11a6947](https://github.com/CloudPirates-io/helm-charts/commit/11a6947))
* Update CHANGELOG.md ([3e90557](https://github.com/CloudPirates-io/helm-charts/commit/3e90557))
* fix admin postgres-password env-variable ([7b89fa4](https://github.com/CloudPirates-io/helm-charts/commit/7b89fa4))

## 0.2.8 (2025-09-15)

* bump postgres ([4cc47f2](https://github.com/CloudPirates-io/helm-charts/commit/4cc47f2))
* chore: add support for passing extra environment variables ([0951fdc](https://github.com/CloudPirates-io/helm-charts/commit/0951fdc))

## 0.2.7 (2025-09-15)

* chore: add support for db initialization scripts ([96c8215](https://github.com/CloudPirates-io/helm-charts/commit/96c8215))

## 0.2.6 (2025-09-15)

* chore: bump version ([33105e9](https://github.com/CloudPirates-io/helm-charts/commit/33105e9))
* chore: add support for persistentVolumeClaimRetentionPolicy ([2f73cfb](https://github.com/CloudPirates-io/helm-charts/commit/2f73cfb))

## 0.2.5 (2025-09-10)

* Update CHANGELOG.md ([65522d2](https://github.com/CloudPirates-io/helm-charts/commit/65522d2))
* Bump chart version ([9bd67d6](https://github.com/CloudPirates-io/helm-charts/commit/9bd67d6))
* chore(deps): update docker.io/postgres:17.6 Docker digest to feff5b2 ([8b89eda](https://github.com/CloudPirates-io/helm-charts/commit/8b89eda))

## 0.2.4 (2025-09-09)

* Update CHANGELOG.md ([0a89918](https://github.com/CloudPirates-io/helm-charts/commit/0a89918))
* bump chart version ([fc9c564](https://github.com/CloudPirates-io/helm-charts/commit/fc9c564))
* chore(deps): update docker.io/postgres:17.6 Docker digest to 8a56bef ([3546801](https://github.com/CloudPirates-io/helm-charts/commit/3546801))

## 0.2.3 (2025-09-09)

* Update CHANGELOG.md ([b82862d](https://github.com/CloudPirates-io/helm-charts/commit/b82862d))
* Bump chart version ([492acc9](https://github.com/CloudPirates-io/helm-charts/commit/492acc9))
* Update docker.io/postgres:17.6 Docker digest to 29574e2 ([1226760](https://github.com/CloudPirates-io/helm-charts/commit/1226760))
* add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## 0.2.2 (2025-08-27)

* Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## 0.2.1 (2025-08-26)

* added support for service account configuration (#15) ([541a9df](https://github.com/CloudPirates-io/helm-charts/commit/541a9df))

## 0.2.0 (2025-08-26)

* Initial tagged release
