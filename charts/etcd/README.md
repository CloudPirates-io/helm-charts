<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-etcd/etcd"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-etcd" /></a>
</p>

# etcd Helm Chart

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being simple, secure, fast, and reliable.

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installation

To install the chart with the release name `my-etcd`:

```bash
helm install my-etcd oci://registry-1.docker.io/cloudpirates/etcd
```

To install with custom values:

```bash
helm install my-etcd oci://registry-1.docker.io/cloudpirates/etcd -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-etcd ./charts/etcd
```

### Uninstalling

To uninstall/delete the `my-etcd` deployment:

```bash
helm delete my-etcd
```

### Getting Started

1. Check the status of your etcd cluster:

```bash
kubectl exec -it my-etcd-0 -- etcdctl \
  --endpoints=my-etcd:2379 \
  endpoint health
```

2. Connect to etcd from inside the cluster:

```bash
kubectl run etcd-client --rm --tty -i --restart='Never' \
    --image gcr.io/etcd-development/etcd:v3.6.0-alpha.0 -- bash

# Inside the pod:
etcdctl --endpoints=my-etcd:2379 endpoint status --write-out=table
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/etcd:<version>
```

## Configuration

### Global Parameters
| Parameter                 | Description                           | Default                 |
| ------------------------- | ------------------------------------- | ----------------------- |
| `global.imageRegistry`    | Global Docker image registry override | `""`                    |
| `global.imagePullSecrets` | Global Docker registry secret names   | `[]`                    |

### Image Configuration

| Parameter                 | Description                           | Default                 |
| ------------------------- | ------------------------------------- | ----------------------- |
| `image.registry`          | etcd image registry                   | `gcr.io`                |
| `image.repository`        | etcd image repository                 | `etcd-development/etcd` |
| `image.tag`               | etcd image tag                        | `v3.6.5@sha256:3397341272b9e0a6f44d7e3fc7c321c6efe6cbe82ce866b9b01d0c704bfc5bf3`        |
| `image.pullPolicy`        | Image pull policy                     | `IfNotPresent`          |

### Common Parameters

| Parameter           | Description                                     | Default |
| ------------------- | ----------------------------------------------- | ------- |
| `nameOverride`      | String to partially override etcd.fullname      | `""`    |
| `fullnameOverride`  | String to fully override etcd.fullname          | `""`    |
| `commonLabels`      | Labels to add to all deployed objects           | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects      | `{}`    |
| `replicaCount`      | Number of etcd replicas to deploy (must be odd) | `3`     |
| `podLabels`         | Additional labels for etcd pods                 | `{}`    |
| `podAnnotations`    | Additional annotations for etcd pods            | `{}`    |

### Service Configuration

| Parameter             | Description             | Default     |
| --------------------- | ----------------------- | ----------- |
| `service.type`        | Kubernetes service type | `ClusterIP` |
| `service.annotations` | Service annotations     | `{}`        |
| `service.clientPort`  | etcd client port        | `2379`      |
| `service.peerPort`    | etcd peer port          | `2380`      |
| `service.metricsPort` | etcd metrics port       | `2381`      |

### Authentication and Security

| Parameter                  | Description                                            | Default |
| -------------------------- | ------------------------------------------------------ | ------- |
| `auth.enabled`             | Enable client-to-server TLS authentication             | `false` |
| `auth.existingSecret`      | Name of existing secret containing client certificates | `""`    |
| `auth.peer.enabled`        | Enable peer-to-peer TLS authentication                 | `false` |
| `auth.peer.existingSecret` | Name of existing secret containing peer certificates   | `""`    |

### etcd Configuration

| Parameter                        | Description                                        | Default        |
| -------------------------------- | -------------------------------------------------- | -------------- |
| `config.initialClusterState`     | Initial cluster state (new or existing)            | `new`          |
| `config.autoCompactionMode`      | Auto compaction mode (periodic or revision)        | `periodic`     |
| `config.autoCompactionRetention` | Auto compaction retention                          | `1`            |
| `config.snapshotCount`           | Number of transactions to trigger a snapshot       | `10000`        |
| `config.quotaBackendBytes`       | Backend storage quota in bytes (2GB)               | `2147483648`   |
| `config.maxRequestBytes`         | Maximum client request size in bytes               | `1572864`      |
| `config.logLevel`                | Log level (debug, info, warn, error, panic, fatal) | `info`         |
| `config.initialClusterToken`     | Initial cluster token                              | `etcd-cluster` |
| `config.heartbeatInterval`       | Heartbeat interval in milliseconds                 | `100`          |
| `config.electionTimeout`         | Election timeout in milliseconds                   | `1000`         |
| `config.maxSnapshots`            | Maximum number of snapshot files to retain         | `5`            |
| `config.maxWals`                 | Maximum number of WAL files to retain              | `5`            |
| `config.listenPeerIp`            | IP address to bind for peer traffic                | `0.0.0.0`      |
| `config.listenClientIp`          | IP address to bind for client traffic              | `0.0.0.0`      |

### Persistence

| Parameter                  | Description                    | Default           |
| -------------------------- | ------------------------------ | ----------------- |
| `persistence.enabled`      | Enable persistence using PVC   | `true`            |
| `persistence.storageClass` | Storage class of backing PVC   | `""`              |
| `persistence.annotations`  | Annotations for the PVC        | `{}`              |
| `persistence.size`         | Size of data volume            | `8Gi`             |
| `persistence.accessModes`  | Persistent Volume Access Modes | `[ReadWriteOnce]` |
| `persistence.mountPath`    | Mount path for data volume     | `/var/run/etcd`   |

### Resources

| Parameter   | Description                         | Default |
| ----------- | ----------------------------------- | ------- |
| `resources` | CPU/Memory resource requests/limits | `{}`    |

### StatefulSet Configuration

| Parameter             | Description                 | Default         |
| --------------------- | --------------------------- | --------------- |
| `updateStrategy.type` | StatefulSet update strategy | `RollingUpdate` |

### Metrics Configuration

| Parameter                                  | Description                                   | Default |
| ------------------------------------------ | --------------------------------------------- | ------- |
| `metrics.enabled`                          | Enable Prometheus metrics                     | `true`  |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor for Prometheus Operator | `false` |
| `metrics.serviceMonitor.namespace`         | Namespace for ServiceMonitor                  | `""`    |
| `metrics.serviceMonitor.interval`          | Scrape interval                               | `30s`   |
| `metrics.serviceMonitor.scrapeTimeout`     | Scrape timeout                                | `""`    |
| `metrics.serviceMonitor.relabelings`       | Relabel configurations                        | `[]`    |
| `metrics.serviceMonitor.metricRelabelings` | Metric relabel configurations                 | `[]`    |
| `metrics.serviceMonitor.labels`            | Additional labels for ServiceMonitor          | `{}`    |
| `metrics.serviceMonitor.honorLabels`       | Honor labels from metrics                     | `false` |

### High Availability

| Parameter                            | Description                        | Default |
| ------------------------------------ | ---------------------------------- | ------- |
| `podDisruptionBudget.enabled`        | Enable PodDisruptionBudget         | `false` |
| `podDisruptionBudget.minAvailable`   | Minimum number of available pods   | `""`    |
| `podDisruptionBudget.maxUnavailable` | Maximum number of unavailable pods | `1`     |

### Service Account

| Parameter                                     | Description                     | Default |
| --------------------------------------------- | ------------------------------- | ------- |
| `serviceAccount.create`                       | Create service account          | `true`  |
| `serviceAccount.name`                         | Service account name            | `""`    |
| `serviceAccount.annotations`                  | Service account annotations     | `{}`    |
| `serviceAccount.automountServiceAccountToken` | Automount service account token | `false` |

### Network Policy

| Parameter                     | Description              | Default |
| ----------------------------- | ------------------------ | ------- |
| `networkPolicy.enabled`       | Enable NetworkPolicy     | `false` |
| `networkPolicy.allowExternal` | Allow external traffic   | `true`  |
| `networkPolicy.extraIngress`  | Additional ingress rules | `[]`    |
| `networkPolicy.extraEgress`   | Additional egress rules  | `[]`    |

### Security Context

| Parameter                                           | Description                        | Default |
| --------------------------------------------------- | ---------------------------------- | ------- |
| `containerSecurityContext.runAsUser`                | User ID to run the container       | `1000`  |
| `containerSecurityContext.runAsGroup`               | Group ID to run the container      | `1000`  |
| `containerSecurityContext.runAsNonRoot`             | Run as non-root user               | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation         | `false` |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount root filesystem as read-only | `true`  |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to drop         | `[ALL]` |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes           | `1000`  |

### Probes

| Parameter                            | Description                           | Default |
| ------------------------------------ | ------------------------------------- | ------- |
| `startupProbe.enabled`               | Enable startup probe                  | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay for startup probe       | `0`     |
| `startupProbe.periodSeconds`         | Period for startup probe              | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout for startup probe             | `5`     |
| `startupProbe.failureThreshold`      | Failure threshold for startup probe   | `30`    |
| `livenessProbe.enabled`              | Enable liveness probe                 | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay for liveness probe      | `10`    |
| `livenessProbe.periodSeconds`        | Period for liveness probe             | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout for liveness probe            | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for liveness probe  | `3`     |
| `readinessProbe.enabled`             | Enable readiness probe                | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay for readiness probe     | `5`     |
| `readinessProbe.periodSeconds`       | Period for readiness probe            | `10`    |
| `readinessProbe.timeoutSeconds`      | Timeout for readiness probe           | `5`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readiness probe | `3`     |

### Scheduling

| Parameter                   | Description                          | Default |
| --------------------------- | ------------------------------------ | ------- |
| `nodeSelector`              | Node labels for pod assignment       | `{}`    |
| `tolerations`               | Tolerations for pod assignment       | `[]`    |
| `affinity`                  | Affinity rules for pod assignment    | `{}`    |
| `topologySpreadConstraints` | Topology Spread Constraints          | `[]`    |
| `priorityClassName`         | Priority class name for pod eviction | `""`    |

### Extra Configuration

| Parameter           | Description                                       | Default |
| ------------------- | ------------------------------------------------- | ------- |
| `extraArgs`         | Additional etcd command line arguments            | `[]`    |
| `extraEnvVars`      | Additional environment variables                  | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod              | `[]`    |
| `extraVolumeMounts` | Additional volume mounts for etcd container       | `[]`    |
| `extraObjects`      | Array of extra objects to deploy with the release | `[]`    |

## Upgrading

To upgrade your release:

```bash
helm upgrade my-etcd oci://registry-1.docker.io/cloudpirates/etcd
```

## Troubleshooting

### Getting Support

For issues related to this Helm chart, please check:

- [Etcd Documentation](https://etcd.io/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
