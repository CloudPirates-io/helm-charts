<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-valkey"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-valkey" /></a>
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

### Valkey image configuration

| Parameter          | Description                                                                                            | Default         |
| ------------------ | ------------------------------------------------------------------------------------------------------ | --------------- |
| `image.registry`   | Valkey image registry                                                                                  | `docker.io`     |
| `image.repository` | Valkey image repository                                                                                | `valkey/valkey` |
| `image.tag`        | Valkey image tag (immutable tags are recommended)                                                      | `"8.0.1"`       |
| `image.digest`     | Valkey image digest in the way sha256:aa.... Please note this parameter, if set, will override the tag | `""`            |
| `image.pullPolicy` | Valkey image pull policy                                                                               | `IfNotPresent`  |

### Deployment configuration

| Parameter           | Description                                  | Default |
| ------------------- | -------------------------------------------- | ------- |
| `replicaCount`      | Number of Valkey replicas to deploy          | `1`     |
| `nameOverride`      | String to partially override valkey.fullname | `""`    |
| `fullnameOverride`  | String to fully override valkey.fullname     | `""`    |
| `commonLabels`      | Labels to add to all deployed objects        | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects   | `{}`    |

### Pod annotations and labels

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |

### Security Context

| Parameter                                  | Description                                       | Default   |
| ------------------------------------------ | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`               | Group ID for the volumes of the pod               | `1000`    |
| `securityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `securityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `securityContext.runAsUser`                | User ID for the Valkey container                  | `999`     |
| `securityContext.runAsGroup`               | Group ID for the Valkey container                 | `1000`    |
| `securityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `true`    |
| `securityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

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

### High Availability Configuration

```yaml
# values-ha.yaml
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

## Access Valkey

### Via kubectl port-forward

```bash
kubectl port-forward service/my-valkey 6379:6379
```

### Connect using valkey-cli

```bash
# Without authentication
valkey-cli -h localhost -p 6379

# With authentication
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

### Getting Support

For issues related to this Helm chart, please check:

- [Valkey Documentation](https://valkey.io/documentation/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- Chart repository issues
