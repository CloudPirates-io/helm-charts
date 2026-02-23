# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.6] - 2026-02-04

- Update charts/memcached/values.yaml memcached (#951) ([6f205b23](https://github.com/CloudPirates-io/helm-charts/commit/6f205b23))

## [0.9.5] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#949) ([00a95484](https://github.com/CloudPirates-io/helm-charts/commit/00a95484))

## [0.9.4] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#942) ([23332dac](https://github.com/CloudPirates-io/helm-charts/commit/23332dac))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.9.3] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.9.2] - 2026-01-19

- [prom/memcached-exporter] Update image to v0.15.5 (#861) ([f6b8034e](https://github.com/CloudPirates-io/helm-charts/commit/f6b8034e))

## [0.9.1] - 2026-01-19

- Update charts/memcached/values.yaml memcached (#834) ([a93b816f](https://github.com/CloudPirates-io/helm-charts/commit/a93b816f))

## [0.9.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f1](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f1))

## [0.8.2] - 2026-01-08

- Update charts/memcached/values.yaml memcached (#785) ([417ee7f2](https://github.com/CloudPirates-io/helm-charts/commit/417ee7f2))

## [0.8.1] - 2025-12-22

- Update charts/memcached/values.yaml memcached to v1.6.40 (patch) (#766) ([48b74947](https://github.com/CloudPirates-io/helm-charts/commit/48b74947))

## [0.8.0] - 2025-12-12

- change default deploymentType to deployment (#736) ([3b61ed21](https://github.com/CloudPirates-io/helm-charts/commit/3b61ed21))

## [0.7.2] - 2025-12-09

- Update charts/memcached/values.yaml memcached (#710) ([9a0f0bcc](https://github.com/CloudPirates-io/helm-charts/commit/9a0f0bcc))

## [0.7.1] - 2025-11-20

- Update charts/memcached/values.yaml memcached (#632) ([9a83039f](https://github.com/CloudPirates-io/helm-charts/commit/9a83039f))
- Update charts/memcached/values.yaml memcached (#620) ([f9774225](https://github.com/CloudPirates-io/helm-charts/commit/f9774225))

## [0.7.0] - 2025-11-17

- add serviceMonitor joblabel attribute to values (#610) ([098caf41](https://github.com/CloudPirates-io/helm-charts/commit/098caf41))

## [0.6.0] - 2025-11-13

- support change to statefulset (#592) ([3c74ccf8](https://github.com/CloudPirates-io/helm-charts/commit/3c74ccf8))

## [0.5.4] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))

## [0.5.3] - 2025-11-05

- Add support for pod labels (#550) ([60719308](https://github.com/CloudPirates-io/helm-charts/commit/60719308))

## [0.5.2] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#543) ([8653b457](https://github.com/CloudPirates-io/helm-charts/commit/8653b457))

## [0.5.1] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#540) ([80a134ad](https://github.com/CloudPirates-io/helm-charts/commit/80a134ad))

## [0.5.0] - 2025-11-02

- Add metrics support (#512) ([5ea2397e](https://github.com/CloudPirates-io/helm-charts/commit/5ea2397e))

## [0.4.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.3.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.3.3] - 2025-10-22

- Update charts/memcached/values.yaml memcached (#425) ([de0a4a1b](https://github.com/CloudPirates-io/helm-charts/commit/de0a4a1b))

## [0.3.2] - 2025-10-21

- Update charts/memcached/values.yaml memcached (#424) ([304f6bde](https://github.com/CloudPirates-io/helm-charts/commit/304f6bde))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))

## [0.3.1] - 2025-10-15

- [memcached]: add missing automountServiceAccountToken key to deployment spec (#395) ([93fee019](https://github.com/CloudPirates-io/helm-charts/commit/93fee019))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.3.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.2.3] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.2.2] - 2025-10-10

- [memcached]: Implement PDB (#295) ([b974e8aa](https://github.com/CloudPirates-io/helm-charts/commit/b974e8aa))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c0](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c0))

## [0.2.1] - 2025-10-02

- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 157c563 (#185) ([d55b4282](https://github.com/CloudPirates-io/helm-charts/commit/d55b4282))

## [0.2.0] - 2025-10-01

- make memcached run on openshift (#194) ([87ffbbff](https://github.com/CloudPirates-io/helm-charts/commit/87ffbbff))
- Update CHANGELOG.md ([7a828fa1](https://github.com/CloudPirates-io/helm-charts/commit/7a828fa1))
- Update CHANGELOG.md ([f9df2961](https://github.com/CloudPirates-io/helm-charts/commit/f9df2961))
- Update CHANGELOG.md ([0c855290](https://github.com/CloudPirates-io/helm-charts/commit/0c855290))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([0e5b6573](https://github.com/CloudPirates-io/helm-charts/commit/0e5b6573))
- cast verbosity to int before passing to repeat ([518b602e](https://github.com/CloudPirates-io/helm-charts/commit/518b602e))

## [0.1.2] - 2025-09-10

- Update CHANGELOG.md ([dcabcee7](https://github.com/CloudPirates-io/helm-charts/commit/dcabcee7))
- bump version ([884f4abc](https://github.com/CloudPirates-io/helm-charts/commit/884f4abc))
- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 68c1185 ([3c6ec499](https://github.com/CloudPirates-io/helm-charts/commit/3c6ec499))

## [0.1.1] - 2025-09-09

- Update CHANGELOG.md ([812bd46a](https://github.com/CloudPirates-io/helm-charts/commit/812bd46a))
- Bump chart version ([1661d8d4](https://github.com/CloudPirates-io/helm-charts/commit/1661d8d4))
- Update docker.io/memcached:1.6.39 Docker digest to 4404f32 ([454eea53](https://github.com/CloudPirates-io/helm-charts/commit/454eea53))
- mariadb now respects full custom container security context settings memcached readme fixed, this option was not available ([770ea692](https://github.com/CloudPirates-io/helm-charts/commit/770ea692))

## [0.1.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f90](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f90))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.0.2] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.0.1] - 2025-08-26

- Initial release

