<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-valkey/valkey"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-valkey" /></a>
</p>

# Valkey

High performance in-memory data structure store, fork of Redis. Valkey is an open-source, high-performance key/value datastore that supports a variety of workloads such as caching, message queues, and can act as a primary database.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-valkey`:

```bash
helm install my-valkey oci://registry-1.docker.io/cloudpirates/valkey
```

To install with custom values:

```bash
helm install my-valkey oci://registry-1.docker.io/cloudpirates/valkey -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-valkey ./charts/valkey
```

The command deploys Valkey on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-valkey` deployment:

```bash
helm uninstall my-valkey
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/valkey:<version>
```

## Configuration

The following table lists the configurable parameters of the Valkey chart and their default values.

### Global parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Image configuration

| Parameter          | Description                                                                                            | Default         |
| ------------------ | ------------------------------------------------------------------------------------------------------ | --------------- |
| `image.registry`   | Valkey image registry                                                                                  | `docker.io`     |
| `image.repository` | Valkey image repository                                                                                | `valkey/valkey` |
| `image.tag`        | Valkey image tag (immutable tags are recommended)                                                      | `"8.0.1"`       |
| `image.digest`     | Valkey image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`            |
| `image.pullPolicy` | Valkey image pull policy                                                                               | `IfNotPresent`  |

### Common configuration

| Parameter           | Description                                                                                    | Default        |
| ------------------- | ---------------------------------------------------------------------------------------------- | -------------- |
| `architecture`      | Valkey architecture. Allowed values: `standalone`, `replication`                               | `standalone`   |
| `replicaCount`      | Number of Valkey replicas to deploy (only when architecture=replication)                       | `3`            |
| `ipFamily`          | IP family to use for replica and sentinel announce IPs. Allowed values: `auto`, `ipv4`, `ipv6` | `auto`         |
| `clusterDomain`     | Kubernetes cluster domain                                                                      | `cluster.local`|
| `nameOverride`      | String to partially override valkey.fullname                                                   | `""`           |
| `fullnameOverride`  | String to fully override valkey.fullname                                                       | `""`           |
| `commonLabels`      | Labels to add to all deployed objects                                                          | `{}`           |
| `commonAnnotations` | Annotations to add to all deployed objects                                                     | `{}`           |

### Pod annotations and labels

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |

### Security Context

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `1000`    |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the Valkey container                  | `999`     |
| `containerSecurityContext.runAsGroup`               | Group ID for the Valkey container                 | `1000`    |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `true`    |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### Valkey Authentication

| Parameter                        | Description                                            | Default      |
| -------------------------------- | ------------------------------------------------------ | ------------ |
| `auth.enabled`                   | Enable password authentication                         | `true`       |
| `auth.password`                  | Valkey password                                        | `""`         |
| `auth.existingSecret`            | The name of an existing secret with Valkey credentials | `""`         |
| `auth.existingSecretPasswordKey` | Password key to be retrieved from existing secret      | `"password"` |

### Valkey Configuration

| Parameter                  | Description                                               | Default                   |
| -------------------------- | --------------------------------------------------------- | ------------------------- |
| `config.maxMemory`         | Maximum memory usage for Valkey (e.g., 256mb, 1gb)        | `""`                      |
| `config.maxMemoryPolicy`   | Memory eviction policy when maxmemory is reached          | `"allkeys-lru"`           |
| `config.save`              | Valkey save configuration (e.g., "900 1 300 10 60 10000") | `"900 1 300 10 60 10000"` |
| `config.extraConfig`       | Additional Valkey configuration parameters                | `[]`                      |
| `config.existingConfigmap` | Name of existing ConfigMap with Valkey configuration      | `""`                      |

### Service configuration

| Parameter             | Description           | Default     |
| --------------------- | --------------------- | ----------- |
| `service.type`        | Valkey service type   | `ClusterIP` |
| `service.port`        | Valkey service port   | `6379`      |
| `service.targetPort`  | Valkey container port | `6379`      |
| `service.annotations` | Service annotations   | `{}`        |

### ServiceAccount configuration

| Parameter                       | Description                                      | Default |
| ------------------------------- | ------------------------------------------------ | ------- |
| `serviceAccount.create`         | Enable creation of a Service Account             | `false` |
| `serviceAccount.name`           | Name of the Service Account                      | `""`    |
| `serviceAccount.annotations`    | Annotations to add to the Service Account        | `{}`    |
| `serviceAccount.automountToken` | Enable automounting of the Service Account token | `false` |

### Ingress configuration

| Parameter                            | Description                                             | Default        |
| ------------------------------------ | ------------------------------------------------------- | -------------- |
| `ingress.enabled`                    | Enable ingress record generation for Valkey             | `false`        |
| `ingress.className`                  | IngressClass that will be used to implement the Ingress | `""`           |
| `ingress.annotations`                | Additional annotations for the Ingress resource         | `{}`           |
| `ingress.hosts[0].host`              | Hostname for Valkey ingress                             | `valkey.local` |
| `ingress.hosts[0].paths[0].path`     | Path for Valkey ingress                                 | `/`            |
| `ingress.hosts[0].paths[0].pathType` | Path type for Valkey ingress                            | `Prefix`       |
| `ingress.tls`                        | TLS configuration for Valkey ingress                    | `[]`           |

### Resources

| Parameter   | Description                                 | Default |
| ----------- | ------------------------------------------- | ------- |
| `resources` | The resources to allocate for the container | `{}`    |

### Persistence

| Parameter                   | Description                                        | Default             |
| --------------------------- | -------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims  | `true`              |
| `persistence.storageClass`  | Persistent Volume storage class                    | `""`                |
| `persistence.annotations`   | Persistent Volume Claim annotations                | `{}`                |
| `persistence.size`          | Persistent Volume size                             | `8Gi`               |
| `persistence.accessModes`   | Persistent Volume access modes                     | `["ReadWriteOnce"]` |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`                |

### Liveness and readiness probes

| Parameter                            | Description                                | Default |
| ------------------------------------ | ------------------------------------------ | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on Valkey containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe    | `20`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe           | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe          | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe        | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe        | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on Valkey containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe   | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe          | `5`     |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe         | `1`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe       | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe       | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on Valkey containers   | `false` |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe     | `20`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe            | `5`     |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe           | `1`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe         | `30`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe         | `1`     |

### Node Selection

| Parameter      | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `nodeSelector` | Node labels for pod assignment       | `{}`    |
| `tolerations`  | Toleration labels for pod assignment | `[]`    |
| `affinity`     | Affinity settings for pod assignment | `{}`    |

### Metrics configuration

| Parameter                                  | Description                                                                     | Default                    |
| ------------------------------------------ | ------------------------------------------------------------------------------- | -------------------------- |
| `metrics.enabled`                          | Start a sidecar prometheus exporter to expose Valkey metrics                    | `false`                    |
| `metrics.image.registry`                   | Valkey exporter image registry                                                  | `docker.io`                |
| `metrics.image.repository`                 | Valkey exporter image repository                                                | `oliver006/redis_exporter` |
| `metrics.image.tag`                        | Valkey exporter image tag                                                       | `v1.78.0-alpine`           |
| `metrics.image.pullPolicy`                 | Valkey exporter image pull policy                                               | `Always`                   |
| `metrics.resources`                        | Resource limits and requests for metrics container                              | `{}`                       |
| `metrics.service.annotations`              | Additional custom annotations for Metrics service                               | `{}`                       |
| `metrics.service.labels`                   | Additional custom labels for Metrics service                                    | `{}`                       |
| `metrics.service.port`                     | Metrics service port                                                            | `9121`                     |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator | `false`                    |
| `metrics.serviceMonitor.namespace`         | The namespace in which the ServiceMonitor will be created                       | `""`                       |
| `metrics.serviceMonitor.interval`          | The interval at which metrics should be scraped                                 | `30s`                      |
| `metrics.serviceMonitor.scrapeTimeout`     | The timeout after which the scrape is ended                                     | `10s`                      |
| `metrics.serviceMonitor.selector`          | Additional labels for ServiceMonitor resource                                   | `{}`                       |
| `metrics.serviceMonitor.annotations`       | ServiceMonitor annotations                                                      | `{}`                       |
| `metrics.serviceMonitor.honorLabels`       | honorLabels chooses the metric's labels on collisions with target labels        | `false`                    |
| `metrics.serviceMonitor.relabelings`       | ServiceMonitor relabel configs to apply to samples before scraping              | `[]`                       |
| `metrics.serviceMonitor.metricRelabelings` | ServiceMonitor metricRelabelings configs to apply to samples before ingestion   | `[]`                       |
| `metrics.serviceMonitor.namespaceSelector` | ServiceMonitor namespace selector                                               | `{}`                       |

### Valkey Sentinel Configuration

Sentinel provides high availability for Valkey replication. When enabled, Sentinel monitors the master and automatically promotes a replica to master if the master fails.

| Parameter                           | Description                                                                             | Default                                                                                      |
| ----------------------------------- | --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `sentinel.enabled`                  | Enable Valkey Sentinel for high availability                                            | `false`                                                                                      |
| `sentinel.image.repository`         | Valkey Sentinel image repository                                                        | `valkey/valkey`                                                                              |
| `sentinel.image.tag`                | Valkey Sentinel image tag                                                               | `"9.0.0-alpine3.22@sha256:b4ee67d73e00393e712accc72cfd7003b87d0fcd63f0eba798b23251bfc9c394"` |
| `sentinel.image.pullPolicy`         | Valkey Sentinel image pull policy                                                       | `Always`                                                                                     |
| `sentinel.masterName`               | Name of the master server                                                               | `mymaster`                                                                                   |
| `sentinel.quorum`                   | Number of Sentinels that need to agree about the fact the master is not reachable       | `2`                                                                                          |
| `sentinel.downAfterMilliseconds`    | Time in milliseconds after the master is declared down                                  | `1500`                                                                                       |
| `sentinel.failoverTimeout`          | Timeout for failover in milliseconds                                                    | `15000`                                                                                      |
| `sentinel.parallelSyncs`            | Number of replicas that can be reconfigured to use the new master during a failover     | `1`                                                                                          |
| `sentinel.port`                     | Sentinel port                                                                           | `26379`                                                                                      |
| `sentinel.extraVolumeMounts`        | Additional volume mounts to add to the Sentinel container                               | `[]`                                                                                         |
| `sentinel.service.type`             | Kubernetes service type for Sentinel                                                    | `ClusterIP`                                                                                  |
| `sentinel.service.port`             | Sentinel service port                                                                   | `26379`                                                                                      |
| `sentinel.resources.limits.memory`  | Memory limit for Sentinel container                                                     | `128Mi`                                                                                      |
| `sentinel.resources.limits.cpu`     | CPU limit for Sentinel container                                                        | Not set                                                                                      |
| `sentinel.resources.requests.cpu`   | CPU request for Sentinel container                                                      | `25m`                                                                                        |
| `sentinel.resources.requests.memory`| Memory request for Sentinel container                                                   | `64Mi`                                                                                       |

### Init Container Configuration

| Parameter                             | Description                                 | Default  |
| ------------------------------------- | ------------------------------------------- | -------- |
| `initContainer.resources.limits.cpu`    | CPU limit for init container              | `50m`    |
| `initContainer.resources.limits.memory` | Memory limit for init container           | `128Mi`  |
| `initContainer.resources.requests.cpu`  | CPU request for init container            | `25m`    |
| `initContainer.resources.requests.memory`| Memory request for init container        | `64Mi`   |

### Additional Configuration

| Parameter      | Description                                                             | Default |
| -------------- | ----------------------------------------------------------------------- | ------- |
| `extraEnvVars` | Additional environment variables to set                                 | `[]`    |
| `extraObjects` | A list of additional Kubernetes objects to deploy alongside the release | `[]`    |

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

Deploy Valkey with default configuration:

```bash
helm install my-valkey ./charts/valkey
```

### Production Setup with Persistence

```yaml
# values-production.yaml
persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 20Gi

resources:
  requests:
    memory: "512Mi"
    cpu: "250m"
  limits:
    memory: "1Gi"
    cpu: "500m"

auth:
  enabled: true
  password: "your-secure-password"

config:
  maxMemory: "800mb"
  maxMemoryPolicy: "allkeys-lru"
  save: "900 1 300 10 60 10000"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: valkey.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: valkey-tls
      hosts:
        - valkey.yourdomain.com
```

Deploy with production values:

```bash
helm install my-valkey ./charts/valkey -f values-production.yaml
```

### High Availability Configuration with Sentinel

Deploy Valkey with Sentinel for automatic failover:

```yaml
# values-ha-sentinel.yaml
# Enable replication architecture
architecture: replication

# Deploy 3 Valkey instances (1 master + 2 replicas)
replicaCount: 3

# Enable Sentinel for automatic failover
sentinel:
  enabled: true
  masterName: mymaster
  quorum: 2
  downAfterMilliseconds: 1500
  failoverTimeout: 15000
  parallelSyncs: 1
  resources:
    limits:
      memory: 128Mi
    requests:
      cpu: 25m
      memory: 64Mi

# Enable authentication
auth:
  enabled: true
  password: "your-secure-password"

# Configure persistence
persistence:
  enabled: true
  size: 10Gi
  storageClass: "fast-ssd"

# Resource allocation for Valkey
resources:
  requests:
    memory: "512Mi"
    cpu: "250m"
  limits:
    memory: "1Gi"
    cpu: "500m"

# Init container resources
initContainer:
  resources:
    limits:
      cpu: 50m
      memory: 128Mi
    requests:
      cpu: 25m
      memory: 64Mi

# Spread pods across nodes for better availability
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
                  - valkey
          topologyKey: kubernetes.io/hostname
```

Deploy with Sentinel HA:

```bash
helm install my-valkey ./charts/valkey -f values-ha-sentinel.yaml
```

**Connecting to Sentinel-enabled Valkey:**

When Sentinel is enabled, your application should use a Sentinel-aware client to automatically discover the current master. The Sentinel service provides endpoints for querying the master:

```bash
# Get the current master from Sentinel
kubectl run -it --rm valkey-client --image=valkey/valkey:9.0.0-alpine3.22 --restart=Never -- sh
valkey-cli -h my-valkey-sentinel -p 26379 SENTINEL get-master-addr-by-name mymaster
```

Connection URLs for Sentinel-aware clients:
- Sentinel endpoints: `my-valkey-sentinel:26379`
- Master name: `mymaster` (or your configured `sentinel.masterName`)

### High Availability Configuration without Sentinel

Deploy multiple replicas without Sentinel (pod-0 is always master):

```yaml
# values-ha-replication.yaml
architecture: replication
replicaCount: 3

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
                  - valkey
          topologyKey: kubernetes.io/hostname

resources:
  requests:
    memory: "1Gi"
    cpu: "500m"
  limits:
    memory: "2Gi"
    cpu: "1000m"
```

### Using Existing Secret for Authentication

```yaml
# values-external-secret.yaml
auth:
  enabled: true
  existingSecret: "valkey-credentials"
  existingSecretPasswordKey: "password"
```

Create the secret first:

```bash
kubectl create secret generic valkey-credentials \
  --from-literal=password=your-secure-password
```

### Custom Configuration

```yaml
# values-custom-config.yaml
config:
  maxMemory: "2gb"
  maxMemoryPolicy: "volatile-lru"
  save: "300 10 60 10000"
  extraConfig:
    - "timeout 300"
    - "tcp-keepalive 60"
    - "databases 16"
```

### Monitoring with Prometheus

Enable metrics collection with Prometheus:

```yaml
# values-monitoring.yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

You can access metrics directly via port-forward:

```bash
kubectl port-forward service/my-valkey-metrics 9121:9121
curl http://localhost:9121/metrics
```

## Access Valkey

### Standalone or Replication (without Sentinel)

#### Via kubectl port-forward

```bash
kubectl port-forward service/my-valkey 6379:6379
```

#### Connect using valkey-cli

```bash
# Without authentication
valkey-cli -h localhost -p 6379

# With authentication
valkey-cli -h localhost -p 6379 -a your-password
```

### With Sentinel Enabled

When Sentinel is enabled, three services are created:

1. **my-valkey-sentinel** (port 26379): Sentinel service for querying master/replica information
2. **my-valkey-master** (port 6379): Points to the current master (headless service)
3. **my-valkey** (port 6379): Headless service for all Valkey instances

#### Connect to Sentinel

```bash
# Port-forward to Sentinel
kubectl port-forward service/my-valkey-sentinel 26379:26379

# Query master information
valkey-cli -h localhost -p 26379 SENTINEL get-master-addr-by-name mymaster

# List all replicas
valkey-cli -h localhost -p 26379 SENTINEL replicas mymaster
```

#### Connect to current master

```bash
# Port-forward to master service
kubectl port-forward service/my-valkey-master 6379:6379

# Connect with valkey-cli
valkey-cli -h localhost -p 6379 -a your-password
```

### Default Credentials

- **Password**: Auto-generated (check secret) or configured value

Get the auto-generated password:

```bash
kubectl get secret my-valkey -o jsonpath="{.data.password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with permission errors**

   - Ensure your storage class supports the required access modes
   - Check if security contexts are compatible with your cluster policies

2. **Cannot connect to Valkey**

   - Verify the service is running: `kubectl get svc`
   - Check if authentication is properly configured
   - Ensure firewall rules allow access to port 6379

3. **Persistent volume not mounting**

   - Verify storage class exists: `kubectl get storageclass`
   - Check PVC status: `kubectl get pvc`
   - Review pod events: `kubectl describe pod <pod-name>`

4. **Memory issues**
   - Check configured maxMemory limit
   - Monitor memory usage with `valkey-cli info memory`
   - Adjust memory eviction policy if needed

5. **Sentinel failover issues**
   - Ensure `sentinel.quorum` is properly configured (typically `floor(replicas/2) + 1`)
   - Check Sentinel logs: `kubectl logs <pod-name> -c sentinel`
   - Verify all Sentinels can communicate with each other
   - Check if Sentinel can reach all Valkey instances
   - Review Sentinel configuration: `valkey-cli -h <sentinel-service> -p 26379 SENTINEL master mymaster`

### Getting Support

For issues related to this Helm chart, please check:

- [Valkey Documentation](https://valkey.io/documentation/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
