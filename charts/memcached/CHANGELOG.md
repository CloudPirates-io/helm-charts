# Changelog

All notable changes to this chart will be documented in this file.

## [0.9.6] - 2026-02-04

- Update charts/memcached/values.yaml memcached (#951) ([6f205b2](../../commit/6f205b2))

## [0.9.5] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#949) ([00a9548](../../commit/00a9548))

## [0.9.4] - 2026-02-03

- Update charts/memcached/values.yaml memcached (#942) ([23332da](../../commit/23332da))
- [all]: Update documentation to include proper cosign public key ([e42365d](../../commit/e42365d))

## [0.9.3] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](../../commit/f8d134d))

## [0.9.2] - 2026-01-19

- [prom/memcached-exporter] Update image to v0.15.5 (#861) ([f6b8034](../../commit/f6b8034))

## [0.9.1] - 2026-01-19

- Update charts/memcached/values.yaml memcached (#834) ([a93b816](../../commit/a93b816))

## [0.9.0] - 2026-01-15

-  [universal] add priorityclasses to multiple charts (#839) ([b3d816f](../../commit/b3d816f))

## [0.8.2] - 2026-01-08

- Update charts/memcached/values.yaml memcached (#785) ([417ee7f](../../commit/417ee7f))

## [0.8.1] - 2025-12-22

- Update charts/memcached/values.yaml memcached to v1.6.40 (patch) (#766) ([48b7494](../../commit/48b7494))

## [0.8.0] - 2025-12-12

- change default deploymentType to deployment (#736) ([3b61ed2](../../commit/3b61ed2))

## [0.7.2] - 2025-12-09

- Update charts/memcached/values.yaml memcached (#710) ([9a0f0bc](../../commit/9a0f0bc))

## [0.7.1] - 2025-11-20

- Update charts/memcached/values.yaml memcached (#632) ([9a83039](../../commit/9a83039))
- Update charts/memcached/values.yaml memcached (#620) ([f977422](../../commit/f977422))

## [0.7.0] - 2025-11-17

- add serviceMonitor joblabel attribute to values (#610) ([098caf4](../../commit/098caf4))

## [0.6.0] - 2025-11-13

- support change to statefulset (#592) ([3c74ccf](../../commit/3c74ccf))

## [0.5.4] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](../../commit/e63f5f9))

## [0.5.3] - 2025-11-05

- Add support for pod labels (#550) ([6071930](../../commit/6071930))

## [0.5.2] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#543) ([8653b45](../../commit/8653b45))

## [0.5.1] - 2025-11-04

- Update charts/memcached/values.yaml memcached (#540) ([80a134a](../../commit/80a134a))

## [0.5.0] - 2025-11-02

- Add metrics support (#512) ([5ea2397](../../commit/5ea2397))

## [0.4.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](../../commit/4aee7b4))

## [0.3.4] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](../../commit/cdb38db))

## [0.3.3] - 2025-10-22

- Update charts/memcached/values.yaml memcached (#425) ([de0a4a1](../../commit/de0a4a1))

## [0.3.2] - 2025-10-21

- Update charts/memcached/values.yaml memcached (#424) ([304f6bd](../../commit/304f6bd))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](../../commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](../../commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](../../commit/37f1c5b))

## [0.3.1] - 2025-10-15

- [memcached]: add missing automountServiceAccountToken key to deployment spec (#395) ([93fee01](../../commit/93fee01))
- [universal] Rework all schema json (#393) ([79d1439](../../commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](../../commit/b7a63ee))

## [0.3.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](../../commit/87acfb1))

## [0.2.3] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c](../../commit/bcc566c))
- [universal]: Fix changelog generation (#354) ([2e973c0](../../commit/2e973c0))

## [0.2.2] - 2025-10-10

- [memcached]: Implement PDB (#295) ([b974e8a](../../commit/b974e8a))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](../../commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](../../commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](../../commit/c931978))
- [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](../../commit/c7c2f4c))

## [0.2.1] - 2025-10-02

- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 157c563 (#185) ([d55b428](../../commit/d55b428))

## [0.2.0] - 2025-10-01

- make memcached run on openshift (#194) ([87ffbbf](../../commit/87ffbbf))
- Update CHANGELOG.md ([7a828fa](../../commit/7a828fa))
- Update CHANGELOG.md ([f9df296](../../commit/f9df296))
- Update CHANGELOG.md ([0c85529](../../commit/0c85529))

## [0.1.3] - 2025-09-23

- Update CHANGELOG.md ([0e5b657](../../commit/0e5b657))
- cast verbosity to int before passing to repeat ([518b602](../../commit/518b602))

## [0.1.2] - 2025-09-10

- Update CHANGELOG.md ([dcabcee](../../commit/dcabcee))
- bump version ([884f4ab](../../commit/884f4ab))
- chore(deps): update docker.io/memcached:1.6.39 Docker digest to 68c1185 ([3c6ec49](../../commit/3c6ec49))

## [0.1.1] - 2025-09-09

- Update CHANGELOG.md ([812bd46](../../commit/812bd46))
- Bump chart version ([1661d8d](../../commit/1661d8d))
- Update docker.io/memcached:1.6.39 Docker digest to 4404f32 ([454eea5](../../commit/454eea5))
- mariadb now respects full custom container security context settings memcached readme fixed, this option was not available ([770ea69](../../commit/770ea69))

## [0.1.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f9](../../commit/aaa57f9))
- add extraObject array to all charts ([34772b7](../../commit/34772b7))

## [0.0.2] - 2025-08-27

- Add initial Changelogs to all Charts ([68f10ca](../../commit/68f10ca))

## [0.0.1] - 2025-08-26

- Initial release

