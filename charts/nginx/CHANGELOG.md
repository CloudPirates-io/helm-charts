# Changelog

All notable changes to this chart will be documented in this file.

## [0.5.11] - 2026-02-12

- Update charts/nginx/values.yaml nginx (#983) ([811e4588](https://github.com/CloudPirates-io/helm-charts/commit/811e4588))

## [0.5.10] - 2026-02-06

- Update charts/nginx/values.yaml nginx to v1.29.5 (patch) (#967) ([6af48e00](https://github.com/CloudPirates-io/helm-charts/commit/6af48e00))

## [0.5.9] - 2026-02-03

- [nginx]: Allow loading site from configmap (#935) ([ff72433e](https://github.com/CloudPirates-io/helm-charts/commit/ff72433e))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.5.8] - 2026-02-02

- Update charts/nginx/values.yaml nginx (#931) ([05af91d1](https://github.com/CloudPirates-io/helm-charts/commit/05af91d1))

## [0.5.7] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.5.6] - 2026-01-28

- Update charts/nginx/values.yaml nginx (#916) ([ecb1406f](https://github.com/CloudPirates-io/helm-charts/commit/ecb1406f))

## [0.5.5] - 2026-01-28

- Update charts/nginx/values.yaml nginx (#913) ([99c97ad6](https://github.com/CloudPirates-io/helm-charts/commit/99c97ad6))

## [0.5.4] - 2026-01-19

- Update charts/nginx/values.yaml nginx (#827) ([f6d7860e](https://github.com/CloudPirates-io/helm-charts/commit/f6d7860e))
- [alpine/git] Update image to v2.52.0 (#771) ([32be4393](https://github.com/CloudPirates-io/helm-charts/commit/32be4393))

## [0.5.3] - 2026-01-08

- [nginx]: custom securityContext for initiContainers #765 ([dadbdb75](https://github.com/CloudPirates-io/helm-charts/commit/dadbdb75))

## [0.5.2] - 2025-12-22

- Update charts/nginx/values.yaml nginx (#746) ([d433040d](https://github.com/CloudPirates-io/helm-charts/commit/d433040d))

## [0.5.1] - 2025-12-10

- Update charts/nginx/values.yaml nginx to v1.29.4 (patch) (#718) ([48d2f154](https://github.com/CloudPirates-io/helm-charts/commit/48d2f154))

## [0.5.0] - 2025-11-26

- [nginx]: Configurable side car containers ([f525b11b](https://github.com/CloudPirates-io/helm-charts/commit/f525b11b))

## [0.4.3] - 2025-11-16

- [nginx]: feat: remove optional bitnami script sourcing (#601) ([9f6a8377](https://github.com/CloudPirates-io/helm-charts/commit/9f6a8377))

## [0.4.2] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))

## [0.4.1] - 2025-11-07

- [nginx]: Add podLabels ([b8d84100](https://github.com/CloudPirates-io/helm-charts/commit/b8d84100))

## [0.4.0] - 2025-11-04

- extraInitContainers (#548) ([686e3e0f](https://github.com/CloudPirates-io/helm-charts/commit/686e3e0f))

## [0.3.3] - 2025-11-02

- [nginx]: Add priorityClassName support (#526) ([e77747fd](https://github.com/CloudPirates-io/helm-charts/commit/e77747fd))

## [0.3.2] - 2025-10-30

- Update charts/nginx/values.yaml nginx (#508) ([60891a14](https://github.com/CloudPirates-io/helm-charts/commit/60891a14))

## [0.3.1] - 2025-10-29

- Update charts/nginx/values.yaml nginx to v1.29.3 (patch) (#490) ([a23c2db0](https://github.com/CloudPirates-io/helm-charts/commit/a23c2db0))

## [0.3.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.2.1] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))
- [universal] fix all appversions in charts (#417) ([b8debebf](https://github.com/CloudPirates-io/helm-charts/commit/b8debebf))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))
- [mariadb] add galera cluster support for mariadb (#348) ([b7a63ee8](https://github.com/CloudPirates-io/helm-charts/commit/b7a63ee8))

## [0.2.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))
- Update charts/nginx/values.yaml nginx (#351) ([d73ca946](https://github.com/CloudPirates-io/helm-charts/commit/d73ca946))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))

## [0.1.14] - 2025-10-09

- Update charts/nginx/values.yaml nginx to v1.29.2 (patch) (#263) ([b607e104](https://github.com/CloudPirates-io/helm-charts/commit/b607e104))

## [0.1.13] - 2025-10-08

- [nginx/nginx-prometheus-exporter] Update nginx/nginx-prometheus-exporter to v1.5 (#234) ([9f7f1e89](https://github.com/CloudPirates-io/helm-charts/commit/9f7f1e89))

## [0.1.12] - 2025-10-07

- Add prometheus nginx metrics exporter (#224) ([5bf615ac](https://github.com/CloudPirates-io/helm-charts/commit/5bf615ac))

## [0.1.11] - 2025-10-01

- update containerport documentation (#198) ([f20d6d4c](https://github.com/CloudPirates-io/helm-charts/commit/f20d6d4c))
- Changed README.md due to bug (wrong description) (#197) ([84fd1162](https://github.com/CloudPirates-io/helm-charts/commit/84fd1162))

## [0.1.10] - 2025-09-30

- Fix/nginx used ingress backend port (#190) ([096725e5](https://github.com/CloudPirates-io/helm-charts/commit/096725e5))

## [0.1.9] - 2025-09-30

- [Zookeeper] [Nginx] Change nginx and zookeeper security-context to use helper-function (#169) ([b581bc7c](https://github.com/CloudPirates-io/helm-charts/commit/b581bc7c))

## [0.1.8] - 2025-09-26

- [common] Fix/set securitycontext based on targetplatform to comply with openshift clusters (#166) ([f1bb75e7](https://github.com/CloudPirates-io/helm-charts/commit/f1bb75e7))

## [0.1.7] - 2025-09-25

- add predefined configmaps (#154) ([82c4bb6e](https://github.com/CloudPirates-io/helm-charts/commit/82c4bb6e))

## [0.1.6] - 2025-09-11

- Remove redundant single port configurations ([570075b7](https://github.com/CloudPirates-io/helm-charts/commit/570075b7))
- default disable cloneStaticSiteFromGit ([39136400](https://github.com/CloudPirates-io/helm-charts/commit/39136400))
- Fix multi port scenario ([29d38114](https://github.com/CloudPirates-io/helm-charts/commit/29d38114))
- Update CHANGELOG.md ([72f4eb9f](https://github.com/CloudPirates-io/helm-charts/commit/72f4eb9f))
- Bump chart version ([b322d472](https://github.com/CloudPirates-io/helm-charts/commit/b322d472))
- Implement fix ([7467d224](https://github.com/CloudPirates-io/helm-charts/commit/7467d224))

## [0.1.5] - 2025-09-10

- Update CHANGELOG.md ([84c70d62](https://github.com/CloudPirates-io/helm-charts/commit/84c70d62))
- Bump chart version ([3e4be776](https://github.com/CloudPirates-io/helm-charts/commit/3e4be776))
- Update CHANGELOG.md ([32fd09c7](https://github.com/CloudPirates-io/helm-charts/commit/32fd09c7))
- Implement static website git clone ([e081eab9](https://github.com/CloudPirates-io/helm-charts/commit/e081eab9))

## [0.1.4] - 2025-09-10

- Update CHANGELOG.md ([a3374906](https://github.com/CloudPirates-io/helm-charts/commit/a3374906))
- fix artifacthub-repo id ([e7a98fc7](https://github.com/CloudPirates-io/helm-charts/commit/e7a98fc7))

## [0.1.3] - 2025-09-08

- Update CHANGELOG.md ([d0f01539](https://github.com/CloudPirates-io/helm-charts/commit/d0f01539))
- Update appVersion ([933ba01f](https://github.com/CloudPirates-io/helm-charts/commit/933ba01f))
- Update CHANGELOG.md ([4ff2bbcd](https://github.com/CloudPirates-io/helm-charts/commit/4ff2bbcd))
- Bump nginx to latest version + alpine ([8b0fc579](https://github.com/CloudPirates-io/helm-charts/commit/8b0fc579))

## [0.1.2] - 2025-09-08

- update chart-icon ([7ed7c8ee](https://github.com/CloudPirates-io/helm-charts/commit/7ed7c8ee))
- Update CHANGELOG.md ([a13f40d1](https://github.com/CloudPirates-io/helm-charts/commit/a13f40d1))
- bump version to 0.1.2 ([f75a781c](https://github.com/CloudPirates-io/helm-charts/commit/f75a781c))
- fix containerport and change ingress host-pathtype ([60e32239](https://github.com/CloudPirates-io/helm-charts/commit/60e32239))

## [0.1.1] - 2025-09-08

- Update CHANGELOG.md ([19e53176](https://github.com/CloudPirates-io/helm-charts/commit/19e53176))
- add artifacthub-repo id ([ee4f192c](https://github.com/CloudPirates-io/helm-charts/commit/ee4f192c))

## [0.1.0] - 2025-09-08

- Initial release

