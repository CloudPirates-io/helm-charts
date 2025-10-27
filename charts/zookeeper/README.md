# Zookeeper Helm Chart

Apache ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

## Quick Start

### Prerequisites
- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installation

To install the chart with the release name `my-zookeeper`:

```bash
helm install my-zookeeper ./charts/zookeeper
```

To install with custom values:

```bash
helm install my-zookeeper ./charts/zookeeper -f values.yaml
```

## Security & Signature Verification

This Helm chart is cryptographically signed with Cosign to ensure authenticity and prevent tampering.

**Public Key:**

```
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE7BgqFgKdPtHdXz6OfYBklYwJgGWQ
mZzYz8qJ9r6QhF3NxK8rD2oG7Bk6nHJz7qWXhQoU2JvJdI3Zx9HGpLfKvw==
-----END PUBLIC KEY-----
```

To verify the helm chart before installation, copy the public key to the file `cosign.pub` and run cosign:

```bash
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/zookeeper:<version>
```

### Getting Started

1. Connect to ZooKeeper from inside the cluster:

```bash
kubectl run zk-client --rm --tty -i --restart='Never' \
    --image zookeeper:latest -- bash

# Inside the pod:
zkCli.sh -server my-zookeeper:2181
```

## Configuration


### Image Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.registry` | ZooKeeper image registry | `docker.io` |
| `image.repository` | ZooKeeper image repository | `zookeeper` |
| `image.tag` | ZooKeeper image tag | `3.9.3@sha256:9980cafbff742c15b339811ae829faa61c69154606ec504223560da9d31acd43` |
| `image.imagePullPolicy` | ZooKeeper image pull policy | `Always` |
| `global.imageRegistry` | Global Docker image registry | `""` |
| `global.imagePullSecrets` | Global Docker registry secret names (array) | `[]` |

### Common Parameters

| Parameter                   | Description                                                                 | Default |
|-----------------------------|-----------------------------------------------------------------------------|---------|
| `nameOverride`              | String to partially override fullname                                       | `""`    |
| `fullnameOverride`          | String to fully override fullname                                           | `""`    |
| `commonLabels`              | Labels to add to all deployed objects                                       | `{}`    |
| `commonAnnotations`         | Annotations to add to all deployed objects                                  | `{}`    |
| `replicaCount`              | Number of ZooKeeper replicas to deploy                                      | `3`     |
| `podDisruptionBudget.enabled` | Create a Pod Disruption Budget to ensure high availability during voluntary disruptions | `true`  |
| `networkPolicy.enabled`     | Enable network policies                                                     | `true`  |

### ZooKeeper Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `zookeeperConfig.tickTime` | ZooKeeper tick time | `2000` |
| `zookeeperConfig.initLimit` | ZooKeeper init limit | `10` |
| `zookeeperConfig.syncLimit` | ZooKeeper sync limit | `5` |
| `zookeeperConfig.electionPortBindRetry` | ZooKeeper election port bind retry | `10` |
| `zookeeperConfig.maxClientCnxns` | ZooKeeper max client connections | `60` |
| `zookeeperConfig.standaloneEnabled` | Enable standalone mode | `"false"` |
| `zookeeperConfig.adminServerEnabled` | Enable admin server | `"false"` |
| `zookeeperConfig.commandsWhitelist` | 4-letter word commands whitelist | `srvr` |
| `zookeeperConfig.autopurge.purgeInterval` | Autopurge purge interval (hours) | `24` |
| `zookeeperConfig.autopurge.snapRetainCount` | Autopurge snapshot retain count | `3` |
| `zookeeperConfig.admin.enableServer` | Enable the admin server | `"false"` |
| `zookeeperConfig.admin.serverPort` | Admin server port | `8080` |
| `zookeeperConfig.admin.serverAddress` | Admin server address | `0.0.0.0` |
| `zookeeperConfig.admin.idleTimeout` | Admin server connection idle timeout (milliseconds) | `30000` |
| `zookeeperConfig.admin.commandUrl` | Admin server command URL | `/commands` |

### Metrics

| Parameter | Description | Default |
|-----------|-------------|---------|
| `metrics.enabled` | Enable Prometheus metrics exporter | `true` |
| `metrics.service.type` | Metrics service type | `ClusterIP` |
| `metrics.service.ports.port` | Metrics service port | `7000` |

### Service Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.ports.client` | ZooKeeper client service port | `2181` |
| `service.ports.quorum` | ZooKeeper quorum service port | `2888` |
| `service.ports.leaderElection` | ZooKeeper leader election service port | `3888` |
| `service.ports.admin` | ZooKeeper admin service port | `8080` |
| `service.annotations` | Additional annotations to add to the service | `{}` |

### Persistence

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistence using PVC | `true` |
| `persistence.storageClass` | Persistent Volume storage class | `""` |
| `persistence.annotations` | Persistent Volume Claim annotations | `{}` |
| `persistence.size` | Persistent Volume size | `8Gi` |
| `persistence.accessModes` | Persistent Volume access modes | `[ReadWriteOnce]` |
| `persistence.existingClaim` | Name of existing PVC to use | `""` |
| `persistence.mountPath` | Path to mount the data volume | `/var/lib/zookeeper/data` |

### Resource Management

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources` | Resource requests/limits | `{}` (user-defined) |

### Pod Assignment / Eviction

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nodeSelector` | Node selector for pod assignment | `{}` |
| `priorityClassName` | Priority class name for pod eviction | `""` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `affinity` | Affinity rules for pod assignment | `{}` |

### Security Context

| Parameter                                 | Description                                               | Default |
|-------------------------------------------|-----------------------------------------------------------|---------|
| `containerSecurityContext.runAsUser`      | User ID to run the container process                      | `1000`  |
| `containerSecurityContext.runAsGroup`     | Group ID to run the container process                     | `1000`  |
| `containerSecurityContext.seLinuxOptions` | SELinux options for the container                         | `{}`    |
| `containerSecurityContext.runAsNonRoot`   | Require the container to run as a non-root user           | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Whether to allow privilege escalation for the container | `false` |
| `containerSecurityContext.privileged`     | Set container's privileged mode                           | `false` |
| `containerSecurityContext.readOnlyRootFilesystem` | Mount container root filesystem as read-only           | `false` |
| `containerSecurityContext.capabilities`   | Linux capabilities to drop or add for the container        | `{}`    |
| `containerSecurityContext.seccompProfile` | Seccomp profile for the container                         | `{}`    |
| `podSecurityContext.fsGroup`              | Group ID for the volumes of the pod                        | `1000`  |


### Health Checks

#### Liveness Probe

| Parameter | Description | Default |
|-----------|-------------|---------|
| `livenessProbe.enabled` | Enable livenessProbe | `true` |
| `livenessProbe.initialDelaySeconds` | LivenessProbe initial delay | `30` |
| `livenessProbe.periodSeconds` | LivenessProbe period seconds | `10` |
| `livenessProbe.timeoutSeconds` | LivenessProbe timeout seconds | `5` |
| `livenessProbe.failureThreshold` | LivenessProbe failure threshold | `6` |
| `livenessProbe.successThreshold` | LivenessProbe success threshold | `1` |

#### Readiness Probe

| Parameter | Description | Default |
|-----------|-------------|---------|
| `readinessProbe.enabled` | Enable readinessProbe | `true` |
| `readinessProbe.initialDelaySeconds` | ReadinessProbe initial delay | `5` |
| `readinessProbe.periodSeconds` | ReadinessProbe period seconds | `10` |
| `readinessProbe.timeoutSeconds` | ReadinessProbe timeout seconds | `5` |
| `readinessProbe.failureThreshold` | ReadinessProbe failure threshold | `6` |
| `readinessProbe.successThreshold` | ReadinessProbe success threshold | `1` |

#### Startup Probe

| Parameter | Description | Default |
|-----------|-------------|---------|
| `startupProbe.enabled` | Enable startupProbe | `false` |
| `startupProbe.initialDelaySeconds` | StartupProbe initial delay | `10` |
| `startupProbe.periodSeconds` | StartupProbe period seconds | `10` |
| `startupProbe.timeoutSeconds` | StartupProbe timeout seconds | `5` |
| `startupProbe.failureThreshold` | StartupProbe failure threshold | `30` |
| `startupProbe.successThreshold` | StartupProbe success threshold | `1` |

### Additional Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `extraEnv` | Additional environment variables | `[]` |
| `extraVolumes` | Additional volumes to add to the pod | `[]` |
| `extraVolumeMounts` | Additional volume mounts | `[]` |
| `extraObjects` | Array of extra objects to deploy | `[]` |

See [values.yaml](./values.yaml) for the full list of configurable parameters.

## Upgrading

To upgrade your ZooKeeper installation:

```bash
helm upgrade my-zookeeper ./charts/zookeeper
```

## Uninstalling

To uninstall/delete the ZooKeeper deployment:

```bash
helm delete my-zookeeper
```

## References
- [ZooKeeper Documentation](https://zookeeper.apache.org/doc/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
