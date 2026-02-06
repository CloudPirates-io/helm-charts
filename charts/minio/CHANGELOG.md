# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.0] - 2026-02-05

- [minio]: Switch to hardened image (#974) ([06609dc](https://github.com/CloudPirates-io/helm-charts/commit/06609dc))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.8.2] - 2026-01-29

- [minio]: Use wget instead of curl (#899) ([1b83954](https://github.com/CloudPirates-io/helm-charts/commit/1b83954))

## [0.8.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.8.0] - 2026-01-21

- use cloudpirates image (#870) ([bf069f6](https://github.com/CloudPirates-io/helm-charts/commit/bf069f6))

## [0.7.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.6.1] - 2026-01-01

- MinIO Bucket Init Job Improvements (#779) ([3cdf608](https://github.com/CloudPirates-io/helm-charts/commit/3cdf608))

## [0.6.0] - 2025-12-15

- Rename post job and add variables to configure it (#741) ([289cc4c](https://github.com/CloudPirates-io/helm-charts/commit/289cc4c))

## [0.5.7] - 2025-12-09

- add post-job helm-hook annotation, update readme (#706) ([64e36bd](https://github.com/CloudPirates-io/helm-charts/commit/64e36bd))

## [0.5.6] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))

## [0.5.5] - 2025-11-02

- Add NodePort support for API and Console in Service configuration (#527) ([57b84d8](https://github.com/CloudPirates-io/helm-charts/commit/57b84d8))

## [0.5.4] - 2025-10-27

- Remove securitycontext on empty obejct (#474) ([3c288c8](https://github.com/CloudPirates-io/helm-charts/commit/3c288c8))

## [0.5.3] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.5.2] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b2024](https://github.com/CloudPirates-io/helm-charts/commit/c2b2024))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))

## [0.5.1] - 2025-10-17

-  [minio] Fix bucketname trimming whitespaces in MinIO post-job configuration script. (#406) ([bf250e2](https://github.com/CloudPirates-io/helm-charts/commit/bf250e2))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.4.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))

## [0.4.0] - 2025-10-09

- add auto bucket creation through k8s job and option to create ServiceAccount for Deployment (#288) ([47d3947](https://github.com/CloudPirates-io/helm-charts/commit/47d3947))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/CloudPirates-io/helm-charts/commit/8a4003f))

## [0.3.0] - 2025-10-02

- make minio run on openshift (#203) ([18c7be5](https://github.com/CloudPirates-io/helm-charts/commit/18c7be5))

## [0.2.4] - 2025-09-30

- add more configuration options for the minio server (#189) ([8066d07](https://github.com/CloudPirates-io/helm-charts/commit/8066d07))

## [0.2.3] - 2025-09-15

- Update CHANGELOG.md ([55a987f](https://github.com/CloudPirates-io/helm-charts/commit/55a987f))
- bump verion to 0.2.3 ([af6beca](https://github.com/CloudPirates-io/helm-charts/commit/af6beca))
- set strategy to recreate in deployment ([6e01f97](https://github.com/CloudPirates-io/helm-charts/commit/6e01f97))

## [0.2.2] - 2025-09-15

- Update CHANGELOG.md ([f31d5a5](https://github.com/CloudPirates-io/helm-charts/commit/f31d5a5))
- update minio README.md ([cbca20c](https://github.com/CloudPirates-io/helm-charts/commit/cbca20c))
- bump version to 0.2.2 ([afaf2d1](https://github.com/CloudPirates-io/helm-charts/commit/afaf2d1))
- add option to use cpu-v1 image ([91bfd29](https://github.com/CloudPirates-io/helm-charts/commit/91bfd29))

## [0.2.1] - 2025-09-08

- Update CHANGELOG.md ([bb8e730](https://github.com/CloudPirates-io/helm-charts/commit/bb8e730))
- Update appVersion ([5c23cb1](https://github.com/CloudPirates-io/helm-charts/commit/5c23cb1))
- Update CHANGELOG.md ([82fe11f](https://github.com/CloudPirates-io/helm-charts/commit/82fe11f))
- Upgrade minio to latest stable ([94ab830](https://github.com/CloudPirates-io/helm-charts/commit/94ab830))
- revert 3 ([d8ced5c](https://github.com/CloudPirates-io/helm-charts/commit/d8ced5c))
- revert 2 ([b64c81d](https://github.com/CloudPirates-io/helm-charts/commit/b64c81d))
- Update CHANGELOG.md ([808cae0](https://github.com/CloudPirates-io/helm-charts/commit/808cae0))
- revert ([ba71354](https://github.com/CloudPirates-io/helm-charts/commit/ba71354))
- Upgrade minio to latest stable ([b199ea4](https://github.com/CloudPirates-io/helm-charts/commit/b199ea4))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.1.8] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.1.7] - 2025-08-26

- Initial release

