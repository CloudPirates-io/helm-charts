<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-memcached/memcached"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-memcached" /></a>
</p>

# Memcached

Memcached is a high-performance, distributed memory object caching system. It is an in-memory key-value store for small chunks of arbitrary data from results of database calls, API calls, or page rendering. This Helm chart deploys Memcached on Kubernetes with comprehensive configuration options for development and production environments.

## Installing the Chart

To install the chart with the release name `my-memcached`:

```bash
helm install my-memcached oci://registry-1.docker.io/cloudpirates/memcached
```

To install with custom values:

```bash
helm install my-memcached oci://registry-1.docker.io/cloudpirates/memcached -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-valkey ./charts/valkey
```

## Uninstalling the Chart

To uninstall/delete the `my-memcached` deployment:

```bash
helm uninstall my-memcached
```

This removes all the Kubernetes components associated with the chart and deletes the release.

## Security & Signature Verification

This Helm chart is cryptographically signed with Cosign to ensure authenticity and prevent tampering.

**Public Key:**

```
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE5U+rM2d3hDjgP5T3cLShuuQIU9vR
Z4/G+Nug6q5vRa+C3qUA1wXjbaJFAfcIrv5VjmYAYOj13shnPpp3Zh4fnQ==
-----END PUBLIC KEY-----
```

To verify the helm chart before installation, copy the public key to the file `cosign.pub` and run cosign:

```bash
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/memcached:<version>
```

## Configuration

The following table lists the configurable parameters of the Memcached chart and their default values.

### Global Parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common Parameters

| Parameter           | Description                                              | Default |
| ------------------- | -------------------------------------------------------- | ------- |
| `nameOverride`      | String to partially override memcached.fullname          | `""`    |
| `fullnameOverride`  | String to fully override memcached.fullname              | `""`    |
| `commonLabels`      | Labels to add to all deployed objects                    | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects               | `{}`    |
| `podAnnotations`    | Annotations to add to the pods created by the deployment | `{}`    |
| `podLabels`         | Labels to add to the pods created by the deployment      | `{}`    |

### Deployment Parameters

| Parameter        | Description                                            | Default      |
| ---------------- | ------------------------------------------------------ | ------------ |
| `replicaCount`   | Number of Memcached replicas to deploy                 | `1`          |
| `deploymentType` | Type of workload to deploy (Deployment or StatefulSet) | `Deployment` |

### Memcached Image Parameters

| Parameter           | Description                                          | Default                                                                            |
| ------------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `image.registry`    | Memcached image registry                             | `docker.io`                                                                        |
| `image.repository`  | Memcached image repository                           | `memcached`                                                                        |
| `image.tag`         | Memcached image tag (immutable tags are recommended) | `"1.6.39@sha256:050de63e6c082df85f93ffed9c388004b3c6257a06f1904e8628a6f87658eb99"` |
| `image.pullPolicy`  | Memcached image pull policy                          | `Always`                                                                           |
| `image.pullSecrets` | Memcached image pull secrets                         | `[]`                                                                               |

### Memcached Configuration Parameters

| Parameter               | Description                                    | Default |
| ----------------------- | ---------------------------------------------- | ------- |
| `config.memoryLimit`    | Maximum amount of memory to use for cache (MB) | `64`    |
| `config.maxConnections` | Maximum number of simultaneous connections     | `1024`  |
| `config.verbosity`      | Verbosity level (0-2)                          | `0`     |
| `config.extraArgs`      | Additional command-line arguments              | `[]`    |

### Service Parameters

| Parameter             | Description                                         | Default     |
| --------------------- | --------------------------------------------------- | ----------- |
| `service.type`        | Memcached service type                              | `ClusterIP` |
| `service.port`        | Memcached service port                              | `11211`     |
| `service.nodePort`    | Node port for Memcached service                     | `""`        |
| `service.clusterIP`   | Static cluster IP or "None" for headless service    | `""`        |
| `service.annotations` | Additional custom annotations for Memcached service | `{}`        |

### Security Context Parameters

| Parameter                                           | Description                                             | Default |
| --------------------------------------------------- | ------------------------------------------------------- | ------- |
| `podSecurityContext.enabled`                        | Enabled Memcached pod Security Context                  | `true`  |
| `podSecurityContext.fsGroup`                        | Set Memcached pod's Security Context fsGroup            | `11211` |
| `containerSecurityContext.runAsUser`                | Set Memcached container's Security Context runAsUser    | `11211` |
| `containerSecurityContext.runAsNonRoot`             | Set Memcached container's Security Context runAsNonRoot | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Set Memcached container's privilege escalation          | `false` |
| `priorityClassName`                                 | Priority class for the memcached instance               | `""`    |

### Resources Parameters

| Parameter            | Description                                          | Default                        |
| -------------------- | ---------------------------------------------------- | ------------------------------ |
| `resources.limits`   | The resources limits for the Memcached containers    | `{memory: "128Mi"}`            |
| `resources.requests` | The requested resources for the Memcached containers | `{cpu: "50m", memory: "64Mi"}` |

### Health Check Parameters

| Parameter                            | Description                                   | Default |
| ------------------------------------ | --------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on Memcached containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe       | `30`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe              | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe             | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe           | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe           | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on Memcached containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe      | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe             | `5`     |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe            | `5`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe          | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe          | `1`     |

### Service Account Parameters

| Parameter                                     | Description                                           | Default |
| --------------------------------------------- | ----------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a service account should be created | `true`  |
| `serviceAccount.annotations`                  | Annotations to add to the service account             | `{}`    |
| `serviceAccount.name`                         | The name of the service account to use                | `""`    |
| `serviceAccount.automountServiceAccountToken` | Automatically mount service account token             | `false` |

### ConfigMap Parameters

| Parameter          | Description                                    | Default |
| ------------------ | ---------------------------------------------- | ------- |
| `configMap.create` | Create a ConfigMap for Memcached configuration | `false` |
| `configMap.data`   | ConfigMap data                                 | `{}`    |

### Ingress Parameters

| Parameter             | Description                                                                   | Default                                                                                         |
| --------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `ingress.enabled`     | Enable ingress record generation for Memcached                                | `false`                                                                                         |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+) | `""`                                                                                            |
| `ingress.annotations` | Additional annotations for the Ingress resource                               | `{}`                                                                                            |
| `ingress.hosts`       | An array with hosts and paths                                                 | `[{"host": "memcached.local", "paths": [{"path": "/", "pathType": "ImplementationSpecific"}]}]` |
| `ingress.tls`         | TLS configuration for the Ingress                                             | `[]`                                                                                            |

### Pod Disruption Budget Parameters

| Parameter            | Description                                                    | Default |
| -------------------- | -------------------------------------------------------------- | ------- |
| `pdb.create`         | Enable/disable a Pod Disruption Budget creation                | `false` |
| `pdb.minAvailable`   | Minimum number/percentage of pods that should remain scheduled | `""`    |
| `pdb.maxUnavailable` | Maximum number/percentage of pods that may be made unavailable | `""`    |

### Extra Configuration Parameters

| Parameter           | Description                                                                         | Default |
| ------------------- | ----------------------------------------------------------------------------------- | ------- |
| `extraEnvVars`      | Additional environment variables to set                                             | `[]`    |
| `extraVolumes`      | A list of additional existing volumes that will be mounted into the container       | `[]`    |
| `extraVolumeMounts` | A list of additional existing volume mounts that will be mounted into the container | `[]`    |
| `extraObjects`      | A list of additional Kubernetes objects to deploy alongside the release             | `[]`    |

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

### Pod Configuration Parameters

| Parameter        | Description                    | Default |
| ---------------- | ------------------------------ | ------- |
| `podAnnotations` | Additional pod annotations     | `{}`    |
| `podLabels`      | Additional pod labels          | `{}`    |
| `nodeSelector`   | Node labels for pod assignment | `{}`    |
| `tolerations`    | Tolerations for pod assignment | `[]`    |
| `affinity`       | Affinity for pod assignment    | `{}`    |

### Metrics

| Parameter                                  | Description                                                                            | Default                   |
| ------------------------------------------ | -------------------------------------------------------------------------------------- | ------------------------- |
| `metrics.enabled`                          | Start a sidecar Prometheus exporter to expose Memcached metrics                        | `false`                   |
| `metrics.image.registry`                   | Memcached exporter image registry                                                      | `docker.io`               |
| `metrics.image.repository`                 | Memcached exporter image repository                                                    | `prom/memcached-exporter` |
| `metrics.image.tag`                        | Memcached exporter image tag                                                           | `v0.15.4@sha256...`       |
| `metrics.image.pullPolicy`                 | Memcached exporter image pull policy                                                   | `Always`                  |
| `metrics.resources.requests.cpu`           | CPU request for the metrics container                                                  | `50m`                     |
| `metrics.resources.requests.memory`        | Memory request for the metrics container                                               | `64Mi`                    |
| `metrics.resources.limits.cpu`             | CPU limit for the metrics container                                                    | `nil`                     |
| `metrics.resources.limits.memory`          | Memory limit for the metrics container                                                 | `64Mi`                    |
| `metrics.extraArgs`                        | Extra arguments for Memcached exporter (e.g. `--log.level=debug`, `--log.format=json`) | `[]`                      |
| `metrics.service.type`                     | Metrics service type                                                                   | `ClusterIP`               |
| `metrics.service.port`                     | Metrics service port                                                                   | `9150`                    |
| `metrics.service.annotations`              | Additional custom annotations for Metrics service                                      | `{}`                      |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource for scraping metrics using Prometheus Operator          | `false`                   |
| `metrics.serviceMonitor.jobLabel`          | The name of the jobLabel for the ServiceMonitor                                        | `""`                      |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped                                            | `30s`                     |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                                | `""`                      |
| `metrics.serviceMonitor.relabelings`       | Relabeling rules to apply the target’s metadata labels before scraping.                | `[]`                      |
| `metrics.serviceMonitor.metricRelabelings` | Relabeling rules to apply to the samples before ingestion.                             | `[]`                      |
| `metrics.serviceMonitor.honorLabels`       | Honor metrics labels when they collide with Prometheus target labels                   | `false`                   |
| `metrics.serviceMonitor.labels`            | Additional service monitor labels                                                      | `{}`                      |
| `metrics.serviceMonitor.annotations`       | Additional custom annotations for the ServiceMonitor                                   | `{}`                      |
| `metrics.serviceMonitor.namespaceSelector` | Which namespace(s) Prometheus should discover the services in.                         | `{}`                      |


## Examples

### Basic Installation

Create a `values.yaml` file:

```yaml
config:
  memoryLimit: 128
  maxConnections: 2048

resources:
  limits:
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

Install the chart:

```bash
helm install my-memcached charts/memcached -f values.yaml
```

### Production Setup

```yaml
replicaCount: 3

config:
  memoryLimit: 512
  maxConnections: 4096
  verbosity: 1

resources:
  limits:
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi

service:
  type: ClusterIP

# Enable Pod Disruption Budget for high availability
pdb:
  create: true
  minAvailable: 1

# Use anti-affinity to spread pods across nodes
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
              - key: app.kubernetes.io/name
                operator: In
                values:
                  - memcached
          topologyKey: kubernetes.io/hostname
```

### StatefulSet Deployment

If you need stable network identities or persistent storage, use a StatefulSet instead of a Deployment:

```yaml
deploymentType: StatefulSet
replicaCount: 3

config:
  memoryLimit: 256
  maxConnections: 2048

resources:
  limits:
    memory: 512Mi
  requests:
    cpu: 200m
    memory: 256Mi

# StatefulSets use a headless service for stable network identity
service:
  type: ClusterIP
```

### Custom Configuration with ConfigMap

```yaml
configMap:
  create: true
  data:
    memcached.conf: |
      -m 256
      -c 2048
      -v

config:
  extraArgs:
    - "-o"
    - "modern"
```

### With Service Account

```yaml
serviceAccount:
  create: true
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/memcached-role
```

## Troubleshooting

### Connection Issues

1. **Check deployment and service status**:

   ```bash
   kubectl get deployment -l app.kubernetes.io/name=memcached
   kubectl get svc -l app.kubernetes.io/name=memcached
   kubectl get pods -l app.kubernetes.io/name=memcached
   ```

2. **Test connection from within cluster**:

   ```bash
   kubectl run memcached-client --rm --tty -i --restart='Never' --image memcached:1.6.39 -- bash
   # Inside the pod:
   telnet <service-name> 11211
   ```

3. **Check Memcached stats**:
   ```bash
   kubectl run memcached-client --rm --tty -i --restart='Never' --image memcached:1.6.39 -- bash
   echo "stats" | nc <service-name> 11211
   ```

### Memory Issues

1. **Monitor memory usage**:

   ```bash
   kubectl run memcached-client --rm --tty -i --restart='Never' --image memcached:1.6.39 -- bash
   echo "stats" | nc <service-name> 11211 | grep bytes
   ```

2. **Flush cache if needed**:
   ```bash
   kubectl run memcached-client --rm --tty -i --restart='Never' --image memcached:1.6.39 -- bash
   echo "flush_all" | nc <service-name> 11211
   ```

### Performance Tuning

For production workloads, consider:

- Setting appropriate memory limits based on your cache requirements
- Configuring connection limits via `config.maxConnections`
- Using multiple replicas with consistent hashing for load distribution
- Monitoring cache hit/miss ratios
- Setting appropriate resource requests and limits

## Links

- [Memcached Official Documentation](https://memcached.org/)
- [Memcached Docker Hub](https://hub.docker.com/_/memcached)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)