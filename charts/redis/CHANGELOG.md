# Changelog

All notable changes to this chart will be documented in this file.

## [0.23.0] - 2026-02-16

- [universal]: Bump all charts to common 2.2.0 (#1020) ([cbeb5b19](https://github.com/CloudPirates-io/helm-charts/commit/cbeb5b19))

## [0.22.3] - 2026-02-16

- [alpine/kubectl] Update image to v1.35.1 (#1016) ([c9b58fcf](https://github.com/CloudPirates-io/helm-charts/commit/c9b58fcf))

## [0.22.2] - 2026-02-12

- [redis]: Add explicit timeout for redis-cli pings instead of 240s default (#1005) ([3e7c2a2c](https://github.com/CloudPirates-io/helm-charts/commit/3e7c2a2c))

## [0.22.1] - 2026-02-12

- [oliver006/redis_exporter] Update image to v1.81.0 (#997) ([3c6bb716](https://github.com/CloudPirates-io/helm-charts/commit/3c6bb716))

## [0.22.0] - 2026-02-11

- Update charts/redis/values.yaml redis to v8.6.0 (minor) (#994) ([f0c64173](https://github.com/CloudPirates-io/helm-charts/commit/f0c64173))

## [0.21.8] - 2026-02-04

- Update charts/redis/values.yaml redis (#955) ([bb7642f0](https://github.com/CloudPirates-io/helm-charts/commit/bb7642f0))

## [0.21.7] - 2026-02-03

- [redis]: Adjust condition around serviceAccountName (#945) ([ff1ee153](https://github.com/CloudPirates-io/helm-charts/commit/ff1ee153))

## [0.21.6] - 2026-02-03

- Update charts/redis/values.yaml redis (#944) ([d8910387](https://github.com/CloudPirates-io/helm-charts/commit/d8910387))
- [all]: Update documentation to include proper cosign public key ([e42365dc](https://github.com/CloudPirates-io/helm-charts/commit/e42365dc))

## [0.21.5] - 2026-02-02

- [redis]: Implement existingFilePath for acl on redis (#936) ([29457105](https://github.com/CloudPirates-io/helm-charts/commit/29457105))

## [0.21.4] - 2026-01-30

- [redis]: Seperate client and server tls certs for liveness and readiness probes (#883) ([e643acf4](https://github.com/CloudPirates-io/helm-charts/commit/e643acf4))

## [0.21.3] - 2026-01-28

- [all]: Update every chart to newest common (#920) ([f8d134d5](https://github.com/CloudPirates-io/helm-charts/commit/f8d134d5))

## [0.21.2] - 2026-01-27

- [oliver006/redis_exporter] Update image to v1.80.2 (#908) ([d8034e25](https://github.com/CloudPirates-io/helm-charts/commit/d8034e25))

## [0.21.1] - 2026-01-26

- Fix network policy egress, improve cluster init job reliability (#894) ([cf622362](https://github.com/CloudPirates-io/helm-charts/commit/cf622362))

## [0.21.0] - 2026-01-19

- [redis]: Configurable log level through values.yaml (#862) ([3ca65234](https://github.com/CloudPirates-io/helm-charts/commit/3ca65234))

## [0.20.9] - 2026-01-19

- Update charts/redis/values.yaml redis (#857) ([625d9f57](https://github.com/CloudPirates-io/helm-charts/commit/625d9f57))

## [0.20.8] - 2026-01-19

- don't create secret when acl is enabled (#851) ([21cb78c4](https://github.com/CloudPirates-io/helm-charts/commit/21cb78c4))

## [0.20.7] - 2026-01-17

- Allow disabling egress in network policy, headless service should publish not ready addresses when sentinel is enabled (#843) ([32119084](https://github.com/CloudPirates-io/helm-charts/commit/32119084))

## [0.20.6] - 2026-01-09

- Include Sentinel port in default service when enabled (#811) ([32afbf17](https://github.com/CloudPirates-io/helm-charts/commit/32afbf17))
- Update charts/redis/values.yaml redis (#820) ([8bac28e5](https://github.com/CloudPirates-io/helm-charts/commit/8bac28e5))

## [0.20.5] - 2026-01-08

- [alpine/kubectl] Update image to v1.35.0 (#775) ([4f78b862](https://github.com/CloudPirates-io/helm-charts/commit/4f78b862))

## [0.20.4] - 2026-01-08

- Cluster add support for custom conig in redis.conf #756 ([90ed6a7c](https://github.com/CloudPirates-io/helm-charts/commit/90ed6a7c))

## [0.20.3] - 2026-01-08

- [redis]: Missing CPU Limit in values.yaml #800 ([b09ce6dc](https://github.com/CloudPirates-io/helm-charts/commit/b09ce6dc))

## [0.20.2] - 2026-01-08

- [redis]: fix prestop failover verification logic (#803) ([4c109183](https://github.com/CloudPirates-io/helm-charts/commit/4c109183))

## [0.20.1] - 2026-01-05

- change exporter image to alpine based and fix command rendering (#795) ([63662dce](https://github.com/CloudPirates-io/helm-charts/commit/63662dce))

## [0.20.0] - 2026-01-05

- [redis]: support zero-downtime upgrades with Sentinel failover (#782) ([1be7c755](https://github.com/CloudPirates-io/helm-charts/commit/1be7c755))

## [0.19.0] - 2026-01-01

- add option to configure auth via acl (#780) ([208eaadd](https://github.com/CloudPirates-io/helm-charts/commit/208eaadd))

## [0.18.0] - 2025-12-23

- [redis]: add sentinel monitoring (#774) ([00e4fefc](https://github.com/CloudPirates-io/helm-charts/commit/00e4fefc))

## [0.17.7] - 2025-12-23

- [redis]: add missing label for sentinel (#773) ([9df4b001](https://github.com/CloudPirates-io/helm-charts/commit/9df4b001))

## [0.17.6] - 2025-12-22

- [redis]: Implement proxy for non sentinel aware proxies (#703) ([0e2ac9f9](https://github.com/CloudPirates-io/helm-charts/commit/0e2ac9f9))

## [0.17.5] - 2025-12-17

- chore(redis): Bump version to 0.17.5 (#762) ([daa894ea](https://github.com/CloudPirates-io/helm-charts/commit/daa894ea))
- fix(redis): Always set masterauth for non-standalone architectures (#750) ([a8b07f48](https://github.com/CloudPirates-io/helm-charts/commit/a8b07f48))

## [0.17.4] - 2025-12-16

- add readiness and liveness probes to redis sentinel (#755) ([594cf3d2](https://github.com/CloudPirates-io/helm-charts/commit/594cf3d2))

## [0.17.3] - 2025-12-11

- [redis, valkey,rabbitmq,zookeeper]: allow setting revisionHistoryLimit (#725) ([ac9e1ba9](https://github.com/CloudPirates-io/helm-charts/commit/ac9e1ba9))

## [0.17.2] - 2025-12-11

- fix(redis): prevent password logging in sentinel startup (#731) ([2e859400](https://github.com/CloudPirates-io/helm-charts/commit/2e859400))

## [0.17.1] - 2025-12-11

- fix(redis): Fix headless-service annotations rendering for empty values (#734) ([4e95aa6a](https://github.com/CloudPirates-io/helm-charts/commit/4e95aa6a))

## [0.17.0] - 2025-12-10

- [redis]: allow changing revisionHistoryLimit (#723) ([38a42388](https://github.com/CloudPirates-io/helm-charts/commit/38a42388))
- Update charts/redis/values.yaml redis (#716) ([887591b0](https://github.com/CloudPirates-io/helm-charts/commit/887591b0))

## [0.16.7] - 2025-12-09

- Update charts/redis/values.yaml redis (#713) ([689ef890](https://github.com/CloudPirates-io/helm-charts/commit/689ef890))

## [0.16.6] - 2025-12-06

- return fqdn for sentinel replicas lookup (#700) (#701) ([76a4a103](https://github.com/CloudPirates-io/helm-charts/commit/76a4a103))

## [0.16.5] - 2025-12-05

- Fix Redis issue with immutableFields cause by the label addition on volumeClaimTemplate (#695) ([f5ce66fb](https://github.com/CloudPirates-io/helm-charts/commit/f5ce66fb))

## [0.16.4] - 2025-12-03

- metrics service annotation does not work (#687) ([6c053afb](https://github.com/CloudPirates-io/helm-charts/commit/6c053afb))

## [0.16.3] - 2025-12-01

- add resources to init-cluster job (#680) ([63f8d229](https://github.com/CloudPirates-io/helm-charts/commit/63f8d229))

## [0.16.2] - 2025-12-01

- set save in config if persistence is disabled (#677) ([4fdcde0c](https://github.com/CloudPirates-io/helm-charts/commit/4fdcde0c))

## [0.16.1] - 2025-12-01

- [universal] add labels to statefulset pvc-templates (#681) ([87624a55](https://github.com/CloudPirates-io/helm-charts/commit/87624a55))

## [0.16.0] - 2025-11-25

- Update charts/redis/values.yaml redis to v8.4.0 (minor) (#633) ([96c8dd71](https://github.com/CloudPirates-io/helm-charts/commit/96c8dd71))

## [0.15.4] - 2025-11-25

- [oliver006/redis_exporter] Update image to v1.80.1 (#655) ([fcb59bc3](https://github.com/CloudPirates-io/helm-charts/commit/fcb59bc3))

## [0.15.3] - 2025-11-20

- add option to use ip or hostname for sentinal announce-ip (#639) ([639cd319](https://github.com/CloudPirates-io/helm-charts/commit/639cd319))

## [0.15.2] - 2025-11-19

- fix condition in statefulset (#637) ([8b74e742](https://github.com/CloudPirates-io/helm-charts/commit/8b74e742))

## [0.15.1] - 2025-11-19

- [redis]: tls support ([963e2b88](https://github.com/CloudPirates-io/helm-charts/commit/963e2b88))

## [0.15.0] - 2025-11-19

- Add ServiceAccount (#631) ([328f6986](https://github.com/CloudPirates-io/helm-charts/commit/328f6986))
- Update charts/redis/values.yaml redis (#624) ([a57d0d7c](https://github.com/CloudPirates-io/helm-charts/commit/a57d0d7c))

## [0.14.4] - 2025-11-18

- add templating to all annotations (#608) ([2a78f9d8](https://github.com/CloudPirates-io/helm-charts/commit/2a78f9d8))

## [0.14.3] - 2025-11-18

- sentinel use hostnames (#615) ([0a0357b9](https://github.com/CloudPirates-io/helm-charts/commit/0a0357b9))

## [0.14.2] - 2025-11-17

- [mongodb/redis/posgres] Add subPath option when using existingClaim (#613) ([8aa277e1](https://github.com/CloudPirates-io/helm-charts/commit/8aa277e1))

## [0.14.1] - 2025-11-13

- [universal] update readme files (#583) ([e63f5f94](https://github.com/CloudPirates-io/helm-charts/commit/e63f5f94))
- Update charts/redis/values.yaml redis (#554) ([1737c287](https://github.com/CloudPirates-io/helm-charts/commit/1737c287))

## [0.14.0] - 2025-11-07

- [redis]: Headless Service annotations ([10daf471](https://github.com/CloudPirates-io/helm-charts/commit/10daf471))

## [0.13.4] - 2025-11-04

- Update charts/redis/values.yaml redis (#547) ([f0ba3c61](https://github.com/CloudPirates-io/helm-charts/commit/f0ba3c61))

## [0.13.3] - 2025-11-04

- [redis]: fix sidecar auth args ([967558f3](https://github.com/CloudPirates-io/helm-charts/commit/967558f3))

## [0.13.2] - 2025-11-04

- Update charts/redis/values.yaml redis to v8.2.3 (patch) (#536) ([2410eff0](https://github.com/CloudPirates-io/helm-charts/commit/2410eff0))

## [0.13.1] - 2025-11-03

- [oliver006/redis_exporter] Update image to v1.80.0 (#532) ([f3577714](https://github.com/CloudPirates-io/helm-charts/commit/f3577714))

## [0.13.0] - 2025-10-31

- Implement startup probe ([579459a8](https://github.com/CloudPirates-io/helm-charts/commit/579459a8))

## [0.12.1] - 2025-10-31

- Fix probes commands (#511) ([0ac529f0](https://github.com/CloudPirates-io/helm-charts/commit/0ac529f0))

## [0.12.0] - 2025-10-30

- Add support for Redis Cluster (#507) ([c1e9fa8d](https://github.com/CloudPirates-io/helm-charts/commit/c1e9fa8d))

## [0.11.2] - 2025-10-30

- fix: extraEnvVars parameter in statefulset template (#503) ([b681b999](https://github.com/CloudPirates-io/helm-charts/commit/b681b999))

## [0.11.1] - 2025-10-29

- fix: metrics sidecar variable expansion (#499) ([af02f4a7](https://github.com/CloudPirates-io/helm-charts/commit/af02f4a7))

## [0.11.0] - 2025-10-29

- Add master service for non-sentinel replication mode (#492) ([cafeccda](https://github.com/CloudPirates-io/helm-charts/commit/cafeccda))

## [0.10.2] - 2025-10-28

- Add support for extraPorts in Services and StatefulSet (#485) ([18055225](https://github.com/CloudPirates-io/helm-charts/commit/18055225))
- [etcd, rabbitmq, redis, zookeeper] add signature verification documentation to readme (#476) ([91c73105](https://github.com/CloudPirates-io/helm-charts/commit/91c73105))

## [0.10.0] - 2025-10-28

- [universal] unify extraEnvVars in all charts (#477) ([4aee7b4a](https://github.com/CloudPirates-io/helm-charts/commit/4aee7b4a))

## [0.9.8] - 2025-10-27

- fix service annotations (#470) ([74d2a994](https://github.com/CloudPirates-io/helm-charts/commit/74d2a994))

## [0.9.7] - 2025-10-26

- Redis / Rabbitmq: add lifecyle hooks ([b2537768](https://github.com/CloudPirates-io/helm-charts/commit/b2537768))

## [0.9.6] - 2025-10-23

- [universal] Update annotations, labels, podannotations and podlabel (#454) ([cdb38db9](https://github.com/CloudPirates-io/helm-charts/commit/cdb38db9))

## [0.9.5] - 2025-10-22

- add service support annotations (#446) ([72e7eb72](https://github.com/CloudPirates-io/helm-charts/commit/72e7eb72))

## [0.9.4] - 2025-10-22

- Update charts/redis/values.yaml redis (#434) ([b833a77b](https://github.com/CloudPirates-io/helm-charts/commit/b833a77b))

## [0.9.3] - 2025-10-22

- [universal]: Support extra secret templating (#444) ([c2b20246](https://github.com/CloudPirates-io/helm-charts/commit/c2b20246))

## [0.9.2] - 2025-10-21

- Modifiable cluster domain (#427) ([88652de1](https://github.com/CloudPirates-io/helm-charts/commit/88652de1))
- [universal] add --upload=true to cosign sign (#437) ([e89e0ee4](https://github.com/CloudPirates-io/helm-charts/commit/e89e0ee4))

## [0.9.1] - 2025-10-21

- add support for replication mode without sentinel (#428) ([8cbfff28](https://github.com/CloudPirates-io/helm-charts/commit/8cbfff28))
- [unversal] Add signing informations for artifacthub (#415) ([e761c906](https://github.com/CloudPirates-io/helm-charts/commit/e761c906))

## [0.9.0] - 2025-10-17

- Network policies (#412) ([43c7285b](https://github.com/CloudPirates-io/helm-charts/commit/43c7285b))
- [universal] use a string instead of a boolean (#413) ([c24d26d6](https://github.com/CloudPirates-io/helm-charts/commit/c24d26d6))
- [universal] improve chart artifact annotations (#404) ([37f1c5be](https://github.com/CloudPirates-io/helm-charts/commit/37f1c5be))

## [0.8.5] - 2025-10-17

- [oliver006/redis_exporter] Update image to v1.79.0 (#408) ([11c625a3](https://github.com/CloudPirates-io/helm-charts/commit/11c625a3))

## [0.8.4] - 2025-10-17

- Allow Sentinel authentication to be configured independently from Redis authentication (#403) ([ac126164](https://github.com/CloudPirates-io/helm-charts/commit/ac126164))

## [0.8.3] - 2025-10-15

- Add initContainer securityContext and improve security defaults (#397) ([2b5c4bd2](https://github.com/CloudPirates-io/helm-charts/commit/2b5c4bd2))
- [universal] Rework all schema json (#393) ([79d1439f](https://github.com/CloudPirates-io/helm-charts/commit/79d1439f))

## [0.8.2] - 2025-10-14

- Add additional args (#384) ([6dc59ebd](https://github.com/CloudPirates-io/helm-charts/commit/6dc59ebd))

## [0.8.1] - 2025-10-14

- Fix namespace key prefix on redis pdb (#385) ([6451b4cc](https://github.com/CloudPirates-io/helm-charts/commit/6451b4cc))

## [0.8.0] - 2025-10-14

- Add pdb and rootOnlyFilesystem options (#383) ([86b889fb](https://github.com/CloudPirates-io/helm-charts/commit/86b889fb))

## [0.7.0] - 2025-10-14

- Update chart.yaml dependencies for indepentent charts (#382) ([87acfb14](https://github.com/CloudPirates-io/helm-charts/commit/87acfb14))

## [0.6.4] - 2025-10-13

- [universal] Fix imagepullsecret in vales.schema.json (#374) ([bcc566c2](https://github.com/CloudPirates-io/helm-charts/commit/bcc566c2))
- [universal]: Fix changelog generation (#354) ([2e973c09](https://github.com/CloudPirates-io/helm-charts/commit/2e973c09))

## [0.6.3] - 2025-10-10

- feat: use "common.namespace" (#332) ([6dd8563c](https://github.com/CloudPirates-io/helm-charts/commit/6dd8563c))

## [0.6.2] - 2025-10-09

- fix: better IPv6 compatibility (#296) ([1d3543c7](https://github.com/CloudPirates-io/helm-charts/commit/1d3543c7))
- [mongodb] fix: newline between mongo labels and additional labels (#301) ([ea7937ff](https://github.com/CloudPirates-io/helm-charts/commit/ea7937ff))

## [0.6.1] - 2025-10-09

- [redis , rabbitmq]: Add podAnnotations (#294) ([6d788697](https://github.com/CloudPirates-io/helm-charts/commit/6d788697))
- add tests for openshift (#226) ([c80c98ac](https://github.com/CloudPirates-io/helm-charts/commit/c80c98ac))
- [mongodb] feat: add metrics exporter (#243) ([c931978f](https://github.com/CloudPirates-io/helm-charts/commit/c931978f))

## [0.6.0] - 2025-10-09

- Include podLabels in redis statefulset (#274) ([024da558](https://github.com/CloudPirates-io/helm-charts/commit/024da558))

## [0.5.7] - 2025-10-09

- Update charts/redis/values.yaml redis to v8.2.2 (patch) (#264) ([f699d004](https://github.com/CloudPirates-io/helm-charts/commit/f699d004))

## [0.5.6] - 2025-10-08

- [oliver006/redis_exporter] Update oliver006/redis_exporter to v1.78.0 (#235) ([508fd61b](https://github.com/CloudPirates-io/helm-charts/commit/508fd61b))

## [0.5.5] - 2025-10-08

- Update redis to v8.2.2 (#233) ([363468b8](https://github.com/CloudPirates-io/helm-charts/commit/363468b8))

## [0.5.4] - 2025-10-08

- [redis]: fix dual stack networking issues (#227) ([381bd769](https://github.com/CloudPirates-io/helm-charts/commit/381bd769))

## [0.5.3] - 2025-10-06

- Add automatically generated fields to volumeClaimTemplates (#218) ([5f4142b2](https://github.com/CloudPirates-io/helm-charts/commit/5f4142b2))

## [0.5.2] - 2025-10-06

- chore(deps): update redis:8.2.1 Docker digest to 5fa2edb (#188) ([6a72e004](https://github.com/CloudPirates-io/helm-charts/commit/6a72e004))

## [0.5.1] - 2025-10-06

- chore(deps): update docker.io/redis:8.2.1 Docker digest to 5fa2edb (#187) ([fe21dc26](https://github.com/CloudPirates-io/helm-charts/commit/fe21dc26))

## [0.5.0] - 2025-10-01

- make redis run on openshift (#193) ([cc4d3c33](https://github.com/CloudPirates-io/helm-charts/commit/cc4d3c33))

## [0.4.6] - 2025-09-25

- return fqdn for sentinel master lookup (#156) ([00b9882f](https://github.com/CloudPirates-io/helm-charts/commit/00b9882f))

## [0.4.5] - 2025-09-24

- Update CHANGELOG.md ([7691aa0c](https://github.com/CloudPirates-io/helm-charts/commit/7691aa0c))
- requirepass for sentinel cli operations when password is set ([60d1b5ca](https://github.com/CloudPirates-io/helm-charts/commit/60d1b5ca))
- Update CHANGELOG.md ([fcf698f0](https://github.com/CloudPirates-io/helm-charts/commit/fcf698f0))
- Update CHANGELOG.md ([1afe4985](https://github.com/CloudPirates-io/helm-charts/commit/1afe4985))
- Update CHANGELOG.md ([0da41aa3](https://github.com/CloudPirates-io/helm-charts/commit/0da41aa3))
- Update CHANGELOG.md ([8425f12e](https://github.com/CloudPirates-io/helm-charts/commit/8425f12e))
- Update CHANGELOG.md ([2753a1ed](https://github.com/CloudPirates-io/helm-charts/commit/2753a1ed))

## [0.4.4] - 2025-09-23

- Update CHANGELOG.md ([f6ea97b1](https://github.com/CloudPirates-io/helm-charts/commit/f6ea97b1))
- Update CHANGELOG.md ([9bd42ad4](https://github.com/CloudPirates-io/helm-charts/commit/9bd42ad4))
- [redis]: Persistent volume claim retentionpolicy ([1f708a5a](https://github.com/CloudPirates-io/helm-charts/commit/1f708a5a))

## [0.4.3] - 2025-09-23

- Update CHANGELOG.md ([497514fe](https://github.com/CloudPirates-io/helm-charts/commit/497514fe))
- add volumeMounts option for sentinel container ([84993076](https://github.com/CloudPirates-io/helm-charts/commit/84993076))

## [0.4.2] - 2025-09-23

- Update CHANGELOG.md ([18008d20](https://github.com/CloudPirates-io/helm-charts/commit/18008d20))
- bump up chart patch version ([c436c6d6](https://github.com/CloudPirates-io/helm-charts/commit/c436c6d6))
- Add topologySpreadConstraints option to the chart ([9c9eeeb9](https://github.com/CloudPirates-io/helm-charts/commit/9c9eeeb9))

## [0.4.1] - 2025-09-23

- bump up chart patch version ([a5c9dfb2](https://github.com/CloudPirates-io/helm-charts/commit/a5c9dfb2))
- Add metrics section to the README ([14a37bc6](https://github.com/CloudPirates-io/helm-charts/commit/14a37bc6))

## [0.4.0] - 2025-09-22

- Fix reviews ([87c780cc](https://github.com/CloudPirates-io/helm-charts/commit/87c780cc))
- Update CHANGELOG.md ([dfaff035](https://github.com/CloudPirates-io/helm-charts/commit/dfaff035))
- Implement redis service monitoring ([3aec93d1](https://github.com/CloudPirates-io/helm-charts/commit/3aec93d1))

## [0.3.3] - 2025-09-18

- Update CHANGELOG.md ([e60664c7](https://github.com/CloudPirates-io/helm-charts/commit/e60664c7))
- chore: bump chart version ([b8bec46f](https://github.com/CloudPirates-io/helm-charts/commit/b8bec46f))
- feat: bind resource to init-container resources from values ([014db833](https://github.com/CloudPirates-io/helm-charts/commit/014db833))
- feat: add init container resources configurable values ([852ac342](https://github.com/CloudPirates-io/helm-charts/commit/852ac342))

## [0.3.2] - 2025-09-18

- Update CHANGELOG.md ([025e4b21](https://github.com/CloudPirates-io/helm-charts/commit/025e4b21))
- Fix lint ([9943a660](https://github.com/CloudPirates-io/helm-charts/commit/9943a660))
- Bump chart version ([a8924929](https://github.com/CloudPirates-io/helm-charts/commit/a8924929))
- Fix pod not restarting after configmap change ([81816495](https://github.com/CloudPirates-io/helm-charts/commit/81816495))

## [0.3.1] - 2025-09-17

- Update CHANGELOG.md ([a4c0fd0f](https://github.com/CloudPirates-io/helm-charts/commit/a4c0fd0f))
- fix sentinel conditions. set default to standalone ([bf935faa](https://github.com/CloudPirates-io/helm-charts/commit/bf935faa))

## [0.3.0] - 2025-09-15

- Decrease defaults ([572cba97](https://github.com/CloudPirates-io/helm-charts/commit/572cba97))
- Bitnami style fail over script ([9b9a395f](https://github.com/CloudPirates-io/helm-charts/commit/9b9a395f))
- Unhardcode ips ([b6e0a4ef](https://github.com/CloudPirates-io/helm-charts/commit/b6e0a4ef))
- Implement suggested improvements ([aeac191f](https://github.com/CloudPirates-io/helm-charts/commit/aeac191f))
- Improve defaults ([b9648256](https://github.com/CloudPirates-io/helm-charts/commit/b9648256))
- Configurable recheck values ([cf319619](https://github.com/CloudPirates-io/helm-charts/commit/cf319619))
- Full rework ([a8f4e562](https://github.com/CloudPirates-io/helm-charts/commit/a8f4e562))
- Update CHANGELOG.md ([103dbd57](https://github.com/CloudPirates-io/helm-charts/commit/103dbd57))
- Sync on restart if sentinel available ([628128e9](https://github.com/CloudPirates-io/helm-charts/commit/628128e9))
- Minor improvements ([016dee25](https://github.com/CloudPirates-io/helm-charts/commit/016dee25))
- Update CHANGELOG.md ([46573705](https://github.com/CloudPirates-io/helm-charts/commit/46573705))
- Fix invalid master detection ([f1545d9c](https://github.com/CloudPirates-io/helm-charts/commit/f1545d9c))
- Fix roles ([9f6cd01b](https://github.com/CloudPirates-io/helm-charts/commit/9f6cd01b))
- Update CHANGELOG.md ([e572ff3b](https://github.com/CloudPirates-io/helm-charts/commit/e572ff3b))
- fix lint ([c9a0e4fa](https://github.com/CloudPirates-io/helm-charts/commit/c9a0e4fa))
- Bump chart version ([a6ac9084](https://github.com/CloudPirates-io/helm-charts/commit/a6ac9084))
- Implement redis sentinal functionality ([70d64d52](https://github.com/CloudPirates-io/helm-charts/commit/70d64d52))

## [0.2.1] - 2025-09-09

- Update CHANGELOG.md ([507c1874](https://github.com/CloudPirates-io/helm-charts/commit/507c1874))
- Bump version ([43dceb24](https://github.com/CloudPirates-io/helm-charts/commit/43dceb24))
- Update docker.io/redis:8.2.1 Docker digest to acb90ce ([eb469b05](https://github.com/CloudPirates-io/helm-charts/commit/eb469b05))

## [0.2.0] - 2025-09-02

- bump all chart versions for new extraObjects feature ([aaa57f90](https://github.com/CloudPirates-io/helm-charts/commit/aaa57f90))
- add extraObject array to all charts ([34772b70](https://github.com/CloudPirates-io/helm-charts/commit/34772b70))

## [0.1.8] - 2025-08-31

- Update CHANGELOG.md ([d1c5ba24](https://github.com/CloudPirates-io/helm-charts/commit/d1c5ba24))
- Add support for statefulset priorityclassname ([b5847dd7](https://github.com/CloudPirates-io/helm-charts/commit/b5847dd7))

## [0.1.7] - 2025-08-28

- Update CHANGELOG.md ([26bf940d](https://github.com/CloudPirates-io/helm-charts/commit/26bf940d))
- Bump chart version ([395c7d5e](https://github.com/CloudPirates-io/helm-charts/commit/395c7d5e))
- Fix typo in readme ([cce0ea8a](https://github.com/CloudPirates-io/helm-charts/commit/cce0ea8a))

## [0.1.6] - 2025-08-27

- Fix values.yaml / Chart.yaml linting issues ([043c7e0a](https://github.com/CloudPirates-io/helm-charts/commit/043c7e0a))
- Add initial Changelogs to all Charts ([68f10ca2](https://github.com/CloudPirates-io/helm-charts/commit/68f10ca2))

## [0.1.5] - 2025-08-26

- Initial release

