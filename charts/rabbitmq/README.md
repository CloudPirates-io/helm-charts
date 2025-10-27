<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-rabbitmq"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-rabbitmq" /></a>
</p>

# RabbitMQ

A Helm chart for RabbitMQ - A messaging broker that implements the Advanced Message Queuing Protocol (AMQP). RabbitMQ is a reliable, feature-rich message broker that supports multiple messaging patterns and is widely used for building distributed systems, microservices communication, and event-driven architectures.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/rabbitmq:<version>
```

## Installing the Chart

To install the chart with the release name `my-rabbitmq`:

```bash
$ helm install my-rabbitmq oci://registry-1.docker.io/cloudpirates/rabbitmq
```

Or install directly from the local chart:

```bash
$ helm install my-rabbitmq ./charts/rabbitmq
```

The command deploys RabbitMQ on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-rabbitmq` deployment:

```bash
$ helm uninstall my-rabbitmq
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/rabbitmq:<version>
```

## Configuration

The following table lists the configurable parameters of the RabbitMQ chart and their default values.

### Global parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Parameter           | Description                                    | Default         |
| ------------------- | ---------------------------------------------- | --------------- |
| `nameOverride`      | String to partially override rabbitmq.fullname | `""`            |
| `fullnameOverride`  | String to fully override rabbitmq.fullname     | `""`            |
| `commonLabels`      | Labels to add to all deployed objects          | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects     | `{}`            |
| `clusterDomain`     | Kubernetes cluster domain                      | `cluster.local` |

### RabbitMQ image parameters

| Parameter               | Description                | Default                                                                                     |
| ----------------------- | -------------------------- | ------------------------------------------------------------------------------------------- |
| `image.registry`        | RabbitMQ image registry    | `docker.io`                                                                                 |
| `image.repository`      | RabbitMQ image repository  | `rabbitmq`                                                                                  |
| `image.tag`             | RabbitMQ image tag         | `"4.1.3-managemen@sha256:4c521003d812dd7b33793e2b7e45fbcc323d764b8c3309dfcb0e4c5db30c56ab"` |
| `image.imagePullPolicy` | RabbitMQ image pull policy | `Always`                                                                                    |

### Deployment configuration

| Parameter             | Description                                                                                        | Default        |
| --------------------- | -------------------------------------------------------------------------------------------------- | -------------- |
| `replicaCount`        | Number of RabbitMQ replicas to deploy (clustering needs to be enabled to set more than 1 replicas) | `1`            |
| `podManagementPolicy` | StatefulSet pod management policy                                                                  | `OrderedReady` |

### StatefulSet & Pod metadata

| Parameter                | Description                     | Default |
| ------------------------ | ------------------------------- | ------- |
| `statefulsetLabels`      | Labels to attach to StatefulSet | `{}`    |
| `podLabels`              | Labels to attach to pods        | `{}`    |
| `podAnnotations`         | Annotations to attach to pods   | `{}`    |
| `statefulsetAnnotations` | Annotations for StatefulSet     | `{}`    |

### RabbitMQ Definitions

| Parameter                          | Description                                                                                                                                  | Default     |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| `definitions.enabled`              | Enable loading of RabbitMQ definitions on startup. When `true`, definitions will be loaded at container boot.                                | `false`     |
| `definitions.existingConfigMap`    | Name of an existing ConfigMap containing RabbitMQ definitions (e.g., created via `kubectl create configmap rmq-defs --from-file=defs.json`). | `""`        |
| `definitions.existingConfigMapKey` | Key in the existing ConfigMap containing the RabbitMQ definitions JSON file.                                                                 | `defs.json` |
| `defintions.existingSecret`        | Name of an existing Secret containing RabbitMQ definitions.                                                                                  | `""`        |
| `definitions.existingSecretKey`    | Key in the existing Secret containing the RabbitMQ definitions JSON file.                                                                    | `defs.json` |
| `definitions.users`                | Array of RabbitMQ users to create.                                                                                                           | `[]`        |
| `definitions.vhosts`               | Array of RabbitMQ virtual hosts to create.                                                                                                   | `[]`        |
| `definitions.permissions`          | Array of RabbitMQ permissions to set per vhost.                                                                                              | `[]`        |
| `definitions.queues`               | Array of RabbitMQ queues to create.                                                                                                          | `[]`        |
| `definitions.exchanges`            | Array of RabbitMQ exchanges to create.                                                                                                       | `[]`        |
| `definitions.bindings`             | Array of RabbitMQ bindings to create.                                                                                                        | `[]`        |
| `definitions.parameters`           | Array of RabbitMQ parameters to create.                                                                                                      | `[]`        |
| `definitions.global_parameters`    | Array of RabbitMQ global parameters to create.                                                                                               | `[]`        |
| `definitions.topic_permissions`    | Array of RabbitMQ topic permissions to create.                                                                                               | `[]`        |
| `definitions.policies`             | Array of RabbitMQ policies to create.                                                                                                        | `[]`        |

### Service configuration

| Parameter                     | Description                                 | Default     |
| ----------------------------- | ------------------------------------------- | ----------- |
| `service.type`                | Kubernetes service type                     | `ClusterIP` |
| `service.amqpPort`            | RabbitMQ AMQP service port                  | `5672`      |
| `service.managementPort`      | RabbitMQ management UI port                 | `15672`     |
| `service.epmdPort`            | RabbitMQ EPMD port                          | `4369`      |
| `service.distPort`            | RabbitMQ distribution port                  | `25672`     |
| `service.annotations`         | Kubernetes service annotations              | `{}`        |
| `service.annotationsHeadless` | Kubernetes service annotationsHeadless      | `25672`     |
| `service.trafficDistribution` | Traffic distribution policy for the service | `""`        |

### RabbitMQ Authentication

| Parameter                      | Description                                                              | Default           |
| ------------------------------ | ------------------------------------------------------------------------ | ----------------- |
| `auth.enabled`                 | Enable RabbitMQ authentication                                           | `true`            |
| `auth.username`                | RabbitMQ default username                                                | `admin`           |
| `auth.password`                | RabbitMQ password (if empty, random password will be generated)          | `""`              |
| `auth.erlangCookie`            | Erlang cookie for clustering (if empty, random cookie will be generated) | `""`              |
| `auth.existingSecret`          | Name of existing secret containing RabbitMQ credentials                  | `""`              |
| `auth.existingPasswordKey`     | Key in existing secret containing RabbitMQ password                      | `"password"`      |
| `auth.existingErlangCookieKey` | Key in existing secret containing Erlang cookie                          | `"erlang-cookie"` |

### RabbitMQ configuration

| Parameter                            | Description                                                 | Default      |
| ------------------------------------ | ----------------------------------------------------------- | ------------ |
| `config.memoryHighWatermark.enabled` | Enable configuring Memory high watermark on RabbitMQ        | `false`      |
| `config.memoryHighWatermark.type`    | Memory high watermark type. Either `absolute` or `relative` | `"relative"` |
| `config.memoryHighWatermark.value`   | Memory high watermark value                                 | `0.4`        |
| `config.extraConfiguration`          | Additional RabbitMQ configuration                           | `""`         |
| `config.advancedConfiguration`       | Advanced RabbitMQ configuration                             | `""`         |

### PeerDiscoveryK8sPlugin configuration

| Parameter                            | Description                                                | Default    |
| ------------------------------------ | ---------------------------------------------------------- | ---------- |
| `peerDiscoveryK8sPlugin.enabled`     | Enable K8s peer discovery plugin for a RabbitMQ HA-cluster | `false`    |
| `peerDiscoveryK8sPlugin.useLongname` | Uses the FQDN as connection string (RABBITMQ_USE_LONGNAME) | `true`     |
| `peerDiscoveryK8sPlugin.addressType` | Peer discovery plugin address type                         | `hostname` |

### ManagementPlugin configuration

| Parameter                  | Description                       | Default |
| -------------------------- | --------------------------------- | ------- |
| `managementPlugin.enabled` | Enable RabbitMQ management plugin | `true`  |

## Plugin configuration

| Parameter        | Description                                                  | Default |
| ---------------- | ------------------------------------------------------------ | ------- |
| `installPlugins` | Additional 3rd party RabbitMQ plugins to download and enable | `[]`    |

### Metrics configuration

| Parameter                              | Description                                                                                                                 | Default |
| -------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | ------- |
| `metrics.enabled`                      | Enable RabbitMQ metrics (via prometheus plugin)                                                                             | `false` |
| `metrics.port`                         | RabbitMQ metrics port                                                                                                       | `15692` |
| `metrics.serviceMonitor.enabled`       | Create ServiceMonitor for Prometheus monitoring                                                                             | `false` |
| `metrics.serviceMonitor.namespace`     | Namespace for ServiceMonitor                                                                                                | `""`    |
| `metrics.serviceMonitor.labels`        | Labels for ServiceMonitor                                                                                                   | `{}`    |
| `metrics.serviceMonitor.annotations`   | Annotations for ServiceMonitor                                                                                              | `{}`    |
| `metrics.serviceMonitor.interval`      | Scrape interval                                                                                                             | `30s`   |
| `metrics.serviceMonitor.scrapeTimeout` | Scrape timeout                                                                                                              | `10s`   |
| `additionalPlugins`                    | Additional RabbitMQ plugins to enable (Prometheus Metrics, PeerDiscoveryK8s and Management plugins are automatically added) | `[]`    |

### Persistence

| Parameter                   | Description                                                                    | Default             |
| --------------------------- | ------------------------------------------------------------------------------ | ------------------- |
| `persistence.enabled`       | Enable persistent storage                                                      | `true`              |
| `persistence.existingClaim` | Name of existing PVC to use (if empty, a new PVC will be created automatically) | `""`                |
| `persistence.storageClass`  | Storage class to use for persistent volume                                     | `""`                |
| `persistence.accessModes`   | Persistent Volume access modes                                                 | `["ReadWriteOnce"]` |
| `persistence.size`          | Size of persistent volume                                                      | `8Gi`               |
| `persistence.labels`        | Labels for persistent volume claims                                            | `{}`                |
| `persistence.annotations`   | Annotations for persistent volume claims                                       | `{}`                |

### Ingress configuration

| Parameter             | Description                            | Default                                                                        |
| --------------------- | -------------------------------------- | ------------------------------------------------------------------------------ |
| `ingress.enabled`     | Enable ingress for RabbitMQ management | `false`                                                                        |
| `ingress.className`   | Ingress class name                     | `""`                                                                           |
| `ingress.annotations` | Ingress annotations                    | `{}`                                                                           |
| `ingress.hosts`       | Ingress hosts configuration            | `[{"host": "rabbitmq.local", "paths": [{"path": "/", "pathType": "Prefix"}]}]` |
| `ingress.tls`         | Ingress TLS configuration              | `[]`                                                                           |

### Resources

| Parameter   | Description                                    | Default |
| ----------- | ---------------------------------------------- | ------- |
| `resources` | Resource limits and requests for RabbitMQ pods | `{}`    |

### Node Selection

| Parameter                   | Description                                    | Default |
| --------------------------- | ---------------------------------------------- | ------- |
| `nodeSelector`              | Node labels for pod assignment                 | `{}`    |
| `tolerations`               | Toleration labels for pod assignment           | `[]`    |
| `affinity`                  | Affinity settings for pod assignment           | `{}`    |
| `topologySpreadConstraints` | Topology spread constraints for pod assignment | `[]`    |

### Security Context

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `999`     |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the RabbitMQ container                | `999`     |
| `containerSecurityContext.runAsGroup`               | Group ID for the RabbitMQ container               | `999`     |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `true`    |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### Liveness and readiness probes

| Parameter                            | Description                                  | Default |
| ------------------------------------ | -------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on RabbitMQ containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe      | `120`   |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe             | `30`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe            | `20`    |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe          | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe          | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on RabbitMQ containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe     | `10`    |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe            | `30`    |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe           | `20`    |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe         | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe         | `1`     |

### Additional Configuration

| Parameter             | Description                                                             | Default        |
| --------------------- | ----------------------------------------------------------------------- | -------------- |
| `extraEnv`            | Additional environment variables to set                                 | `[]`           |
| `extraVolumes`        | Additional volumes to add to the pod                                    | `[]`           |
| `extraVolumeMounts`   | Additional volume mounts to add to the RabbitMQ container               | `[]`           |
| `extraObjects`        | A list of additional Kubernetes objects to deploy alongside the release | `[]`           |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |
| `podManagementPolicy` | A list of additional Kubernetes objects to deploy alongside the release | `OrderedReady` |

### Persistent Volume Claim Retention Policy

| Parameter                                          | Description                                             | Default  |
| -------------------------------------------------- | ------------------------------------------------------- | -------- |
| `persistentVolumeClaimRetentionPolicy.enabled`     | Enable Persistent volume retention policy               | `false`  |
| `persistentVolumeClaimRetentionPolicy.whenDeleted` | Volume retention behavior when replica is deleted       | `Retain` |
| `persistentVolumeClaimRetentionPolicy.whenScaled`  | Volume retention behavior when replica count is reduced | `Retain` |

### ServiceAccount

| Parameter                    | Description                       | Default |
| ---------------------------- | --------------------------------- | ------- |
| `serviceAccount.create`      | Enable creation of ServiceAccount | `true`  |
| `serviceAccount.name`        | Name of serviceAccount            | `""`    |
| `serviceAccount.annotations` | Annotations for service account   | `{}`    |

### RBAC parameters

| Parameter     | Description                          | Default |
| ------------- | ------------------------------------ | ------- |
| `rbac.create` | Whether RBAC rules should be created | `true`  |
| `rbac.rules`  | Custom RBAC rules                    | `[]`    |

### Pod Disruption Budget configuration

| Parameter            | Description                                                    | Default |
| -------------------- | -------------------------------------------------------------- | ------- |
| `pdb.create`         | Enable/disable a Pod Disruption Budget creation                | `false` |
| `pdb.minAvailable`   | Minimum number/percentage of pods that should remain scheduled | `""`    |
| `pdb.maxUnavailable` | Maximum number/percentage of pods that may be made unavailable | `""`    |

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

Deploy RabbitMQ with default configuration:

```bash
helm install my-rabbitmq ./charts/rabbitmq
```

### Production Setup with Persistence

```yaml
# values-production.yaml
persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 50Gi

resources:
  requests:
    memory: "2Gi"
    cpu: "500m"
  limits:
    memory: "4Gi"
    cpu: "2000m"

auth:
  enabled: true
  username: "admin"
  password: "your-secure-admin-password"

config:
  memoryHighWatermark:
    enabled: true
    type: "relative"
    value: 0.5

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: rabbitmq.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: rabbitmq-tls
      hosts:
        - rabbitmq.yourdomain.com
```

Deploy with production values:

```bash
helm install my-rabbitmq ./charts/rabbitmq -f values-production.yaml
```

### High Availability Cluster Setup

```yaml
# values-cluster.yaml
replicaCount: 3

peerDiscoveryK8sPlugin:
  enabled: true
  useLongname: true
  addressType: hostname

resources:
  requests:
    memory: "4Gi"
    cpu: "1000m"
  limits:
    memory: "8Gi"
    cpu: "4000m"

persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 100Gi

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
                  - rabbitmq
          topologyKey: kubernetes.io/hostname
```

### Using Existing Secret for Authentication

```yaml
# values-external-secret.yaml
auth:
  enabled: true
  existingSecret: "rabbitmq-credentials"
  existingPasswordKey: "password"
  existingErlangCookieKey: "erlang-cookie"
```

Create the secret first:

```bash
kubectl create secret generic rabbitmq-credentials \
  --from-literal=password=your-rabbitmq-password \
  --from-literal=erlang-cookie=your-erlang-cookie
```

### Enable Metrics and Monitoring

```yaml
# values-monitoring.yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    labels:
      prometheus: kube-prometheus
    interval: 15s
    scrapeTimeout: 10s

additionalPlugins:
  - rabbitmq_shovel
  - rabbitmq_federation
```

## Access RabbitMQ

### Via kubectl port-forward

```bash
kubectl port-forward service/my-rabbitmq 15672:15672
```

### Access Management UI

Open http://localhost:15672 in your browser and login with:

- **Username**: `admin` (or configured username)
- **Password**: Get from secret or configured value

### Connect using AMQP

```bash
kubectl port-forward service/my-rabbitmq 5672:5672
```

### Default Credentials

- **Admin User**: `admin`
- **Admin Password**: Auto-generated (check secret) or configured value
- **Management UI Port**: `15672`
- **AMQP Port**: `5672`

Get the auto-generated password:

```bash
kubectl get secret my-rabbitmq -o jsonpath="{.data.password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with permission errors**
   - Ensure your storage class supports the required access modes
   - Check if security contexts are compatible with your cluster policies
   - Verify the RabbitMQ data directory permissions

2. **Cannot connect to RabbitMQ**
   - Verify the service is running: `kubectl get svc`
   - Check if authentication is properly configured
   - Ensure firewall rules allow access to ports 5672 (AMQP) and 15672 (Management UI)
   - Check RabbitMQ logs: `kubectl logs <pod-name>`

3. **Clustering issues**
   - Verify all nodes can reach each other
   - Check Erlang cookie consistency across cluster nodes
   - Ensure proper DNS resolution for pod hostnames
   - Review peer discovery plugin configuration

4. **Memory-related issues**
   - Check configured memory high watermark settings
   - Monitor resource usage with `kubectl top pod`
   - Adjust memory limits and RabbitMQ memory configuration
   - Consider increasing resources
