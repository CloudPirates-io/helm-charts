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
| `command`                            | Override default container command                                                       | `[]`                         |

### Kafka Configuration

| Parameter                                          | Description                                                       | Default |
| -------------------------------------------------- | ----------------------------------------------------------------- | ------- |
| `kafkaConfig.numPartitions`                        | Default number of log partitions per topic                        | `3`     |
| `kafkaConfig.defaultReplicationFactor`             | Default replication factor for automatically created topics       | `3`     |
| `kafkaConfig.offsetsTopicReplicationFactor`        | Replication factor for the offsets topic                          | `3`     |
| `kafkaConfig.transactionStateLogReplicationFactor` | Replication factor for the transaction state log topic            | `3`     |
| `kafkaConfig.transactionStateLogMinIsr`            | Minimum in-sync replicas for the transaction state log topic      | `2`     |
| `kafkaConfig.autoCreateTopicsEnable`               | Enable auto creation of topics on the server                      | `true`  |
| `kafkaConfig.logRetentionHours`                    | Number of hours to keep a log file before deleting it             | `168`   |
| `kafkaConfig.extraConfig`                          | Extra Kafka configuration lines appended to `server.properties`   | `[]`    |

### Service

| Parameter                       | Description                  | Default     |
| ------------------------------- | ---------------------------- | ----------- |
| `service.type`                  | Kubernetes service type      | `ClusterIP` |
| `service.ports.client`          | Kafka client (broker) port   | `9092`      |
| `service.ports.controller`      | Kafka controller (KRaft) port | `9093`     |
| `service.annotations`           | Additional service annotations | `{}`      |

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

## Example: production-like values

```yaml
replicaCount: 3
clusterId: "M2tjWlpQVFJUR2ktZ0t3UQ"   # generate with: kafka-storage.sh random-uuid
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
  defaultReplicationFactor: 3
  minInsyncReplicas: 2
  extraConfig:
    - "min.insync.replicas=2"
```

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
