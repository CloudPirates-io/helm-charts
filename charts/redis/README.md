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

| Parameter           | Description                                 | Default |
| ------------------- | ------------------------------------------- | ------- |
| `nameOverride`      | String to partially override redis.fullname | `""`    |
| `fullnameOverride`  | String to fully override redis.fullname     | `""`    |
| `commonLabels`      | Labels to add to all deployed objects       | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects  | `{}`    |
| `replicaCount`      | Number of Redis replicas to deploy          | `1`     |

### Service Configuration

| Parameter      | Description             | Default     |
| -------------- | ----------------------- | ----------- |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Redis service port      | `6379`      |

### Authentication

| Parameter                        | Description                                                  | Default |
| -------------------------------- | ------------------------------------------------------------ | ------- |
| `auth.enabled`                   | Enable Redis authentication                                  | `true`  |
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

### Persistence

| Parameter                  | Description                              | Default         |
| -------------------------- | ---------------------------------------- | --------------- |
| `persistence.enabled`      | Enable persistent storage                | `true`          |
| `persistence.storageClass` | Storage class for persistent volume      | `""`            |
| `persistence.accessMode`   | Access mode for persistent volume        | `ReadWriteOnce` |
| `persistence.size`         | Size of persistent volume                | `8Gi`           |
| `persistence.mountPath`    | Mount path for Redis data                | `/data`         |
| `persistence.annotations`  | Annotations for persistent volume claims | `{}`            |

### Resource Management

| Parameter                   | Description    | Default |
| --------------------------- | -------------- | ------- |
| `resources.limits.memory`   | Memory limit   | `256Mi` |
| `resources.requests.cpu`    | CPU request    | `50m`   |
| `resources.requests.memory` | Memory request | `128Mi` |

### Pod Assignment / Eviction

| Parameter           | Description                       | Default |
| ------------------- | --------------------------------- | ------- |
| `nodeSelector`      | Node selector for pod assignment  | `{}`    |
| `priorityClassName` | Priority class for pod eviction   | `""`    |
| `tolerations`       | Tolerations for pod assignment    | `[]`    |
| `affinity`          | Affinity rules for pod assignment | `{}`    |

### Security Context

| Parameter                                           | Description                    | Default |
| --------------------------------------------------- | ------------------------------ | ------- |
| `containerSecurityContext.runAsUser`                | User ID to run the container   | `999`   |
| `containerSecurityContext.runAsNonRoot`             | Run as non-root user           | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation     | `false` |
| `podSecurityContext.fsGroup`                        | Pod's Security Context fsGroup | `999`   |

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
