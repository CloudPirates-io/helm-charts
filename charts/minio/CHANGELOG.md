# Changelog

> [!CAUTION]
> This file is kept for backwards compatibility only and is no longer updated. See the [GitHub Releases](https://github.com/CloudPirates-io/helm-charts/releases) page to view changes for each version.

All notable changes to this chart will be documented in this file.

## 0.5.2 (2025-11-14)

* Update CHANGELOG.md ([376eaff](https://github.com/GitGuardian/gitguardian-helm-charts/commit/376eaff))
* feat(minio): rename post job and add variables to configure it ([4308aff](https://github.com/GitGuardian/gitguardian-helm-charts/commit/4308aff))

## 0.5.1 (2025-11-14)

* fix(minio): reduce ttlSecondsAfterFinished to 20sec ([9be7d34](https://github.com/GitGuardian/gitguardian-helm-charts/commit/9be7d34))
* Update CHANGELOG.md ([fdffec9](https://github.com/GitGuardian/gitguardian-helm-charts/commit/fdffec9))
* fix(minio): reduce ttlSecondsAfterFinished to 20sec ([40741dd](https://github.com/GitGuardian/gitguardian-helm-charts/commit/40741dd))
* Update CHANGELOG.md ([4e93e9d](https://github.com/GitGuardian/gitguardian-helm-charts/commit/4e93e9d))
* fix(minio): hook deletion on job ([d2d52c7](https://github.com/GitGuardian/gitguardian-helm-charts/commit/d2d52c7))
* add tests for openshift (#226) ([c80c98a](https://github.com/GitGuardian/gitguardian-helm-charts/commit/c80c98a))
* fix(minio): values schema update ([16d9950](https://github.com/GitGuardian/gitguardian-helm-charts/commit/16d9950))

## 0.5.0 (2025-10-08)

* feat(minio): add serviceAccount to MinIO deployment (#14) ([264d4ea](https://github.com/GitGuardian/gitguardian-helm-charts/commit/264d4ea))
*  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([45499b9](https://github.com/GitGuardian/gitguardian-helm-charts/commit/45499b9))
* add post job to auto create default buckets (#9) ([493263e](https://github.com/GitGuardian/gitguardian-helm-charts/commit/493263e))

## 0.4.0 (2025-10-06)

* chore(minio): updates values schema ([2324d75](https://github.com/GitGuardian/gitguardian-helm-charts/commit/2324d75))
* add post job to auto create default buckets (#9) ([b22d523](https://github.com/GitGuardian/gitguardian-helm-charts/commit/b22d523))
*  [minio, mongodb, postgres, timescaledb] Update securityContext to containerSecurityContext in the values schema (#213) ([8a4003f](https://github.com/GitGuardian/gitguardian-helm-charts/commit/8a4003f))
* feat(sh): add contrib script ([e70c17f](https://github.com/GitGuardian/gitguardian-helm-charts/commit/e70c17f))

## 0.3.0 (2025-10-02)

* make minio run on openshift (#203) ([18c7be5](https://github.com/GitGuardian/gitguardian-helm-charts/commit/18c7be5))
* fix(minio): revert to 0.2.4 ([b660d6f](https://github.com/GitGuardian/gitguardian-helm-charts/commit/b660d6f))
* feat(ci): implement ci for for workflow ([46ee227](https://github.com/GitGuardian/gitguardian-helm-charts/commit/46ee227))

## 0.2.4 (2025-09-30)

* add more configuration options for the minio server (#189) ([8066d07](https://github.com/GitGuardian/gitguardian-helm-charts/commit/8066d07))

## 0.2.3 (2025-09-15)

* Update CHANGELOG.md ([55a987f](https://github.com/GitGuardian/gitguardian-helm-charts/commit/55a987f))
* bump verion to 0.2.3 ([af6beca](https://github.com/GitGuardian/gitguardian-helm-charts/commit/af6beca))
* set strategy to recreate in deployment ([6e01f97](https://github.com/GitGuardian/gitguardian-helm-charts/commit/6e01f97))

## 0.2.2 (2025-09-15)

* Update CHANGELOG.md ([f31d5a5](https://github.com/GitGuardian/gitguardian-helm-charts/commit/f31d5a5))
* update minio README.md ([cbca20c](https://github.com/GitGuardian/gitguardian-helm-charts/commit/cbca20c))
* bump version to 0.2.2 ([afaf2d1](https://github.com/GitGuardian/gitguardian-helm-charts/commit/afaf2d1))
* add option to use cpu-v1 image ([91bfd29](https://github.com/GitGuardian/gitguardian-helm-charts/commit/91bfd29))

## 0.2.1 (2025-09-08)

* Update CHANGELOG.md ([bb8e730](https://github.com/GitGuardian/gitguardian-helm-charts/commit/bb8e730))
* Update appVersion ([5c23cb1](https://github.com/GitGuardian/gitguardian-helm-charts/commit/5c23cb1))
* Update CHANGELOG.md ([82fe11f](https://github.com/GitGuardian/gitguardian-helm-charts/commit/82fe11f))
* Upgrade minio to latest stable ([94ab830](https://github.com/GitGuardian/gitguardian-helm-charts/commit/94ab830))
* revert 3 ([d8ced5c](https://github.com/GitGuardian/gitguardian-helm-charts/commit/d8ced5c))
* revert 2 ([b64c81d](https://github.com/GitGuardian/gitguardian-helm-charts/commit/b64c81d))
* Update CHANGELOG.md ([808cae0](https://github.com/GitGuardian/gitguardian-helm-charts/commit/808cae0))
* revert ([ba71354](https://github.com/GitGuardian/gitguardian-helm-charts/commit/ba71354))
* Upgrade minio to latest stable ([b199ea4](https://github.com/GitGuardian/gitguardian-helm-charts/commit/b199ea4))

## 0.2.0 (2025-09-02)

* bump all chart versions for new extraObjects feature ([aaa57f9](https://github.com/GitGuardian/gitguardian-helm-charts/commit/aaa57f9))
* add extraObject array to all charts ([34772b7](https://github.com/GitGuardian/gitguardian-helm-charts/commit/34772b7))

## 0.1.8 (2025-08-27)

* Fix values.yaml / Chart.yaml linting issues ([043c7e0](https://github.com/GitGuardian/gitguardian-helm-charts/commit/043c7e0))
* Add initial Changelogs to all Charts ([68f10ca](https://github.com/GitGuardian/gitguardian-helm-charts/commit/68f10ca))

## 0.1.7 (2025-08-26)

* Initial tagged release
