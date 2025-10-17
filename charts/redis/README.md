<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-redis"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-redis" /></a>
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

## Configuration

### Image Configuration

| Parameter                 | Description                           | Default                                                                         |
| ------------------------- | ------------------------------------- | ------------------------------------------------------------------------------- |
| `image.registry`          | Redis image registry                  | `docker.io`                                                                     |
| `image.repository`        | Redis image repository                | `redis`                                                                         |
| `image.tag`               | Redis image tag                       | `8.2.0@sha256:e7d6b261beaa22b1dc001f438b677f1c691ac7805607d8979bae65fe0615c2e6` |
| `image.pullPolicy`        | Image pull policy                     | `Always`                                                                        |
| `global.imageRegistry`    | Global Docker image registry override | `""`                                                                            |
| `global.imagePullSecrets` | Global Docker registry secret names   | `[]`                                                                            |

### Common Parameters

| Parameter           | Description                                                             | Default      |
|---------------------| ----------------------------------------------------------------------- | ------------ |
| `nameOverride`      | String to partially override redis.fullname                             | `""`         |
| `fullnameOverride`  | String to fully override redis.fullname                                 | `""`         |
| `namespaceOverride` | String to override the namespace for all resources                      | `""`         |
| `commonLabels`      | Labels to add to all deployed objects                                   | `{}`         |
| `commonAnnotations` | Annotations to add to all deployed objects                              | `{}`         |
| `architecture`      | Redis architecture. Allowed values: `standalone` or `replication`       | `standalone` |
| `replicaCount`      | Number of Redis replicas to deploy (only when architecture=replication) | `2`          |

### Pod labels and annotations

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |


### Service Configuration

| Parameter      | Description             | Default     |
| -------------- | ----------------------- | ----------- |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Redis service port      | `6379`      |

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

| Parameter                                  | Description                                                                             | Default                                                                           |
| ------------------------------------------ | --------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `metrics.enabled`                          | Start a sidecar Prometheus exporter to expose Redis metrics                             | `false`                                                                           |
| `metrics.image.registry`                   | Redis exporter image registry                                                           | `docker.io`                                                                       |
| `metrics.image.repository`                 | Redis exporter image repository                                                         | `oliver006/redis_exporter`                                                        |
| `metrics.image.tag`                        | Redis exporter image tag                                                                | `v1.58.0@sha256:2e42c98f2c53aaf3ce205e746ff8bfa25d39e30d8b4f401ce0ad2740836bb817` |
| `metrics.image.pullPolicy`                 | Redis exporter image pull policy                                                        | `Always`                                                                          |
| `metrics.resources.requests.cpu`           | CPU request for the metrics container                                                   | `50m`                                                                             |
| `metrics.resources.requests.memory`        | Memory request for the metrics container                                                | `64Mi`                                                                            |
| `metrics.resources.limits.cpu`             | CPU limit for the metrics container                                                     | `nil`                                                                             |
| `metrics.resources.limits.memory`          | Memory limit for the metrics container                                                  | `64Mi`                                                                            |
| `metrics.extraArgs`                        | Extra arguments for Redis exporter (e.g. `--redis.addr`, `--web.listen-address`)        | `[]`                                                                              |
| `metrics.service.type`                     | Metrics service type                                                                    | `ClusterIP`                                                                       |
| `metrics.service.port`                     | Metrics service port                                                                    | `9121`                                                                            |
| `metrics.service.annotations`              | Additional custom annotations for Metrics service                                       | `{}`                                                                              |
| `metrics.service.loadBalancerIP`           | LoadBalancer IP if metrics service type is `LoadBalancer`                               | `""`                                                                              |
| `metrics.service.loadBalancerSourceRanges` | Addresses allowed when metrics service is `LoadBalancer`                                | `[]`                                                                              |
| `metrics.service.clusterIP`                | Static clusterIP or None for headless services when metrics service type is `ClusterIP` | `""`                                                                              |
| `metrics.service.nodePort`                 | NodePort value for LoadBalancer and NodePort service types                              | `""`                                                                              |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource(s) for scraping metrics using Prometheus Operator        | `false`                                                                           |
| `metrics.serviceMonitor.namespace`         | Namespace in which to create ServiceMonitor resource(s)                                 | `""`                                                                              |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped                                             | `30s`                                                                             |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                 | `""`                                                                              |
| `metrics.serviceMonitor.relabelings`       | Additional relabeling of metrics                                                        | `[]`                                                                              |
| `metrics.serviceMonitor.metricRelabelings` | Additional metric relabeling of metrics                                                 | `[]`                                                                              |
| `metrics.serviceMonitor.honorLabels`       | Honor metrics labels                                                                    | `false`                                                                           |
| `metrics.serviceMonitor.selector`          | Prometheus instance selector labels                                                     | `{}`                                                                              |
| `metrics.serviceMonitor.annotations`       | Additional custom annotations for the ServiceMonitor                                    | `{}`                                                                              |
| `metrics.serviceMonitor.namespaceSelector` | Namespace selector for ServiceMonitor                                                   | `{}`                                                                              |

### Pod Disruption Budget

| Parameter           | Description                                                    | Default |
|---------------------|----------------------------------------------------------------|---------|
| `pdb.enabled`       | Enable Pod Disruption Budget                                   | `false` |
| `pdb.minAvailable`  | Minimum number/percentage of pods that should remain scheduled | `1`     |
| `pdb.maxUnavailable`| Maximum number/percentage of pods that may be made unavailable | `""`    |

### Persistence

| Parameter                  | Description                              | Default         |
| -------------------------- | ---------------------------------------- | --------------- |
| `persistence.enabled`      | Enable persistent storage                | `true`          |
| `persistence.storageClass` | Storage class for persistent volume      | `""`            |
| `persistence.accessMode`   | Access mode for persistent volume        | `ReadWriteOnce` |
| `persistence.size`         | Size of persistent volume                | `8Gi`           |
| `persistence.mountPath`    | Mount path for Redis data                | `/data`         |
| `persistence.annotations`  | Annotations for persistent volume claims | `{}`            |

### Persistent Volume Claim Retention Policy

| Parameter                                            | Description                                                                     | Default     |
| ---------------------------------------------------- | ------------------------------------------------------------------------------- | ----------- |
| `persistentVolumeClaimRetentionPolicy.enabled`      | Enable Persistent volume retention policy for the Statefulset                  | `false`     |
| `persistentVolumeClaimRetentionPolicy.whenDeleted`  | Volume retention behavior that applies when the StatefulSet is deleted         | `"Retain"`  |
| `persistentVolumeClaimRetentionPolicy.whenScaled`   | Volume retention behavior when the replica count of the StatefulSet is reduced | `"Retain"`  |

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

Redis Sentinel provides high availability for Redis through automatic failover. When enabled in `replication` mode, Sentinel monitors the master and replicas, and promotes a replica to master if the current master becomes unavailable.

| Parameter                            | Description                                           | Default            |
| ------------------------------------ | ----------------------------------------------------- | ------------------ |
| `sentinel.enabled`                   | Enable Redis Sentinel for high availability           | `false`            |
| `sentinel.image.repository`          | Redis Sentinel image repository                       | `redis`            |
| `sentinel.image.tag`                 | Redis Sentinel image tag                              | `8.2.1@sha256:...` |
| `sentinel.image.pullPolicy`          | Sentinel image pull policy                            | `Always`           |
| `sentinel.masterName`                | Name of the master server                             | `mymaster`         |
| `sentinel.quorum`                    | Number of Sentinels needed to agree on master failure | `2`                |
| `sentinel.downAfterMilliseconds`     | Time in ms after master is declared down              | `30000`            |
| `sentinel.failoverTimeout`           | Timeout for failover in ms                            | `180000`           |
| `sentinel.parallelSyncs`             | Number of replicas to reconfigure during failover     | `1`                |
| `sentinel.port`                      | Sentinel port                                         | `26379`            |
| `sentinel.service.type`              | Kubernetes service type for Sentinel                  | `ClusterIP`        |
| `sentinel.service.port`              | Sentinel service port                                 | `26379`            |
| `sentinel.resources.limits.memory`   | Memory limit for Sentinel pods                        | `128Mi`            |
| `sentinel.resources.requests.cpu`    | CPU request for Sentinel pods                         | `25m`              |
| `sentinel.resources.requests.memory` | Memory request for Sentinel pods                      | `64Mi`             |
| `sentinel.extraVolumeMounts`         | Additional volume mounts for Sentinel container       | `[]`               |

### Additional Configuration

| Parameter           | Description                                                             | Default |
| ------------------- | ----------------------------------------------------------------------- | ------- |
| `extraEnv`          | Additional environment variables                                        | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod                                    | `[]`    |
| `extraVolumeMounts` | Additional volume mounts for Redis container                            | `[]`    |
| `extraObjects`      | A list of additional Kubernetes objects to deploy alongside the release | `[]`    |

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

If you want replication without Sentinel (manual failover):

```yaml
# values-replication.yaml
architecture: replication
replicaCount: 2
sentinel:
  enabled: false
```

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
- Chart repository issues
