# Changelog

## 0.3.1 (2025-10-09)

* [keycloak/keycloak] Update charts/keycloak/values.yaml keycloak/keycloak to v26.3.5 (patch) ([#261](https://github.com/CloudPirates-io/helm-charts/pull/261))

## 0.3.0 (2025-10-08)

* make keycloak run on openshift (#225) ([9b4f896](https://github.com/CloudPirates-io/helm-charts/commit/9b4f896)), closes [#225](https://github.com/CloudPirates-io/helm-charts/issues/225)

## <small>0.2.1 (2025-10-07)</small>

* default http relative path to '/' to fix argocd deployment (#221) ([bdb1946](https://github.com/CloudPirates-io/helm-charts/commit/bdb1946)), closes [#221](https://github.com/CloudPirates-io/helm-charts/issues/221)

## 0.2.0 (2025-10-06)

* Add support for extra volumes, volumeMounts and initContainers (#215) ([16afcfe](https://github.com/CloudPirates-io/helm-charts/commit/16afcfe)), closes [#215](https://github.com/CloudPirates-io/helm-charts/issues/215)

## <small>0.1.12 (2025-10-06)</small>

* [mariadb] chore(deps): update mariadb:12.0.2 Docker digest to 03a03a6 (#208) ([01a6ad1](https://github.com/CloudPirates-io/helm-charts/commit/01a6ad1)), closes [#208](https://github.com/CloudPirates-io/helm-charts/issues/208)
* [mariadb] use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c)), closes [#217](https://github.com/CloudPirates-io/helm-charts/issues/217)

## <small>0.1.11 (2025-10-06)</small>

* Allow keycloak to have a relative path (#216) ([0237457](https://github.com/CloudPirates-io/helm-charts/commit/0237457)), closes [#216](https://github.com/CloudPirates-io/helm-charts/issues/216)

## <small>0.1.10 (2025-10-02)</small>

* [postgres] chore(deps): update postgres:17.6 Docker digest to e6a4209 (#173) ([beb0b40](https://github.com/CloudPirates-io/helm-charts/commit/beb0b40)), closes [#173](https://github.com/CloudPirates-io/helm-charts/issues/173)

## <small>0.1.9 (2025-10-02)</small>

* add topologySpreadConstraints and trafficDistribution opti… (#209) ([c777fca](https://github.com/CloudPirates-io/helm-charts/commit/c777fca)), closes [#209](https://github.com/CloudPirates-io/helm-charts/issues/209)

## <small>0.1.8 (2025-09-30)</small>

* Feature/command customize (#186) ([a458e15](https://github.com/CloudPirates-io/helm-charts/commit/a458e15)), closes [#186](https://github.com/CloudPirates-io/helm-charts/issues/186)

## <small>0.1.7 (2025-09-29)</small>

* replace deprecated 'proxy' with new proxy parameters (#183) ([d850b7b](https://github.com/CloudPirates-io/helm-charts/commit/d850b7b)), closes [#183](https://github.com/CloudPirates-io/helm-charts/issues/183)

## <small>0.1.6 (2025-09-26)</small>

* [postgres] chore(deps): update postgres:17.6 Docker digest to 0b6428e (#162) ([6293612](https://github.com/CloudPirates-io/helm-charts/commit/6293612)), closes [#162](https://github.com/CloudPirates-io/helm-charts/issues/162)

## <small>0.1.5 (2025-09-25)</small>

* add namespaces to templates, change user/group-ids to 1001 ([31b203b](https://github.com/CloudPirates-io/helm-charts/commit/31b203b))
* add readme documentation and values.schema.json ([369448b](https://github.com/CloudPirates-io/helm-charts/commit/369448b))
* add support for extra env vars from an existing secret (#158) ([263604f](https://github.com/CloudPirates-io/helm-charts/commit/263604f)), closes [#158](https://github.com/CloudPirates-io/helm-charts/issues/158)
* Fix resolving template expressions in extraobjects ([12a1cb5](https://github.com/CloudPirates-io/helm-charts/commit/12a1cb5))
* [postgres] chore(deps): update postgres:17.6 Docker digest to 0f4f200 ([b4a6a30](https://github.com/CloudPirates-io/helm-charts/commit/b4a6a30))
* Add keycloak logo ([bf1e1c2](https://github.com/CloudPirates-io/helm-charts/commit/bf1e1c2))
* Add TODO ([8162d60](https://github.com/CloudPirates-io/helm-charts/commit/8162d60))
* Artifact hub id ([02540ae](https://github.com/CloudPirates-io/helm-charts/commit/02540ae))
* Bump the correct thing ([35e7901](https://github.com/CloudPirates-io/helm-charts/commit/35e7901))
* Fix chart version bump ([aae07b1](https://github.com/CloudPirates-io/helm-charts/commit/aae07b1))
* Fix deprecated env vars warning ([50d9fa0](https://github.com/CloudPirates-io/helm-charts/commit/50d9fa0))
* Fix lint ([4bf9e77](https://github.com/CloudPirates-io/helm-charts/commit/4bf9e77))
* Fix lint 2 ([a38fc35](https://github.com/CloudPirates-io/helm-charts/commit/a38fc35))
* Fix lint 3 ([0875bfa](https://github.com/CloudPirates-io/helm-charts/commit/0875bfa))
* Fix lint 4 ([7fcbd78](https://github.com/CloudPirates-io/helm-charts/commit/7fcbd78))
* Improvements ([cea8f2c](https://github.com/CloudPirates-io/helm-charts/commit/cea8f2c))
* Initial implementation ([c5d41ec](https://github.com/CloudPirates-io/helm-charts/commit/c5d41ec))
* Rework keycloak ([2afb0fd](https://github.com/CloudPirates-io/helm-charts/commit/2afb0fd))
* Update CHANGELOG.md ([b7572a8](https://github.com/CloudPirates-io/helm-charts/commit/b7572a8))
* Update CHANGELOG.md ([245f9b6](https://github.com/CloudPirates-io/helm-charts/commit/245f9b6))
* Update CHANGELOG.md ([0bf9f75](https://github.com/CloudPirates-io/helm-charts/commit/0bf9f75))
* Update CHANGELOG.md ([03d476e](https://github.com/CloudPirates-io/helm-charts/commit/03d476e))
* Update CHANGELOG.md ([20c19bb](https://github.com/CloudPirates-io/helm-charts/commit/20c19bb))
* Update CHANGELOG.md ([68435aa](https://github.com/CloudPirates-io/helm-charts/commit/68435aa))
* Update CHANGELOG.md ([b8adca8](https://github.com/CloudPirates-io/helm-charts/commit/b8adca8))
* Update CHANGELOG.md ([62e51b9](https://github.com/CloudPirates-io/helm-charts/commit/62e51b9))
* Update CHANGELOG.md ([54f725e](https://github.com/CloudPirates-io/helm-charts/commit/54f725e))
* Update CHANGELOG.md ([2ed9b3f](https://github.com/CloudPirates-io/helm-charts/commit/2ed9b3f))
* Update CHANGELOG.md ([2178148](https://github.com/CloudPirates-io/helm-charts/commit/2178148))
* Update CHANGELOG.md ([8d6710f](https://github.com/CloudPirates-io/helm-charts/commit/8d6710f))
* chore: fix changelog ([bd9f1a8](https://github.com/CloudPirates-io/helm-charts/commit/bd9f1a8))
