# Changelog

All notable changes to this chart will be documented in this file.

## [0.5.9] - 2026-02-03

- [nginx]: Allow loading site from configmap (#935) ([ff72433](../../commit/ff72433))
- [all]: Update documentation to include proper cosign public key ([e42365d](../../commit/e42365d))

## [0.5.8] - 2026-02-02

- Update charts/nginx/values.yaml nginx (#931) ([05af91d](../../commit/05af91d))

## [0.5.7] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d](../../commit/f8d134d))

## [0.5.6] - 2026-01-28

- Update charts/nginx/values.yaml nginx (#916) ([ecb1406](../../commit/ecb1406))

## [0.5.5] - 2026-01-28

- Update charts/nginx/values.yaml nginx (#913) ([99c97ad](../../commit/99c97ad))

## [0.5.4] - 2026-01-19

- Update charts/nginx/values.yaml nginx (#827) ([f6d7860](../../commit/f6d7860))
- [alpine/git] Update image to v2.52.0 (#771) ([32be439](../../commit/32be439))

## [0.5.3] - 2026-01-08

- [nginx]: custom securityContext for initiContainers #765 ([dadbdb7](../../commit/dadbdb7))

## [0.5.2] - 2025-12-22

- Update charts/nginx/values.yaml nginx (#746) ([d433040](../../commit/d433040))

## [0.5.1] - 2025-12-10

- Update charts/nginx/values.yaml nginx to v1.29.4 (patch) (#718) ([48d2f15](../../commit/48d2f15))

## [0.5.0] - 2025-11-26

- [nginx]: Configurable side car containers ([f525b11](../../commit/f525b11))

## [0.4.3] - 2025-11-16

- [nginx]: feat: remove optional bitnami script sourcing (#601) ([9f6a837](../../commit/9f6a837))

## [0.4.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f9](../../commit/e63f5f9))

## [0.4.1] - 2025-11-07

- [nginx]: Add podLabels ([b8d8410](../../commit/b8d8410))

## [0.4.0] - 2025-11-04

- extraInitContainers (#548) ([686e3e0](../../commit/686e3e0))

## [0.3.3] - 2025-11-02

- [nginx]: Add priorityClassName support (#526) ([e77747f](../../commit/e77747f))

## [0.3.2] - 2025-10-30

- Update charts/nginx/values.yaml nginx (#508) ([60891a1](../../commit/60891a1))

## [0.3.1] - 2025-10-29

- Update charts/nginx/values.yaml nginx to v1.29.3 (patch) (#490) ([a23c2db](../../commit/a23c2db))

## [0.3.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4](../../commit/4aee7b4))

## [0.2.1] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db](../../commit/cdb38db))
- [universal] fix all appversions in charts (#417) ([b8debeb](../../commit/b8debeb))
- [unversal] Add signing informations for artifacthub (#415) ([e761c90](../../commit/e761c90))
- [universal] use a string instead of a boolean (#413) ([c24d26d](../../commit/c24d26d))
- [universal] improve chart artifact annotations (#404) ([37f1c5b](../../commit/37f1c5b))
- [universal] Rework all schema json (#393) ([79d1439](../../commit/79d1439))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee](../../commit/b7a63ee))

## [0.2.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb1](../../commit/87acfb1))
- [universal]: Fix changelog generation (#354) ([2e973c0](../../commit/2e973c0))
- Update charts/nginx/values.yaml nginx (#351) ([d73ca94](../../commit/d73ca94))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937f](../../commit/ea7937f))
- add tests for openshift (#226) ([c80c98a](../../commit/c80c98a))
- [mongodb] feat: add metrics exporter (#243) ([c931978](../../commit/c931978))

## [0.1.14] - 2025-10-09

- Update charts/nginx/values.yaml nginx to v1.29.2 (patch) (#263) ([b607e10](../../commit/b607e10))

## [0.1.13] - 2025-10-08

- [nginx/nginx-prometheus-exporter] Update nginx/nginx-prometheus-exporter to v1.5 (#234) ([9f7f1e8](../../commit/9f7f1e8))

## [0.1.12] - 2025-10-07

- Add prometheus nginx metrics exporter (#224) ([5bf615a](../../commit/5bf615a))

## [0.1.11] - 2025-10-01

- update containerport documentation (#198) ([f20d6d4](../../commit/f20d6d4))
- Changed README.md due to bug (wrong description) (#197) ([84fd116](../../commit/84fd116))

## [0.1.10] - 2025-09-30

- Fix/nginx used ingress backend port (#190) ([096725e](../../commit/096725e))

## [0.1.9] - 2025-09-30

- [Zookeeper] [Nginx] Change nginx and zookeeper security-context to use helper-function (#169) ([b581bc7](../../commit/b581bc7))

## [0.1.8] - 2025-09-26

- [common] Fix/set securitycontext based on targetplatform to comply with openshift clusters (#166) ([f1bb75e](../../commit/f1bb75e))

## [0.1.7] - 2025-09-25

- add predefined configmaps (#154) ([82c4bb6](../../commit/82c4bb6))

## [0.1.6] - 2025-09-11

- Remove redundant single port configurations ([570075b](../../commit/570075b))
- default disable cloneStaticSiteFromGit ([3913640](../../commit/3913640))
- Fix multi port scenario ([29d3811](../../commit/29d3811))
- Update CHANGELOG.md ([72f4eb9](../../commit/72f4eb9))
- Bump chart version ([b322d47](../../commit/b322d47))
- Implement fix ([7467d22](../../commit/7467d22))

## [0.1.5] - 2025-09-10

- Update CHANGELOG.md ([84c70d6](../../commit/84c70d6))
- Bump chart version ([3e4be77](../../commit/3e4be77))
- Update CHANGELOG.md ([32fd09c](../../commit/32fd09c))
- Implement static website git clone ([e081eab](../../commit/e081eab))

## [0.1.4] - 2025-09-10

- Update CHANGELOG.md ([a337490](../../commit/a337490))
- fix artifacthub-repo id ([e7a98fc](../../commit/e7a98fc))

## [0.1.3] - 2025-09-08

- Update CHANGELOG.md ([d0f0153](../../commit/d0f0153))
- Update appVersion ([933ba01](../../commit/933ba01))
- Update CHANGELOG.md ([4ff2bbc](../../commit/4ff2bbc))
- Bump nginx to latest version + alpine ([8b0fc57](../../commit/8b0fc57))

## [0.1.2] - 2025-09-08

- update chart-icon ([7ed7c8e](../../commit/7ed7c8e))
- Update CHANGELOG.md ([a13f40d](../../commit/a13f40d))
- bump version to 0.1.2 ([f75a781](../../commit/f75a781))
- fix containerport and change ingress host-pathtype ([60e3223](../../commit/60e3223))

## [0.1.1] - 2025-09-08

- Update CHANGELOG.md ([19e5317](../../commit/19e5317))
- add artifacthub-repo id ([ee4f192](../../commit/ee4f192))

## [0.1.0] - 2025-09-08

- Initial release

