<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-redis/redis"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-redis" /></a>
</p>

# Redis Helm Chart

An open source, in-memory data structure store used as a database, cache, and message broker.

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installation

Add the CloudPirates repository:

To install the chart with the release name `my-redis`:

```bash
helm install my-redis oci://registry-1.docker.io/cloudpirates/redis
```

To install with custom values:

```bash
helm install my-redis oci://registry-1.docker.io/cloudpirates/redis -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-redis ./charts/redis
```

### Getting Started

1. Get the Redis password:

```bash
kubectl get secret my-redis -o jsonpath="{.data.redis-password}" | base64 -d
```

2. Connect to Redis from inside the cluster:

```bash
kubectl run redis-client --rm --tty -i --restart='Never' \
    --image redis:8.2.0 -- bash

# Inside the pod:
redis-cli -h my-redis -a $REDIS_PASSWORD
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/redis:<version>
```


## Configuration

### Global parameters

| Parameter                 | Description                           | Default |
| ------------------------- | ------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry override | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names   | `[]`    |

### Image Configuration

| Parameter          | Description            | Default                                                                         |
| ------------------ | ---------------------- | ------------------------------------------------------------------------------- |
| `image.registry`   | Redis image registry   | `docker.io`                                                                     |
| `image.repository` | Redis image repository | `redis`                                                                         |
| `image.tag`        | Redis image tag        | `8.4.0@sha256:43355efd22490e31ca14b9d569367d05121e2be61fd8e47937563ae2a80952ae` |
| `image.pullPolicy` | Image pull policy      | `Always`                                                                        |

### Common Parameters

| Parameter              | Description                                                                                                                                                                             | Default         |
| ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `nameOverride`         | String to partially override redis.fullname                                                                                                                                             | `""`            |
| `fullnameOverride`     | String to fully override redis.fullname                                                                                                                                                 | `""`            |
| `namespaceOverride`    | String to override the namespace for all resources                                                                                                                                      | `""`            |
| `clusterDomain`        | Kubernetes cluster domain                                                                                                                                                               | `cluster.local` |
| `commonLabels`         | Labels to add to all deployed objects                                                                                                                                                   | `{}`            |
| `commonAnnotations`    | Annotations to add to all deployed objects                                                                                                                                              | `{}`            |
| `architecture`         | Redis architecture. `standalone`: Single instance, `cluster`: Multi-master cluster, `replication`: Master-replica (use `sentinel.enabled` to control automatic failover)                | `standalone`    |
| `replicaCount`         | Number of Redis instances (when `architecture=replication\|cluster`). As cluster or replication with Sentinel: total instances. Replication without Sentinel: 1 master + (n-1) replicas | `3`             |
| `clusterReplicaCount`  | Number of replicas to be created for each master when `architecture=cluster`.                                                                                                           | `0`             |
| `revisionHistoryLimit` | Number of revisions to keep in history for rollback (set to 0 for unlimited)                                                                                                            | `10`            |

### Pod labels and annotations

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |


### Service Configuration

| Parameter             | Description                    | Default     |
| --------------------- | ------------------------------ | ----------- |
| `service.annotations` | Kubernetes service annotations | `{}`        |
| `service.type`        | Kubernetes service type        | `ClusterIP` |
| `service.port`        | Redis service port             | `6379`      |
| `service.clusterPort` | Redis cluster service port     | `16379`     |

### Authentication

| Parameter                        | Description                                                  | Default |
| -------------------------------- | ------------------------------------------------------------ | ------- |
| `auth.enabled`                   | Enable Redis authentication                                  | `true`  |
| `auth.sentinel`                  | Enable authentication for Redis sentinels                    | `true`  |
| `auth.password`                  | Redis password (if empty, random password will be generated) | `""`    |
| `auth.existingSecret`            | Name of existing secret containing Redis password            | `""`    |
| `auth.existingSecretPasswordKey` | Key in existing secret containing Redis password             | `""`    |

### Redis Configuration

| Parameter                     | Description                          | Default                |
| ----------------------------- | ------------------------------------ | ---------------------- |
| `config.mountPath`            | Redis configuration mount path       | `/usr/local/etc/redis` |
| `config.content`              | Custom Redis configuration as string | See values.yaml        |
| `config.existingConfigmap`    | Name of existing ConfigMap to use    | `""`                   |
| `config.existingConfigmapKey` | Key in existing ConfigMap            | `""`                   |

### Metrics

| Parameter                                  | Description                                                                             | Default                    |
| ------------------------------------------ | --------------------------------------------------------------------------------------- | -------------------------- |
| `metrics.enabled`                          | Start a sidecar Prometheus exporter to expose Redis metrics                             | `false`                    |
| `metrics.image.registry`                   | Redis exporter image registry                                                           | `docker.io`                |
| `metrics.image.repository`                 | Redis exporter image repository                                                         | `oliver006/redis_exporter` |
| `metrics.image.tag`                        | Redis exporter image tag                                                                | `v1.80.1`                  |
| `metrics.image.pullPolicy`                 | Redis exporter image pull policy                                                        | `Always`                   |
| `metrics.resources.requests.cpu`           | CPU request for the metrics container                                                   | `50m`                      |
| `metrics.resources.requests.memory`        | Memory request for the metrics container                                                | `64Mi`                     |
| `metrics.resources.limits.cpu`             | CPU limit for the metrics container                                                     | `nil`                      |
| `metrics.resources.limits.memory`          | Memory limit for the metrics container                                                  | `64Mi`                     |
| `metrics.extraArgs`                        | Extra arguments for Redis exporter (e.g. `--redis.addr`, `--web.listen-address`)        | `[]`                       |
| `metrics.service.type`                     | Metrics service type                                                                    | `ClusterIP`                |
| `metrics.service.port`                     | Metrics service port                                                                    | `9121`                     |
| `metrics.service.annotations`              | Additional custom annotations for Metrics service                                       | `{}`                       |
| `metrics.service.loadBalancerIP`           | LoadBalancer IP if metrics service type is `LoadBalancer`                               | `""`                       |
| `metrics.service.loadBalancerSourceRanges` | Addresses allowed when metrics service is `LoadBalancer`                                | `[]`                       |
| `metrics.service.clusterIP`                | Static clusterIP or None for headless services when metrics service type is `ClusterIP` | `""`                       |
| `metrics.service.nodePort`                 | NodePort value for LoadBalancer and NodePort service types                              | `""`                       |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource(s) for scraping metrics using Prometheus Operator        | `false`                    |
| `metrics.serviceMonitor.namespace`         | Namespace in which to create ServiceMonitor resource(s)                                 | `""`                       |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped                                             | `30s`                      |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                 | `""`                       |
| `metrics.serviceMonitor.relabelings`       | Additional relabeling of metrics                                                        | `[]`                       |
| `metrics.serviceMonitor.metricRelabelings` | Additional metric relabeling of metrics                                                 | `[]`                       |
| `metrics.serviceMonitor.honorLabels`       | Honor metrics labels                                                                    | `false`                    |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                     | `{}`                       |
| `metrics.serviceMonitor.annotations`       | Additional custom annotations for the ServiceMonitor                                    | `{}`                       |
| `metrics.serviceMonitor.namespaceSelector` | Namespace selector for ServiceMonitor                                                   | `{}`                       |

### Pod Disruption Budget

| Parameter            | Description                                                    | Default |
| -------------------- | -------------------------------------------------------------- | ------- |
| `pdb.enabled`        | Enable Pod Disruption Budget                                   | `false` |
| `pdb.minAvailable`   | Minimum number/percentage of pods that should remain scheduled | `1`     |
| `pdb.maxUnavailable` | Maximum number/percentage of pods that may be made unavailable | `""`    |

### Persistence

| Parameter                   | Description                                        | Default         |
| --------------------------- | -------------------------------------------------- | --------------- |
| `persistence.enabled`       | Enable persistent storage                          | `true`          |
| `persistence.storageClass`  | Storage class for persistent volume                | `""`            |
| `persistence.accessMode`    | Access mode for persistent volume                  | `ReadWriteOnce` |
| `persistence.size`          | Size of persistent volume                          | `8Gi`           |
| `persistence.mountPath`     | Mount path for Redis data                          | `/data`         |
| `persistence.annotations`   | Annotations for persistent volume claims           | `{}`            |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`            |
| `persistence.subPath`       | The subdirectory of the volume to mount to         | `""`            |

### Persistent Volume Claim Retention Policy

| Parameter                                          | Description                                                                    | Default    |
| -------------------------------------------------- | ------------------------------------------------------------------------------ | ---------- |
| `persistentVolumeClaimRetentionPolicy.enabled`     | Enable Persistent volume retention policy for the StatefulSet                  | `false`    |
| `persistentVolumeClaimRetentionPolicy.whenDeleted` | Volume retention behavior that applies when the StatefulSet is deleted         | `"Retain"` |
| `persistentVolumeClaimRetentionPolicy.whenScaled`  | Volume retention behavior when the replica count of the StatefulSet is reduced | `"Retain"` |

### Resource Management

| Parameter                   | Description    | Default |
| --------------------------- | -------------- | ------- |
| `resources.limits.memory`   | Memory limit   | `256Mi` |
| `resources.requests.cpu`    | CPU request    | `50m`   |
| `resources.requests.memory` | Memory request | `128Mi` |

### Pod Assignment / Eviction

| Parameter                   | Description                                    | Default |
| --------------------------- | ---------------------------------------------- | ------- |
| `nodeSelector`              | Node selector for pod assignment               | `{}`    |
| `priorityClassName`         | Priority class for pod eviction                | `""`    |
| `tolerations`               | Tolerations for pod assignment                 | `[]`    |
| `affinity`                  | Affinity rules for pod assignment              | `{}`    |
| `topologySpreadConstraints` | Topology spread constraints for pod assignment | `[]`    |

### Security Context

| Parameter                                           | Description                       | Default          |
| --------------------------------------------------- | --------------------------------- | ---------------- |
| `containerSecurityContext.runAsUser`                | User ID to run the container      | `999`            |
| `containerSecurityContext.runAsGroup`               | Group ID to run the container     | `999`            |
| `containerSecurityContext.runAsNonRoot`             | Run as non-root user              | `true`           |
| `containerSecurityContext.privileged`               | Set container's privileged mode   | `false`          |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation        | `false`          |
| `containerSecurityContext.readOnlyRootFilesystem`   | Read-only root filesystem         | `true`           |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped  | `["ALL"]`        |
| `containerSecurityContext.seccompProfile.type`      | Seccomp profile for the container | `RuntimeDefault` |
| `podSecurityContext.fsGroup`                        | Pod's Security Context fsGroup    | `999`            |

### Health Checks

#### Liveness Probe

| Parameter                           | Description                                     | Default |
| ----------------------------------- | ----------------------------------------------- | ------- |
| `livenessProbe.enabled`             | Enable liveness probe                           | `true`  |
| `livenessProbe.initialDelaySeconds` | Initial delay before starting probes            | `30`    |
| `livenessProbe.periodSeconds`       | How often to perform the probe                  | `10`    |
| `livenessProbe.timeoutSeconds`      | Timeout for each probe attempt                  | `5`     |
| `livenessProbe.failureThreshold`    | Number of failures before pod is restarted      | `6`     |
| `livenessProbe.successThreshold`    | Number of successes to mark probe as successful | `1`     |

#### Readiness Probe

| Parameter                            | Description                                     | Default |
| ------------------------------------ | ----------------------------------------------- | ------- |
| `readinessProbe.enabled`             | Enable readiness probe                          | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay before starting probes            | `5`     |
| `readinessProbe.periodSeconds`       | How often to perform the probe                  | `10`    |
| `readinessProbe.timeoutSeconds`      | Timeout for each probe attempt                  | `5`     |
| `readinessProbe.failureThreshold`    | Number of failures before pod is marked unready | `6`     |
| `readinessProbe.successThreshold`    | Number of successes to mark probe as successful | `1`     |

### Redis Sentinel Configuration (High Availability)

Redis Sentinel provides high availability for Redis through automatic failover. When enabled in `replication` mode, Sentinel monitors the master and replicas, and promotes a replica to master if the current master becomes unavailable. When disabled with `replication` mode, pod-0 is always the master.

| Parameter                                     | Description                                                                                   | Default     |
|-----------------------------------------------|-----------------------------------------------------------------------------------------------|-------------|
| `sentinel.enabled`                            | Enable Redis Sentinel for high availability. When disabled, pod-0 is master (manual failover) | `false`     |
| `sentinel.image.repository`                   | Redis Sentinel image repository                                                               | `redis`     |
| `sentinel.image.tag`                          | Redis Sentinel image tag                                                                      | `8.4.0`     |
| `sentinel.image.pullPolicy`                   | Sentinel image pull policy                                                                    | `Always`    |
| `sentinel.config.announceHostnames`           | Use the hostnames instead of the IP in "announce-ip" commands                                 | `true`      |
| `sentinel.masterName`                         | Name of the master server                                                                     | `mymaster`  |
| `sentinel.quorum`                             | Number of Sentinels needed to agree on master failure                                         | `2`         |
| `sentinel.downAfterMilliseconds`              | Time in ms after master is declared down                                                      | `30000`     |
| `sentinel.failoverTimeout`                    | Timeout for failover in ms                                                                    | `180000`    |
| `sentinel.parallelSyncs`                      | Number of replicas to reconfigure during failover                                             | `1`         |
| `sentinel.loglevel`                           | Sentinel log level (debug, verbose, notice, warning). When 'debug', full config is logged     | `notice`    |
| `sentinel.port`                               | Sentinel port                                                                                 | `26379`     |
| `sentinel.service.type`                       | Kubernetes service type for Sentinel                                                          | `ClusterIP` |
| `sentinel.service.port`                       | Sentinel service port                                                                         | `26379`     |
| `sentinel.resources.limits.memory`            | Memory limit for Sentinel pods                                                                | `128Mi`     |
| `sentinel.resources.requests.cpu`             | CPU request for Sentinel pods                                                                 | `25m`       |
| `sentinel.resources.requests.memory`          | Memory request for Sentinel pods                                                              | `64Mi`      |
| `sentinel.extraVolumeMounts`                  | Additional volume mounts for Sentinel container                                               | `[]`        |
| `sentinel.livenessProbe.enabled`              | Enable liveness probe                                                                         | `true`      |
| `sentinel.livenessProbe.initialDelaySeconds`  | Initial delay before starting probes                                                          | `30`        |
| `sentinel.livenessProbe.periodSeconds`        | How often to perform the probe                                                                | `10`        |
| `sentinel.livenessProbe.timeoutSeconds`       | Timeout for each probe attempt                                                                | `5`         |
| `sentinel.livenessProbe.failureThreshold`     | Number of failures before pod is restarted                                                    | `6`         |
| `sentinel.livenessProbe.successThreshold`     | Number of successes to mark probe as successful                                               | `1`         |
| `sentinel.readinessProbe.enabled`             | Enable readiness probe                                                                        | `true`      |
| `sentinel.readinessProbe.initialDelaySeconds` | Initial delay before starting probes                                                          | `5`         |
| `sentinel.readinessProbe.periodSeconds`       | How often to perform the probe                                                                | `10`        |
| `sentinel.readinessProbe.timeoutSeconds`      | Timeout for each probe attempt                                                                | `5`         |
| `sentinel.readinessProbe.failureThreshold`    | Number of failures before pod is marked unready                                               | `6`         |
| `sentinel.readinessProbe.successThreshold`    | Number of successes to mark probe as successful                                               | `1`         |

### ServiceAccount

| Parameter                                     | Description                                                                                                                             | Default |
| --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.annotations`                  | Additional custom annotations for the ServiceAccount                                                                                    | `{}`    |
| `serviceAccount.automountServiceAccountToken` | Automount service account token inside the Redis pods                                                                                   | `false` |
| `serviceAccount.create`                       | Enable the creation of a ServiceAccount                                                                                                 | `false` |
| `serviceAccount.name`                         | Name of the ServiceAccount to use. If not set and `serviceAccount.create` is `true`, a name is generated using the `fullname` template. | `""`    |

### Additional Configuration

| Parameter           | Description                                                             | Default |
| ------------------- | ----------------------------------------------------------------------- | ------- |
| `extraEnvVars`      | Additional environment variables to set                                 | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod                                    | `[]`    |
| `extraVolumeMounts` | Additional volume mounts for Redis container                            | `[]`    |
| `extraObjects`      | A list of additional Kubernetes objects to deploy alongside the release | `[]`    |
| `extraPorts`        | Additional ports to be exposed by Services and StatefulSet              | `[]`    |

### Configurations for the Job-Template

| Parameter                                  | Description                                      | Default |
| ------------------------------------------ | ------------------------------------------------ | ------- |
| `clusterInitJob.resources`                 | Resource limits and requests for clusterInit Job | `{}`    |
| `clusterInitJob.resources.limits.memory`   | Memory limit for clusterInit Job                 | `128Mi` |
| `clusterInitJob.resources.requests.cpu`    | CPU request for clusterInit Job                  | `10m`   |
| `clusterInitJob.resources.requests.memory` | Memory request for clusterInit Job               | `64Mi`  |


#### Extra Objects

You can use the `extraObjects` array to deploy additional Kubernetes resources (such as NetworkPolicies, ConfigMaps, etc.) alongside the release. This is useful for customizing your deployment with extra manifests that are not covered by the default chart options.

**Helm templating is supported in any field, but all template expressions must be quoted.** For example, to use the release namespace, write `namespace: "{{ .Release.Namespace }}"`.

**Example: Deploy a NetworkPolicy with templating**

```yaml
extraObjects:
  - apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-dns
      namespace: "{{ .Release.Namespace }}"
    spec:
      podSelector: {}
      policyTypes:
        - Egress
      egress:
        - to:
            - namespaceSelector:
                matchLabels:
                  kubernetes.io/metadata.name: kube-system
              podSelector:
                matchLabels:
                  k8s-app: kube-dns
        - ports:
            - port: 53
              protocol: UDP
            - port: 53
              protocol: TCP
```

All objects in `extraObjects` will be rendered and deployed with the release. You can use any valid Kubernetes manifest, and reference Helm values or built-in objects as needed (just remember to quote template expressions).

## Examples

### Basic Deployment

```bash
helm install my-redis ./charts/redis
```

### Using Existing Secret for Authentication

```yaml
# values-external-secret.yaml
auth:
  enabled: true
  existingSecret: "redis-credentials"
  existingSecretPasswordKey: "password"
```

### High Availability with Redis Sentinel

Deploy Redis with master-replica architecture and Sentinel for automatic failover:

```yaml
# values-ha.yaml
architecture: replication
replicaCount: 2

sentinel:
  enabled: true
  quorum: 2
  downAfterMilliseconds: 30000
  failoverTimeout: 180000

auth:
  enabled: true
```

```bash
helm install my-redis ./charts/redis -f values-ha.yaml
```

After deployment, you'll have:

- 1 Redis master instance
- 2 Redis replica instances
- 3 Redis Sentinel instances (for monitoring and failover)

**Connecting to Redis with Sentinel:**

```bash
# Get the Redis password
REDIS_PASSWORD=$(kubectl get secret my-redis -o jsonpath="{.data.redis-password}" | base64 -d)

# Connect to Sentinel to discover the current master
kubectl run redis-client --rm --tty -i --restart='Never' \
    --image redis:8.2.1 -- bash

# Inside the pod:
redis-cli -h my-redis-sentinel -p 26379 sentinel get-master-addr-by-name mymaster

# Connect to the current master (address from previous command)
redis-cli -h <master-ip> -p 6379 -a $REDIS_PASSWORD
```

### Master-Replica without Sentinel

Deploy Redis with replication but without Sentinel for scenarios where automatic failover is not needed:

```yaml
architecture: replication
replicaCount: 3  # 1 master + 2 replicas
sentinel:
  enabled: false

auth:
  enabled: true
```

After deployment, you'll have:

- 1 Redis master instance (pod-0, always the master)
- 2 Redis replica instances (pod-1, pod-2)
- No automatic failover (manual intervention required if master fails)

**Key differences from Sentinel mode:**

- Pod-0 is always the master, other pods are always replicas
- No automatic failover - if the master fails, manual intervention is required
- Simpler setup with fewer components
- Lower resource usage (no Sentinel containers)


### Cluster mode

Deploy Redis Cluster with 6 nodes - 3 master and 3 replicas for automated failover:

```yaml
# values-cluster.yaml
architecture: cluster
replicaCount: 6
clusterReplicaCount: 1
```

```bash
helm install my-redis ./charts/redis -f values-cluster.yaml
```

**Key differences with replication**

- Redis Cluster supports single database only
- Data is automatically divided across multiple nodes for improved performance
- With cluster-aware client, user can connect to any node (directly or via service) and requests will be automatically redirected, based on MOVED response

## Upgrading

To upgrade your Redis installation:

```bash
helm upgrade my-redis cloudpirates/redis
```

## Uninstalling

To uninstall/delete the Redis deployment:

```bash
helm delete my-redis
```

## Getting Support

For issues related to this Helm chart, please check:

- [Redis Documentation](https://redis.io/docs/latest/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
