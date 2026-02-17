# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.2] - 2026-02-12

- [minio]: Add fsGroupChangePolicy (#1002) ([4a1db204](https://github.com/CloudPirates-io/helm-charts/commit/4a1db204))

## [0.9.1] - 2026-02-12

- [cloudpirates/image-minio] Update image to 11e00b6 (#1003) ([6651fc8b](https://github.com/CloudPirates-io/helm-charts/commit/6651fc8b))

## [0.9.0] - 2026-02-05

- [minio]: Switch to hardened image (#974) ([06609dcc](https://github.com/CloudPirates-io/helm-charts/commit/06609dcc))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.8.2] - 2026-01-29

- [minio]: Use wget instead of curl (#899) ([1b839542](https://github.com/CloudPirates-io/helm-charts/commit/1b839542))

## [0.8.1] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.8.0] - 2026-01-21

- use cloudpirates image (#870) ([bf069f6d](https://github.com/CloudPirates-io/helm-charts/commit/bf069f6d))

## [0.7.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))

## [0.6.1] - 2026-01-01

- MinIO Bucket Init Job Improvements (#779) ([3cdf608d](https://github.com/CloudPirates-io/helm-charts/commit/3cdf608d))

## [0.6.0] - 2025-12-15

- Rename post job and add variables to configure it (#741) ([289cc4cb](https://github.com/CloudPirates-io/helm-charts/commit/289cc4cb))

## [0.5.7] - 2025-12-09

- add post-job helm-hook annotation, update readme (#706) ([64e36bdb](https://github.com/CloudPirates-io/helm-charts/commit/64e36bdb))

## [0.5.6] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))

## [0.5.5] - 2025-11-02

- Add NodePort support for API and Console in Service configuration (#527) ([57b84d8d](https://github.com/CloudPirates-io/helm-charts/commit/57b84d8d))

## [0.5.4] - 2025-10-27

- Remove securitycontext on empty obejct (#474) ([3c288c80](https://github.com/CloudPirates-io/helm-charts/commit/3c288c80))

## [0.5.3] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.5.2] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))

## [0.5.1] - 2025-10-17

-  [minio] Fix bucketname trimming whitespaces in MinIO post-job configuration script. (#406) ([bf250e22](https://github.com/CloudPirates-io/helm-charts/commit/bf250e22))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.5.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.4.1] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))

## [0.4.0] - 2025-10-09

- add auto bucket creation through k8s job and option to create ServiceAccount for Deployment (#288) ([47d3947c](https://github.com/CloudPirates-io/helm-charts/commit/47d3947c))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))
-  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003ff](https://github.com/CloudPirates-io/helm-charts/commit/8a4003ff))

## [0.3.0] - 2025-10-02

- make minio run on openshift (#203) ([18c7be5d](https://github.com/CloudPirates-io/helm-charts/commit/18c7be5d))

## [0.2.4] - 2025-09-30

- add more configuration options for the minio server (#189) ([8066d078](https://github.com/CloudPirates-io/helm-charts/commit/8066d078))

## [0.2.3] - 2025-09-15

- Update CHANGELOG.md ([55a987f8](https://github.com/CloudPirates-io/helm-charts/commit/55a987f8))
- bump verion to 0.2.3 ([af6beca6](https://github.com/CloudPirates-io/helm-charts/commit/af6beca6))
- set strategy to recreate in deployment ([6e01f97f](https://github.com/CloudPirates-io/helm-charts/commit/6e01f97f))

## [0.2.2] - 2025-09-15

- Update CHANGELOG.md ([f31d5a5a](https://github.com/CloudPirates-io/helm-charts/commit/f31d5a5a))
- update minio README.md ([cbca20c0](https://github.com/CloudPirates-io/helm-charts/commit/cbca20c0))
- bump version to 0.2.2 ([afaf2d12](https://github.com/CloudPirates-io/helm-charts/commit/afaf2d12))
- add option to use cpu-v1 image ([91bfd29e](https://github.com/CloudPirates-io/helm-charts/commit/91bfd29e))

## [0.2.1] - 2025-09-08

- Update CHANGELOG.md ([bb8e730c](https://github.com/CloudPirates-io/helm-charts/commit/bb8e730c))
- Update appVersion ([5c23cb11](https://github.com/CloudPirates-io/helm-charts/commit/5c23cb11))
- Update CHANGELOG.md ([82fe11fd](https://github.com/CloudPirates-io/helm-charts/commit/82fe11fd))
- Upgrade minio to latest stable ([94ab8307](https://github.com/CloudPirates-io/helm-charts/commit/94ab8307))
- revert 3 ([d8ced5cf](https://github.com/CloudPirates-io/helm-charts/commit/d8ced5cf))
- revert 2 ([b64c81dd](https://github.com/CloudPirates-io/helm-charts/commit/b64c81dd))
- Update CHANGELOG.md ([808cae06](https://github.com/CloudPirates-io/helm-charts/commit/808cae06))
- revert ([ba71354b](https://github.com/CloudPirates-io/helm-charts/commit/ba71354b))
- Upgrade minio to latest stable ([b199ea41](https://github.com/CloudPirates-io/helm-charts/commit/b199ea41))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f90](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f90))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.1.8] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0a](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0a))
- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.1.7] - 2025-08-26

- Initial release

