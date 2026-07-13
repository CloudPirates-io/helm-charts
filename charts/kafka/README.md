<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-kafka/kafka"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-kafka" /></a>
</p>

# Kafka Helm Chart

Apache Kafka is a distributed event streaming platform used for high-performance data pipelines, streaming analytics, and data integration. This chart deploys Kafka in **KRaft mode** using the official [`apache/kafka`](https://hub.docker.com/r/apache/kafka) image, so **no ZooKeeper is required**.

Each replica runs as a combined **broker + controller** node, which keeps the deployment self-contained and simple to operate for small and medium clusters.

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-kafka`:

```bash
helm install my-kafka oci://registry-1.docker.io/cloudpirates/kafka
```

To install with custom values:

```bash
helm install my-kafka oci://registry-1.docker.io/cloudpirates/kafka -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-kafka ./charts/kafka
```

The command deploys Kafka on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Security & Signature Verification

This Helm chart is cryptographically signed with Cosign to ensure authenticity and prevent tampering.

To verify the helm chart before installation, copy the public key from the repository's `cosign.pub` and run cosign:

```bash
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/kafka:<version>
```

## Getting Started

The chart provisions a `StatefulSet` of Kafka nodes plus two services:

- `<release>-kafka` – a `ClusterIP` service for client/bootstrap connections (port `9092`).
- `<release>-kafka-headless` – a headless service used for inter-node controller traffic and stable pod DNS.

### Bootstrap server

From inside the cluster, connect your clients to:

```
<release>-kafka.<namespace>.svc.cluster.local:9092
```

### Produce and consume a test message

```bash
kubectl run kafka-client --rm -it --restart='Never' \
  --image apache/kafka:4.2.1 -- bash

# Inside the pod:
/opt/kafka/bin/kafka-topics.sh --create --topic demo \
  --bootstrap-server my-kafka:9092 --partitions 3 --replication-factor 3

/opt/kafka/bin/kafka-console-producer.sh --topic demo \
  --bootstrap-server my-kafka:9092

/opt/kafka/bin/kafka-console-consumer.sh --topic demo --from-beginning \
  --bootstrap-server my-kafka:9092
```

## How it works

- **KRaft, combined mode**: every node sets `process.roles=broker,controller`. The static `controller.quorum.voters` list is generated from `replicaCount` and the stable headless DNS names of the pods.
- **Per-node identity**: each pod derives its `node.id` from its StatefulSet ordinal (plus `nodeIdOffset`) and advertises `PLAINTEXT://<pod>.<headless>.<namespace>.svc.cluster.local:9092` so that clients are routed to the correct broker.
- **Storage formatting**: on startup each node formats its KRaft storage with `kafka-storage.sh format --ignore-formatted`, which is idempotent and safe across restarts. The `clusterId` value is used as the cluster UUID and must be identical for all nodes of the same cluster.
- **Read-only root filesystem**: the base `server.properties` is mounted from a ConfigMap; the runtime copy and Kafka logs are written to in-memory `emptyDir` volumes, while log segments are persisted to the data PVC.

> **Note**: `replicaCount` controls both the number of brokers and the size of the KRaft controller quorum. Use an odd number (3 or 5) for production to keep a healthy quorum. Changing `replicaCount` after the cluster has been formatted requires care — see the [Kafka KRaft docs](https://kafka.apache.org/documentation/#kraft).

## Cluster sizing (replicas & replication)

In KRaft combined mode each pod is both a broker and a controller, so `replicaCount` is your
broker count **and** your controller quorum size. Two rules drive sizing:

- **A replication factor can never exceed the number of brokers** — you can't keep 3 copies of data on 1 broker. This chart automatically caps the replication factors to `replicaCount`, so smaller clusters just work (see [Kafka Configuration](#kafka-configuration)).
- **The controller quorum needs a majority to stay available** — `N` controllers tolerate `(N-1)/2` failures, so only an **odd** count gives you fault tolerance.

Match `replicaCount` to your number of **independent nodes** (extra replicas on the same node share its fate and add no real availability):

| Independent nodes | `replicaCount` | Replication factor | Survives a node failure? | Use case |
| ----------------- | -------------- | ------------------ | ------------------------ | -------- |
| 1                 | `1`            | 1                  | No                       | dev / CI / local, non-HA |
| 2                 | `1` (or `2` for a second data copy) | 1–2 | No (even quorum tolerates 0 failures) | small, non-HA |
| 3                 | `3` (default)  | 3                  | Yes (tolerates 1)        | production HA |
| 5                 | `5`            | 3 (capped)         | Yes (tolerates 2)        | larger production |

> Two nodes is the awkward case: a 2-node quorum still tolerates **zero** failures, so it costs double without buying availability. Jump straight from 1 → 3 for fault tolerance.

## Configuration

### Global parameters

| Parameter                     | Description                                              | Default |
| ----------------------------- | -------------------------------------------------------- | ------- |
| `global.imageRegistry`        | Global Docker image registry                             | `""`    |
| `global.imagePullSecrets`     | Global Docker registry secret names as an array          | `[]`    |
| `global.defaultStorageClass`  | Global default StorageClass for PVCs (used when `persistence.storageClass` is empty) | `""` |

### Image Configuration

| Parameter               | Description             | Default                                                                              |
| ----------------------- | ----------------------- | ------------------------------------------------------------------------------------ |
| `image.registry`        | Kafka image registry    | `docker.io`                                                                          |
| `image.repository`      | Kafka image repository  | `apache/kafka`                                                                       |
| `image.tag`             | Kafka image tag         | `4.2.1@sha256:9916d60eca5d599550e2c320230808fda342124ba550bb4ac4ea8591803262a0`      |
| `image.imagePullPolicy` | Kafka image pull policy | `Always`                                                                             |

### Common Parameters

| Parameter                            | Description                                                                              | Default                      |
| ------------------------------------ | ---------------------------------------------------------------------------------------- | ---------------------------- |
| `nameOverride`                       | String to partially override fullname                                                    | `""`                         |
| `fullnameOverride`                   | String to fully override fullname                                                        | `""`                         |
| `namespaceOverride`                  | String to override the namespace for all resources                                       | `""`                         |
| `clusterDomain`                      | Kubernetes cluster domain used to build internal service FQDNs                           | `cluster.local`              |
| `clusterId`                          | KRaft cluster ID used to format storage (identical across all nodes; keep stable). Override per cluster | `oUl0u_8RQBym0t93b891HA` |
| `nodeIdOffset`                       | Offset added to the pod ordinal to compute each node's `node.id`                         | `0`                          |
| `commonLabels`                       | Labels to add to all deployed objects                                                    | `{}`                         |
| `commonAnnotations`                  | Annotations to add to all deployed objects                                               | `{}`                         |
| `replicaCount`                       | Number of Kafka nodes to deploy (broker + controller)                                    | `3`                          |
| `revisionHistoryLimit`               | Number of revisions to keep in history                                                   | `10`                         |
| `podDisruptionBudget.enabled`        | Create a Pod Disruption Budget (only when `replicaCount` > 1)                            | `true`                       |
| `podDisruptionBudget.minAvailable`   | minAvailable for Pod Disruption Budget                                                   | `"51%"`                      |
| `podDisruptionBudget.maxUnavailable` | maxUnavailable for Pod Disruption Budget                                                 | `""`                         |
| `networkPolicy.enabled`              | Enable network policies                                                                  | `false`                      |
| `heapOpts`                           | Kafka JVM heap options (`KAFKA_HEAP_OPTS`)                                                | `-Xmx1G -Xms1G`              |
| `command`                            | Command run after storage formatting, instead of `kafka-server-start.sh` (does not override the container command) | `[]`     |
| `extraArgs`                          | Extra arguments appended to `kafka-server-start.sh` (ignored when `command` is set), e.g. `--override key=value` | `[]`     |

### Kafka Configuration

| Parameter                                          | Description                                                       | Default |
| -------------------------------------------------- | ----------------------------------------------------------------- | ------- |
| `kafkaConfig.numPartitions`                        | Default number of log partitions per topic                        | `3`     |
| `kafkaConfig.defaultReplicationFactor`             | Default replication factor for automatically created topics (capped to `replicaCount`) | `3` |
| `kafkaConfig.offsetsTopicReplicationFactor`        | Replication factor for the offsets topic (capped to `replicaCount`) | `3`   |
| `kafkaConfig.transactionStateLogReplicationFactor` | Replication factor for the transaction state log topic (capped to `replicaCount`) | `3` |
| `kafkaConfig.transactionStateLogMinIsr`            | Minimum in-sync replicas for the transaction state log topic (capped to the effective transaction-log replication factor) | `2` |
| `kafkaConfig.autoCreateTopicsEnable`               | Enable auto creation of topics on the server                      | `true`  |
| `kafkaConfig.logRetentionHours`                    | Number of hours to keep a log file before deleting it             | `168`   |
| `kafkaConfig.extraConfig`                          | Extra Kafka configuration lines appended to `server.properties`   | `[]`    |

> **Replication factors are capped to `replicaCount`.** A replication factor can never exceed the
> number of brokers, so the factors above are automatically clamped — a 1- or 2-node cluster works
> without lowering them by hand, while a 3+ node cluster keeps the full `3`/`2` values. Note that
> Kafka does **not** re-replicate already-created internal topics (e.g. `__consumer_offsets`) when
> you later scale up, so the effective replication of existing topics won't increase on its own.

### Service

| Parameter                       | Description                  | Default     |
| ------------------------------- | ---------------------------- | ----------- |
| `service.type`                  | Kubernetes service type      | `ClusterIP` |
| `service.ports.client`          | Kafka client (broker) port   | `9092`      |
| `service.ports.internal`        | Inter-broker listener port (headless Service only) | `9094` |
| `service.ports.controller`      | Kafka controller (KRaft) port | `9093`     |
| `service.annotations`           | Additional service annotations | `{}`      |

### Authentication

SASL/PLAIN authentication for the client, inter-broker, and controller listeners. Enabled by
default with passwords auto-generated into a Secret and preserved across upgrades (a `lookup`
reuses the existing value, so regenerating the inter-broker/controller passwords can't break the
KRaft quorum). Each boundary can be toggled independently, or you can supply your own credentials
via `auth.existingSecret` (keys: `client-password`, `inter-broker-password`, `controller-password`).
SASL/PLAIN authenticates but does not encrypt — combine it with TLS (below) for `SASL_SSL`.

| Parameter                     | Description                                                                 | Default          |
| ----------------------------- | --------------------------------------------------------------------------- | ---------------- |
| `auth.client.enabled`         | Require SASL/PLAIN on the client listener (apps must send credentials)      | `true`           |
| `auth.interBroker.enabled`    | Require SASL/PLAIN on the inter-broker listener                             | `true`           |
| `auth.controller.enabled`     | Require SASL/PLAIN on the KRaft controller listener                         | `true`           |
| `auth.clientUser`             | Username applications use on the client listener                            | `user`           |
| `auth.clientPassword`         | Password for `clientUser` (auto-generated if empty)                         | `""`             |
| `auth.interBrokerUser`        | Username brokers use to authenticate to each other                          | `inter_broker`   |
| `auth.interBrokerPassword`    | Password for `interBrokerUser` (auto-generated if empty)                    | `""`             |
| `auth.controllerUser`         | Username controller nodes use to authenticate to each other                 | `controller`     |
| `auth.controllerPassword`     | Password for `controllerUser` (auto-generated if empty)                     | `""`             |
| `auth.existingSecret`         | Existing Secret with the passwords (overrides the generated one)            | `""`             |

### TLS

Encrypts all listeners. When enabled, each listener becomes `SSL`, or `SASL_SSL` when the matching
auth boundary is also on. Certificates are supplied as PEM and mounted from a Secret; see
[Using a hardened image](#using-a-hardened-image) for cert-source guidance on minimal images.

| Parameter                              | Description                                                                 | Default          |
| -------------------------------------- | --------------------------------------------------------------------------- | ---------------- |
| `tls.enabled`                          | Enable TLS on all listeners                                                 | `false`          |
| `tls.source`                           | Cert source: `self-signed`, `existing-secret`, or `cert-manager`            | `self-signed`    |
| `tls.existingSecret`                   | Existing Secret with PEM material (required for `existing-secret`)          | `""`             |
| `tls.certFilename`                     | Secret key holding the server certificate (PEM)                             | `tls.crt`        |
| `tls.keyFilename`                      | Secret key holding the private key (PEM)                                    | `tls.key`        |
| `tls.caFilename`                       | Secret key holding the CA certificate (PEM), used as the truststore         | `ca.crt`         |
| `tls.clientAuth`                       | Mutual TLS: `none`, `requested`, or `required`                              | `none`           |
| `tls.autoGenerated.caCommonName`       | CN for the generated CA (defaults to `<release>-ca` when empty)             | `""`             |
| `tls.autoGenerated.daysValid`          | Validity (days) for the generated CA and certificate                        | `3650`           |
| `tls.certManager.duration`             | Requested certificate validity (empty = issuer default)                     | `""`             |
| `tls.certManager.renewBefore`          | Renew-before window (empty = issuer default)                                | `""`             |
| `tls.certManager.issuerRef.name`       | cert-manager Issuer/ClusterIssuer name (required for `cert-manager`)         | `""`             |
| `tls.certManager.issuerRef.kind`       | Issuer kind: `ClusterIssuer` or `Issuer`                                    | `ClusterIssuer`  |
| `tls.certManager.issuerRef.group`      | Issuer API group                                                            | `cert-manager.io`|

### Logging

By default Kafka images log to **both** stdout and rotating files under `$KAFKA_HOME/logs`. This
chart defaults to **console-only logging** (`logging.consoleOnly: true`), which is the recommended
setup for Kubernetes: logs go to stdout (captured by `kubectl logs` and log shippers), nothing is
written to disk, and it works on a read-only root filesystem with any image (including Docker
Hardened Images that otherwise target `/opt/kafka/logs`).

The chart renders a small console-only `log4j2.yaml` into a ConfigMap and points Kafka at it via
`KAFKA_LOG4J_OPTS`. Set `logging.consoleOnly: false` to keep the image's default file + console
logging (the chart mounts a writable `emptyDir` at `/opt/kafka/logs` so file logging works under
the read-only root filesystem), or provide your own config with `logging.existingConfigMap`.

| Parameter                   | Description                                                                 | Default              |
| --------------------------- | --------------------------------------------------------------------------- | -------------------- |
| `logging.consoleOnly`       | Route all Kafka logs to stdout only via a generated log4j2 config           | `true`               |
| `logging.level`             | Root log level for the generated console config                             | `INFO`               |
| `logging.pattern`           | log4j2 PatternLayout for the generated console config                       | `[%d] %p %m (%c)%n`  |
| `logging.existingConfigMap` | Existing ConfigMap (key `log4j2.yaml`) to use instead of the generated one  | `""`                 |

### Metrics

Metrics are exposed by a standalone [`kafka-exporter`](https://github.com/danielqsj/kafka_exporter)
Deployment that connects to the cluster over the broker protocol and exposes cluster-level
Prometheus metrics (consumer-group lag, topic/partition offsets, under-replicated partitions, …).
A single replica covers the whole cluster, so it runs as a Deployment rather than a per-broker
sidecar. Metrics are **disabled by default**; the exporter image is fully configurable.

> The exporter reports cluster/client-level metrics, not per-broker JVM/MBean metrics. If you need
> JVM-level metrics, add a JMX exporter Java agent via `extraEnvVars` (`KAFKA_OPTS`).

| Parameter                              | Description                                                        | Default                  |
| -------------------------------------- | ------------------------------------------------------------------ | ------------------------ |
| `metrics.enabled`                      | Enable the kafka-exporter metrics Deployment                       | `false`                  |
| `metrics.image.registry`               | kafka-exporter image registry                                      | `docker.io`              |
| `metrics.image.repository`             | kafka-exporter image repository                                    | `danielqsj/kafka-exporter` |
| `metrics.image.tag`                    | kafka-exporter image tag                                           | `v1.9.0@sha256:…`        |
| `metrics.containerPort`                | Port the kafka-exporter listens on                                 | `9308`                   |
| `metrics.podAnnotations`               | Annotations for the kafka-exporter pod (e.g. Prometheus scrape annotations) | `{}`            |
| `metrics.extraArgs`                    | Additional command-line flags passed to kafka-exporter             | `[]`                     |
| `metrics.resources`                    | Resource requests and limits for the exporter                      | `{}`                     |
| `metrics.service.type`                 | Metrics service type                                               | `ClusterIP`              |
| `metrics.service.port`                 | Metrics service port                                               | `9308`                   |
| `metrics.serviceMonitor.enabled`       | Create a ServiceMonitor for Prometheus Operator                    | `false`                  |
| `metrics.serviceMonitor.interval`      | Scrape interval                                                    | `30s`                    |
| `metrics.serviceMonitor.scrapeTimeout` | Scrape timeout                                                     | `""`                     |

### Persistence

| Parameter                  | Description                                       | Default               |
| -------------------------- | ------------------------------------------------- | --------------------- |
| `persistence.enabled`      | Enable persistence using Persistent Volume Claims | `true`                |
| `persistence.storageClass` | Storage class (empty = `global.defaultStorageClass` then cluster default; `"-"` = disable provisioning) | `""` |
| `persistence.annotations`  | Persistent Volume Claim annotations               | `{}`                  |
| `persistence.size`         | Persistent Volume size                            | `8Gi`                 |
| `persistence.accessModes`  | Persistent Volume access modes                    | `["ReadWriteOnce"]`   |
| `persistence.existingClaim`| Name of an existing PVC to use                    | `""`                  |
| `persistence.mountPath`    | Path where the data volume is mounted             | `/var/lib/kafka`      |
| `persistence.dataDir`      | Directory used for `log.dirs`                     | `/var/lib/kafka/data` |

### Security Context

| Parameter                                          | Description                              | Default          |
| -------------------------------------------------- | ---------------------------------------- | ---------------- |
| `podSecurityContext.fsGroup`                       | Group ID for the volumes of the pod      | `1000`           |
| `containerSecurityContext.runAsUser`               | Container runAsUser                      | `1000`           |
| `containerSecurityContext.runAsGroup`              | Container runAsGroup                     | `1000`           |
| `containerSecurityContext.runAsNonRoot`            | Run container as non-root                | `true`           |
| `containerSecurityContext.allowPrivilegeEscalation`| Allow privilege escalation               | `false`          |
| `containerSecurityContext.readOnlyRootFilesystem`  | Mount root filesystem as read-only       | `true`           |
| `containerSecurityContext.capabilities`            | Linux capabilities to drop/add           | `drop: [ALL]`    |
| `containerSecurityContext.seccompProfile`          | Seccomp profile for the container        | `RuntimeDefault` |

### Scheduling & Resources

| Parameter            | Description                          | Default |
| -------------------- | ------------------------------------ | ------- |
| `resources`          | Resource requests and limits         | `{}`    |
| `nodeSelector`       | Node selector for pod assignment     | `{}`    |
| `priorityClassName`  | Priority class name for pod eviction | `""`    |
| `tolerations`        | Tolerations for pod assignment       | `[]`    |
| `affinity`           | Affinity rules for pod assignment    | `{}`    |

### Probes

| Parameter                      | Description                                   | Default |
| ------------------------------ | --------------------------------------------- | ------- |
| `livenessProbe.enabled`        | Enable liveness probe                         | `true`  |
| `readinessProbe.enabled`       | Enable readiness probe                        | `true`  |
| `startupProbe.enabled`         | Enable startup probe (gates liveness during KRaft quorum formation) | `true`  |

### Extra Objects

| Parameter           | Description                                       | Default |
| ------------------- | ------------------------------------------------- | ------- |
| `extraEnvVars`      | Additional environment variables                 | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod              | `[]`    |
| `extraVolumeMounts` | Additional volume mounts for the kafka container  | `[]`    |
| `extraObjects`      | Array of extra objects to deploy with the release | `[]`    |

## Using a hardened image

This chart works with hardened Kafka images (e.g. Docker Hardened Images) without any
special flag — unlike databases that bake in a fixed data path, Kafka's data directory is
set by the chart via `log.dirs` and mounted from the PVC, so there is no path divergence to
compensate for. The only thing that typically differs is the run **UID** (DHI's kafka user is
`65532`), which you set through the standard security-context values:

```yaml
image:
  registry: <your-hardened-registry>
  repository: <your-hardened-kafka-repo>
  tag: "<tag>@sha256:<digest>"
podSecurityContext:
  fsGroup: 65532
containerSecurityContext:
  runAsUser: 65532
  runAsGroup: 65532
```

If your hardened image lacks a shell (`/bin/sh`), override `command`/`args` accordingly, since
the default entrypoint uses a small shell wrapper to derive each node's `node.id` and
`advertised.listeners`.

### TLS on hardened images

The PEM keystore is assembled at startup. A key in PKCS#8 form (`-----BEGIN PRIVATE KEY-----`)
is used as-is; a PKCS#1 key (`-----BEGIN RSA PRIVATE KEY-----`) is converted to PKCS#8 with
`openssl`, which Kafka requires. This affects which `tls.source` works on a minimal image:

- **`cert-manager`** — the chart requests `privateKey.encoding: PKCS8`, so no `openssl` is
  needed. Recommended for hardened images.
- **`existing-secret`** — provide a **PKCS#8** key and no `openssl` is needed.
- **`self-signed`** — Helm can only generate PKCS#1 keys, so this source **requires `openssl`
  in the image**. The default `apache/kafka` image (and DHI Debian builds) include it; a stricter
  image that strips `openssl` will fail with `self-signed` — use `cert-manager`/`existing-secret`
  instead.

## Example: production-like values

A 3-node HA cluster with persistent storage and explicit resources, suitable for production.

```yaml
replicaCount: 3
persistence:
  size: 50Gi
  storageClass: fast-ssd
resources:
  requests:
    cpu: 500m
    memory: 2Gi
  limits:
    memory: 4Gi
kafkaConfig:
  extraConfig:
    - "min.insync.replicas=2"   # require 2 in-sync replicas for acks=all writes
```

## Example: single-node (non-HA) values

A single combined broker + controller node, sized small for local development, CI, and
other non-critical workloads (it cannot survive a node failure, so it is **not** for production).
The replication factors are automatically capped to `replicaCount`, so you only need to set
`replicaCount: 1`; the PodDisruptionBudget is disabled since it is meaningless with one replica.

```yaml
replicaCount: 1
persistence:
  size: 8Gi
resources:
  requests:
    cpu: 250m
    memory: 1Gi
  limits:
    memory: 1Gi
podDisruptionBudget:
  enabled: false
```

## Upgrading

Most value changes roll out as a normal StatefulSet rolling update (highest ordinal first,
waiting for each pod to become `Ready`).

> **Note on listener/security changes:** a change that every controller must adopt *together*
> before the KRaft quorum can re-form — for example enabling TLS or flipping `auth.*` on the
> controller listener — can stall a rolling update: the first updated pod cannot become `Ready`
> until a quorum exists, but the quorum needs the other pods updated too. If `helm upgrade`
> appears stuck with pods not becoming `Ready`, delete the not-yet-updated pods so they restart
> on the new spec simultaneously:
>
> ```bash
> kubectl delete pod -l app.kubernetes.io/instance=my-kafka -n <namespace>
> ```
>
> This only affects such cluster-wide listener changes; fresh installs create all pods in
> parallel and are unaffected.

## Uninstalling the Chart

```bash
helm delete my-kafka
```

> **Note**: PersistentVolumeClaims created by the StatefulSet are **not** removed automatically. Delete them manually if you want to reclaim the storage:
>
> ```bash
> kubectl delete pvc -l app.kubernetes.io/instance=my-kafka
> ```

## License

This chart is licensed under the Apache 2.0 License. See the [LICENSE](LICENSE) file for details.
