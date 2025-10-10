# Changelog

## 0.3.4 (2025-10-10)

* [mariadb] Update charts/mariadb/values.yaml mariadb ([#315](https://github.com/CloudPirates-io/helm-charts/pull/315))

## <small>0.3.3 (2025-10-08)</small>

* Add support for readOnlyRootFilesystem (#228) ([cdb58b2](https://github.com/CloudPirates-io/helm-charts/commit/cdb58b2)), closes [#228](https://github.com/CloudPirates-io/helm-charts/issues/228)

## <small>0.3.2 (2025-10-06)</small>

* chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 03a03a6 (#207) ([e51e995](https://github.com/CloudPirates-io/helm-charts/commit/e51e995)), closes [#207](https://github.com/CloudPirates-io/helm-charts/issues/207)

## <small>0.3.1 (2025-10-06)</small>

* use tpl to return existingConfigMap (#217) ([c7c2f4c](https://github.com/CloudPirates-io/helm-charts/commit/c7c2f4c)), closes [#217](https://github.com/CloudPirates-io/helm-charts/issues/217)

## 0.3.0 (2025-09-29)

* bump version to 0.2.6 ([51bcd26](https://github.com/CloudPirates-io/helm-charts/commit/51bcd26))
* change statefulset pvc-template labels to not use common.labels ([780386b](https://github.com/CloudPirates-io/helm-charts/commit/780386b))
* chore(deps): update docker.io/mariadb:12.0.2 Docker digest to 8a061ef ([ba48f7a](https://github.com/CloudPirates-io/helm-charts/commit/ba48f7a))
* fix pvc-labels ([aaf1b20](https://github.com/CloudPirates-io/helm-charts/commit/aaf1b20))
* fix statefulset pvc template ([b600627](https://github.com/CloudPirates-io/helm-charts/commit/b600627))
* make mariadb run on openshift (#176) ([e2c3afb](https://github.com/CloudPirates-io/helm-charts/commit/e2c3afb)), closes [#176](https://github.com/CloudPirates-io/helm-charts/issues/176)
* add empty linting rule ([8be9283](https://github.com/CloudPirates-io/helm-charts/commit/8be9283))
* Bump chart version ([ea85028](https://github.com/CloudPirates-io/helm-charts/commit/ea85028))
* Bump chart version ([d2863aa](https://github.com/CloudPirates-io/helm-charts/commit/d2863aa))
* Bump MariaDB chart version to 0.2.3 ([10b1b7d](https://github.com/CloudPirates-io/helm-charts/commit/10b1b7d))
* Fix helpers.tpl ([201ecc7](https://github.com/CloudPirates-io/helm-charts/commit/201ecc7))
* Implement default password ([c858a6b](https://github.com/CloudPirates-io/helm-charts/commit/c858a6b))
* Implement init script ([4b6ee98](https://github.com/CloudPirates-io/helm-charts/commit/4b6ee98))
* mariadb now respects full custom container security context settings ([770ea69](https://github.com/CloudPirates-io/helm-charts/commit/770ea69))
* Reverse version bump ([379dbfe](https://github.com/CloudPirates-io/helm-charts/commit/379dbfe))
* Update CHANGELOG.md ([bb96d54](https://github.com/CloudPirates-io/helm-charts/commit/bb96d54))
* Update CHANGELOG.md ([858838d](https://github.com/CloudPirates-io/helm-charts/commit/858838d))
* Update CHANGELOG.md ([e5c8efd](https://github.com/CloudPirates-io/helm-charts/commit/e5c8efd))
* Update CHANGELOG.md ([79570ff](https://github.com/CloudPirates-io/helm-charts/commit/79570ff))
* Update CHANGELOG.md ([7517a21](https://github.com/CloudPirates-io/helm-charts/commit/7517a21))
* Update CHANGELOG.md ([bcd1d8a](https://github.com/CloudPirates-io/helm-charts/commit/bcd1d8a))
* Update CHANGELOG.md ([9af2905](https://github.com/CloudPirates-io/helm-charts/commit/9af2905))
* Update docker.io/mariadb:12.0.2 Docker digest to a5af517 ([6322f06](https://github.com/CloudPirates-io/helm-charts/commit/6322f06))
* updated chart version ([f7b6496](https://github.com/CloudPirates-io/helm-charts/commit/f7b6496))

## 0.2.0 (2025-09-02)

* add extraObject array to all charts ([34772b7](https://github.com/CloudPirates-io/helm-charts/commit/34772b7))
* bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f9))

## <small>0.1.6 (2025-08-27)</small>

* [documentation] update readme files ([16944cd](https://github.com/CloudPirates-io/helm-charts/commit/16944cd))
* bump version to 0.1.4 ([d4f2478](https://github.com/CloudPirates-io/helm-charts/commit/d4f2478))
* fix annotations, imagePullsecret, update tests ([31a1a87](https://github.com/CloudPirates-io/helm-charts/commit/31a1a87))
* update appversion to 12.0.2, release 0.1.5 ([cf67ba0](https://github.com/CloudPirates-io/helm-charts/commit/cf67ba0))
* update container image definition-function, remove default value ([3ad9f82](https://github.com/CloudPirates-io/helm-charts/commit/3ad9f82))
* update statefulset auth, fix image helper and imagePullSecret ([085f5bb](https://github.com/CloudPirates-io/helm-charts/commit/085f5bb))
* Add ArtifactHub Badges to all Charts ([08b855b](https://github.com/CloudPirates-io/helm-charts/commit/08b855b))
* Add ArtifactHub repo config ([15180a8](https://github.com/CloudPirates-io/helm-charts/commit/15180a8))
* Add cosign signature READMEs ([5f82e7f](https://github.com/CloudPirates-io/helm-charts/commit/5f82e7f))
* Add extensive chart testing ([a46efac](https://github.com/CloudPirates-io/helm-charts/commit/a46efac))
* Add generated values.schema.json files from values.yaml ([aa79ac3](https://github.com/CloudPirates-io/helm-charts/commit/aa79ac3))
* Add initial Changelogs to all Charts ([68f10ca](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca))
* Add LICENSE ([fdbf1ab](https://github.com/CloudPirates-io/helm-charts/commit/fdbf1ab))
* add logos to helm-charts ([fc70cdc](https://github.com/CloudPirates-io/helm-charts/commit/fc70cdc))
* Add release pipeline ([ebd7277](https://github.com/CloudPirates-io/helm-charts/commit/ebd7277))
* Fix image tag/digest handling ([a5c982b](https://github.com/CloudPirates-io/helm-charts/commit/a5c982b))
* Fix imagePullSecrets format and pull always ([ce0d301](https://github.com/CloudPirates-io/helm-charts/commit/ce0d301))
* Fix linting for values.yaml ([504ac61](https://github.com/CloudPirates-io/helm-charts/commit/504ac61))
* fix readme.md install text, update chart.yaml home-website ([3511582](https://github.com/CloudPirates-io/helm-charts/commit/3511582))
* Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0))
* Format README files ([04aacab](https://github.com/CloudPirates-io/helm-charts/commit/04aacab))
* init, add mariadb, mongodb and redis chart ([8e44c83](https://github.com/CloudPirates-io/helm-charts/commit/8e44c83))
* Relase withoud double chart name ([b0ec54d](https://github.com/CloudPirates-io/helm-charts/commit/b0ec54d))
* Release new chart versions / update sources ([dbb0e45](https://github.com/CloudPirates-io/helm-charts/commit/dbb0e45))
* Remove dot ([f7d300b](https://github.com/CloudPirates-io/helm-charts/commit/f7d300b))
* remove serviceaccounts from all charts ([be8f43a](https://github.com/CloudPirates-io/helm-charts/commit/be8f43a))
* Test release ([33db75e](https://github.com/CloudPirates-io/helm-charts/commit/33db75e))
* Update mariadb ([37fb54f](https://github.com/CloudPirates-io/helm-charts/commit/37fb54f))
* update readme, chart.yaml texts and descriptions ([0179046](https://github.com/CloudPirates-io/helm-charts/commit/0179046))
