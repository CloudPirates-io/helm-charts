# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.6] - 2026-02-04

- Update charts/memcached/values.yaml memcached (#951) ([6f205b2](https://github.com/CloudPirates-io/helm-charts/commit/6f205b2))

## [0.9.5] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#949) ([00a9548](https://github.com/CloudPirates-io/helm-charts/commit/00a9548))

## [0.9.4] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#942) ([23332da](https://github.com/CloudPirates-io/helm-charts/commit/23332da))
- [all]: Update documentation to include proper cosign public key ([e42365d](https://github.com/CloudPirates-io/helm-charts/commit/e42365d))

## [0.9.3] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d))

## [0.9.2] - 2026-01-19

- [prom/memcached-exporter] Update image to v0.15.5 (#861) ([f6b8034](https://github.com/CloudPirates-io/helm-charts/commit/f6b8034))

## [0.9.1] - 2026-01-19

- Update charts/memcached/values.yaml memcached (#834) ([a93b816](https://github.com/CloudPirates-io/helm-charts/commit/a93b816))

## [0.9.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](https://github.com/CloudPirates-io/helm-charts/commit/b3d816f))

## [0.8.2] - 2026-01-08

- Update charts/memcached/values.yaml memcached (#785) ([417ee7f](https://github.com/CloudPirates-io/helm-charts/commit/417ee7f))

## [0.8.1] - 2025-12-22

- Update charts/memcached/values.yaml memcached to v1.6.40 (patch) (#766) ([48b7494](https://github.com/CloudPirates-io/helm-charts/commit/48b7494))

## [0.8.0] - 2025-12-12

- change default deploymentType to deployment (#736) ([3b61ed2](https://github.com/CloudPirates-io/helm-charts/commit/3b61ed2))

## [0.7.2] - 2025-12-09

- Update charts/memcached/values.yaml memcached (#710) ([9a0f0bc](https://github.com/CloudPirates-io/helm-charts/commit/9a0f0bc))

## [0.7.1] - 2025-11-20

- Update charts/memcached/values.yaml memcached (#632) ([9a83039](https://github.com/CloudPirates-io/helm-charts/commit/9a83039))
- Update charts/memcached/values.yaml memcached (#620) ([f977422](https://github.com/CloudPirates-io/helm-charts/commit/f977422))

## [0.7.0] - 2025-11-17

- add serviceMonitor joblabel attribute to values (#610) ([098caf4](https://github.com/CloudPirates-io/helm-charts/commit/098caf4))

## [0.6.0] - 2025-11-13

- support change to statefulset (#592) ([3c74ccf](https://github.com/CloudPirates-io/helm-charts/commit/3c74ccf))

## [0.5.4] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f9))

## [0.5.3] - 2025-11-05

- Add support for pod labels (#550) ([6071930](https://github.com/CloudPirates-io/helm-charts/commit/6071930))

## [0.5.2] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#543) ([8653b45](https://github.com/CloudPirates-io/helm-charts/commit/8653b45))

## [0.5.1] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#540) ([80a134a](https://github.com/CloudPirates-io/helm-charts/commit/80a134a))

## [0.5.0] - 2025-11-02

- Add metrics support (#512) ([5ea2397](https://github.com/CloudPirates-io/helm-charts/commit/5ea2397))

## [0.4.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4))

## [0.3.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db))

## [0.3.3] - 2025-10-22

- Update charts/memcached/values.yaml memcached (#425) ([de0a4a1](https://github.com/CloudPirates-io/helm-charts/commit/de0a4a1))

## [0.3.2] - 2025-10-21

- Update charts/memcached/values.yaml memcached (#424) ([304f6bd](https://github.com/CloudPirates-io/helm-charts/commit/304f6bd))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](https://github.com/CloudPirates-io/helm-charts/commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5b))

## [0.3.1] - 2025-10-15

- [memcached]: add missing automountServiceAccountToken key to deployment spec (#395) ([93fee01](https://github.com/CloudPirates-io/helm-charts/commit/93fee01))
- [universal] Rework all schema json (#393) ([79d1439](https://github.com/CloudPirates-io/helm-charts/commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee))

## [0.3.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](https://github.com/CloudPirates-io/helm-charts/commit/87acfb1))

## [0.2.3] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](https://github.com/CloudPirates-io/helm-charts/commit/2e973c0))

## [0.2.2] - 2025-10-10

- [memcached]: Implement PDB (#295) ([b974e8a](https://github.com/CloudPirates-io/helm-charts/commit/b974e8a))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](https://github.com/CloudPirates-io/helm-charts/commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](https://github.com/CloudPirates-io/helm-charts/commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](https://github.com/CloudPirates-io/helm-charts/commit/c931978))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c))

## [0.2.1] - 2025-10-02

- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 157c563 (#185) ([d55b428](https://github.com/CloudPirates-io/helm-charts/commit/d55b428))

## [0.2.0] - 2025-10-01

- make memcached run on openshift (#194) ([87ffbbf](https://github.com/CloudPirates-io/helm-charts/commit/87ffbbf))
- Update CHANGELOG.md ([7a828fa](https://github.com/CloudPirates-io/helm-charts/commit/7a828fa))
- Update CHANGELOG.md ([f9df296](https://github.com/CloudPirates-io/helm-charts/commit/f9df296))
- Update CHANGELOG.md ([0c85529](https://github.com/CloudPirates-io/helm-charts/commit/0c85529))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([0e5b657](https://github.com/CloudPirates-io/helm-charts/commit/0e5b657))
- cast verbosity to int before passing to repeat ([518b602](https://github.com/CloudPirates-io/helm-charts/commit/518b602))

## [0.1.2] - 2025-09-10

- Update CHANGELOG.md ([dcabcee](https://github.com/CloudPirates-io/helm-charts/commit/dcabcee))
- bump version ([884f4ab](https://github.com/CloudPirates-io/helm-charts/commit/884f4ab))
- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 68c1185 ([3c6ec49](https://github.com/CloudPirates-io/helm-charts/commit/3c6ec49))

## [0.1.1] - 2025-09-09

- Update CHANGELOG.md ([812bd46](https://github.com/CloudPirates-io/helm-charts/commit/812bd46))
- Bump chart version ([1661d8d](https://github.com/CloudPirates-io/helm-charts/commit/1661d8d))
- Update docker.io/memcached:1.6.39 Docker digest to 4404f32 ([454eea5](https://github.com/CloudPirates-io/helm-charts/commit/454eea5))
- mariadb now respects full custom container security context settings memcached readme fixed, this option was not available ([770ea69](https://github.com/CloudPirates-io/helm-charts/commit/770ea69))

## [0.1.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))
- add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))

## [0.0.2] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))

## [0.0.1] - 2025-08-26

- Initial release

