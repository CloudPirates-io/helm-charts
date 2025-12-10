<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-mariadb/mariadb"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-mariadb" /></a>
</p>

# MariaDB

MariaDB is a high-performance, open-source relational database server that is a drop-in replacement for MySQL. This Helm chart deploys MariaDB as a StatefulSet on Kubernetes with comprehensive configuration options for development and production environments, providing stable network identities and persistent storage. 

The chart supports both single-node deployments and multi-node Galera cluster configurations for high availability and automatic failover.

## Installing the Chart

To install the chart with the release name `my-mariadb`:

```bash
helm install my-mariadb oci://registry-1.docker.io/cloudpirates/mariadb
```

To install with custom values:

```bash
helm install my-mariadb oci://registry-1.docker.io/cloudpirates/mariadb -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-valkey ./charts/valkey
```

## Uninstalling the Chart

To uninstall/delete the `my-mariadb` deployment:

```bash
helm uninstall my-mariadb
```

This removes all the Kubernetes components associated with the chart and deletes the release.

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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/mariadb:<version>
```

## StatefulSet Features

This chart deploys MariaDB as a StatefulSet, which provides several advantages for stateful workloads:

- **Stable Network Identities**: Each pod gets a predictable hostname (e.g., `mariadb-0`, `mariadb-1`)
- **Ordered Deployment**: Pods are created, updated, and terminated in order
- **Persistent Storage**: Each pod gets its own persistent volume that persists across restarts
- **Headless Service Support**: Can be configured with a headless service for direct pod communication

### Persistent Storage

The StatefulSet uses `volumeClaimTemplates` to automatically create persistent volumes for each pod instance. This means:

- Each pod gets its own dedicated storage
- Storage persists even if the pod is rescheduled
- No separate PVC needs to be created manually

### Headless Service Configuration

To enable headless service (useful for database clustering), set:

```yaml
service:
  clusterIP: "None"
```

## Configuration

The following table lists the configurable parameters of the MariaDB chart and their default values.

### Global Parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common Parameters

| Parameter           | Description                                   | Default |
| ------------------- | --------------------------------------------- | ------- |
| `nameOverride`      | String to partially override mariadb.fullname | `""`    |
| `fullnameOverride`  | String to fully override mariadb.fullname     | `""`    |
| `commonLabels`      | Labels to add to all deployed objects         | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects    | `{}`    |

### MariaDB Image Parameters

| Parameter          | Description                                        | Default                                                                            |
| ------------------ | -------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `image.registry`   | MariaDB image registry                             | `docker.io`                                                                        |
| `image.repository` | MariaDB image repository                           | `mariadb`                                                                          |
| `image.tag`        | MariaDB image tag (immutable tags are recommended) | `"12.1.2@sha256:e1bcd6f85781f4a875abefb11c4166c1d79e4237c23de597bf0df81fec225b40"` |
| `image.pullPolicy` | MariaDB image pull policy                          | `IfNotPresent`                                                                     |


### MariaDB Authentication Parameters

| Parameter                          | Description                                             | Default                 |
| ---------------------------------- | ------------------------------------------------------- | ----------------------- |
| `auth.enabled`                     | MariaDB authentication enabled or disabled              | `"true"`                |
| `auth.rootPassword`                | MariaDB root password                                   | `""`                    |
| `auth.database`                    | MariaDB custom database                                 | `""`                    |
| `auth.username`                    | MariaDB custom user name                                | `""`                    |
| `auth.password`                    | MariaDB custom user password                            | `""`                    |
| `auth.existingSecret`              | Name of existing secret to use for MariaDB credentials  | `""`                    |
| `auth.auth.allowEmptyRootPassword` | Allow the root user of MariaDB to have no password set  | `""`                    |
| `auth.secretKeys.rootPasswordKey`  | Name of key in existing secret to use for root password | `mariadb-root-password` |
| `auth.secretKeys.userPasswordKey`  | Name of key in existing secret to use for user password | `mariadb-password`      |

### MariaDB Configuration Parameters

| Parameter                    | Description                                           | Default |
| ---------------------------- | ----------------------------------------------------- | ------- |
| `config.customConfiguration` | Custom configuration for MariaDB                      | `""`    |
| `config.existingConfigMap`   | Name of existing ConfigMap with MariaDB configuration | `""`    |

### Galera Cluster Parameters

For a detailed explanation of Galera parameters and usage, see [README_GALERA.md](README_GALERA.md).

> [!WARNING]  
> You must migrate from a standalone MariaDB to Galera carefully. Do not enable Galera on an existing standalone database without following proper migration steps.

| Parameter                           | Description                                                         | Default                            |
| ----------------------------------- | ------------------------------------------------------------------- | ---------------------------------- |
| `galera.enabled`                    | Enable Galera Cluster mode                                          | `false`                            |
| `galera.name`                       | Galera cluster name                                                 | `"galera"`                         |
| `galera.bootstrap.enabled`          | Enable bootstrap mode for the first node in the cluster             | `true`                             |
| `galera.replicaCount`               | Number of nodes in the Galera cluster                               | `3`                                |
| `galera.wsrepProvider`              | Path to wsrep provider library                                      | `/usr/lib/galera/libgalera_smm.so` |
| `galera.wsrepMethod`                | Method for state snapshot transfers (mariabackup, mysqldump, rsync) | `mariabackup`                      |
| `galera.forceSafeToBootstrap`       | Force safe_to_bootstrap=1 in grastate.dat                           | `false`                            |
| `galera.wsrepSlaveThreads`          | Number of slave threads for applying writesets                      | `1`                                |
| `galera.wsrepCertifyNonPK`          | Require primary key for replication                                 | `true`                             |
| `galera.wsrepMaxWsRows`             | Maximum number of rows in writeset                                  | `0`                                |
| `galera.wsrepMaxWsSize`             | Maximum size of writeset in bytes                                   | `1073741824`                       |
| `galera.wsrepDebug`                 | Enable wsrep debugging                                              | `false`                            |
| `galera.wsrepRetryAutocommit`       | Number of times to retry autocommit                                 | `1`                                |
| `galera.wsrepAutoIncrementControl`  | Enable auto increment control                                       | `true`                             |
| `galera.wsrepDrupalHack`            | Enable Drupal compatibility hack                                    | `false`                            |
| `galera.wsrepLogConflicts`          | Log conflicts to error log                                          | `false`                            |
| `galera.innodb.flushLogAtTrxCommit` | InnoDB flush log at transaction commit                              | `0`                                |
| `galera.innodb.bufferPoolSize`      | InnoDB buffer pool size                                             | `"128M"`                           |
| `galera.sst.user`                   | SST user for authentication                                         | `"sstuser"`                        |
| `galera.sst.password`               | SST password for authentication                                     | `""`                               |
| `galera.sst.existingSecret`         | Existing secret containing SST credentials                          | `""`                               |
| `galera.sst.secretKeys.userKey`     | Secret key for SST user                                             | `sst-user`                         |
| `galera.sst.secretKeys.passwordKey` | Secret key for SST password                                         | `sst-password`                     |
| `galera.recovery.enabled`           | Enable automatic recovery                                           | `true`                             |
| `galera.recovery.clusterBootstrap`  | Enable cluster bootstrap in recovery                                | `true`                             |

### Service Parameters

| Parameter             | Description                                       | Default     |
| --------------------- | ------------------------------------------------- | ----------- |
| `service.type`        | MariaDB service type                              | `ClusterIP` |
| `service.port`        | MariaDB service port                              | `3306`      |
| `service.nodePort`    | Node port for MariaDB service                     | `""`        |
| `service.clusterIP`   | Static cluster IP or "None" for headless service  | `""`        |
| `service.annotations` | Additional custom annotations for MariaDB service | `{}`        |

### Persistence Parameters

| Parameter                  | Description                                 | Default             |
| -------------------------- | ------------------------------------------- | ------------------- |
| `persistence.enabled`      | Enable MariaDB data persistence using PVC   | `true`              |
| `persistence.storageClass` | PVC Storage Class for MariaDB data volume   | `""`                |
| `persistence.accessModes`  | PVC Access modes                            | `["ReadWriteOnce"]` |
| `persistence.size`         | PVC Storage Request for MariaDB data volume | `8Gi`               |
| `persistence.annotations`  | Additional custom annotations for the PVC   | `{}`                |
| `persistence.labels`       | Labels for persistent volume claims         | `{}`                |
| `persistence.selector`     | Additional labels for the PVC               | `{}`                |

### Security Context Parameters

| Parameter                                           | Description                                                     | Default |
| --------------------------------------------------- | --------------------------------------------------------------- | ------- |
| `podSecurityContext.fsGroup`                        | Set MariaDB pod's Security Context fsGroup                      | `999`   |
| `containerSecurityContext.runAsUser`                | Set MariaDB container's Security Context runAsUser              | `999`   |
| `containerSecurityContext.runAsNonRoot`             | Set MariaDB container's Security Context runAsNonRoot           | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Set MariaDB container's privilege escalation                    | `false` |
| `containerSecurityContext.readOnlyRootFilesystem`   | Set MariaDB container's Security Context readOnlyRootFilesystem | `false` |

### Resources Parameters

| Parameter            | Description                                        | Default |
| -------------------- | -------------------------------------------------- | ------- |
| `resources.limits`   | The resources limits for the MariaDB containers    | `{}`    |
| `resources.requests` | The requested resources for the MariaDB containers | `{}`    |

### Service Account

| Parameter                                     | Description                                                                                                               | Default |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a service account should be created                                                                     | `false` |
| `serviceAccount.annotations`                  | Annotations to add to the service account                                                                                 | `{}`    |
| `serviceAccount.name`                         | The name of the service account to use. If not set and create is true, a name is generated using the `fullname` template. | `""`    |
| `serviceAccount.automountServiceAccountToken` | Whether to automount the SA token inside the pod                                                                          | `false` |

### Extra Configuration Parameters

| Parameter      | Description                                                                      | Default |
| -------------- | -------------------------------------------------------------------------------- | ------- |
| `extraEnvVars` | Additional environment variables to set                                          | `[]`    |
| `extraSecrets` | A list of additional existing secrets that will be mounted into the container    | `[]`    |
| `extraConfigs` | A list of additional existing configMaps that will be mounted into the container | `[]`    |
| `extraVolumes` | A list of additional existing volumes that will be mounted into the container    | `[]`    |
| `extraObjects` | A list of additional Kubernetes objects to deploy alongside the release          | `[]`    |

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

### Health Check Parameters

| Parameter                            | Description                                 | Default |
| ------------------------------------ | ------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on MariaDB containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe     | `30`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe            | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe           | `1`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe         | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe         | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on MariaDB containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe    | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe           | `10`    |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe          | `1`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe        | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe        | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on MariaDB containers   | `false` |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe      | `30`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe             | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe            | `1`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe          | `15`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe          | `1`     |

### Pod Disruption Budget Parameters

| Parameter                            | Description                                                        | Default |
| ------------------------------------ | ------------------------------------------------------------------ | ------- |
| `podDisruptionBudget.enabled`        | Enable a Pod Disruption Budget creation                            | `false` |
| `podDisruptionBudget.minAvailable`   | Min number of pods that must still be available after the eviction | `1`     |
| `podDisruptionBudget.maxUnavailable` | Max number of pods that can be unavailable after the eviction      | `""`    |

### Ingress Parameters

| Parameter             | Description                                                                   | Default                                                                       |
| --------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `ingress.enabled`     | Enable ingress record generation for MariaDB                                  | `false`                                                                       |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+) | `""`                                                                          |
| `ingress.annotations` | Additional annotations for the Ingress resource                               | `{}`                                                                          |
| `ingress.hosts`       | An array with hosts and paths                                                 | `[{"host": "mariadb.local", "paths": [{"path": "/", "pathType": "Prefix"}]}]` |
| `ingress.tls`         | TLS configuration for the Ingress                                             | `[]`                                                                          |

### Network Policy Parameters

| Parameter                               | Description                                                | Default |
| --------------------------------------- | ---------------------------------------------------------- | ------- |
| `networkPolicy.enabled`                 | Specifies whether a NetworkPolicy should be created        | `false` |
| `networkPolicy.allowExternal`           | Don't require client label for connections                 | `true`  |
| `networkPolicy.ingressNSMatchLabels`    | Labels to match to allow traffic from other namespaces     | `{}`    |
| `networkPolicy.ingressNSPodMatchLabels` | Pod labels to match to allow traffic from other namespaces | `{}`    |

### Pod Configuration Parameters

| Parameter        | Description                    | Default |
| ---------------- | ------------------------------ | ------- |
| `podAnnotations` | Additional pod annotations     | `{}`    |
| `podLabels`      | Additional pod labels          | `{}`    |
| `nodeSelector`   | Node labels for pod assignment | `{}`    |
| `tolerations`    | Tolerations for pod assignment | `[]`    |
| `affinity`       | Affinity for pod assignment    | `{}`    |

### Metrics

| Parameter                          | Description                                                 | Default                                         |
| ---------------------------------- | ----------------------------------------------------------- | ----------------------------------------------- |
| `metrics.enabled`                  | Enable metrics exporter sidecar                             | `false`                                         |
| `metrics.image.registry`           | Metrics exporter image registry                             | `docker.io`                                     |
| `metrics.image.repository`         | Metrics exporter image repository                           | `prom/mysqld-exporter`                          |
| `metrics.image.tag`                | Metrics exporter image tag (immutable tags are recommended) | `v0.18.0@sha256:[...]`                          |
| `metrics.image.pullPolicy`         | Metrics exporter image pull policy                          | `Always`                                        |
| `metrics.port`                     | Metrics exporter port                                       | `9104`                                          |
| `metrics.containerSecurityContext` | Security context for metrics container                      | `{runAsUser: 65534, runAsNonRoot: true, ...}`   |
| `metrics.resources`                | Resource limits and requests for metrics container          | `{}`                                            |
| `metrics.extraEnvVars`             | Additional environment variables for metrics exporter       | `[]`                                            |
| `metrics.livenessProbe`            | LivenessProbe for metrics container                         | `{enabled: true, initialDelaySeconds: 30, ...}` |
| `metrics.readinessProbe`           | ReadinessProbe for metrics container                        | `{enabled: true, initialDelaySeconds: 30, ...}` |

## Examples

### Basic Installation

Create a `values.yaml` file:

```yaml
auth:
  rootPassword: "mySecurePassword"
  database: "mydatabase"
  username: "myuser"
  password: "myUserPassword"

persistence:
  size: 10Gi
```

Install the chart:

```bash
helm install my-mariadb charts/mariadb -f values.yaml
```

### Production Setup

```yaml
auth:
  rootPassword: "verySecureRootPassword"
  database: "production_db"
  username: "app_user"
  password: "secureUserPassword"

persistence:
  enabled: true
  storageClass: "default"
  size: 100Gi

resources:
  limits:
    memory: 4Gi
  requests:
    cpu: 1000m
    memory: 4Gi

podDisruptionBudget:
  enabled: true
  minAvailable: 1

# Optional: Enable headless service for clustering
service:
  clusterIP: "None"
```

### Using Existing Secrets

```yaml
auth:
  existingSecret: "my-mariadb-secret"
  secretKeys:
    rootPasswordKey: "root-password"
    userPasswordKey: "user-password"
```

### Custom Configuration

```yaml
config:
  customConfiguration: |
    [mysqld]
    max_connections = 500
    innodb_buffer_pool_size = 1G
    query_cache_size = 128M
    slow_query_log = 1
    long_query_time = 2
```

### Extra Configuration Options

```yaml
# Additional environment variables
extraEnvVars:
  - name: MYSQL_INIT_ONLY
    value: "0"
  - name: MARIADB_AUTO_UPGRADE
    value: "1"

# Mount additional secrets
extraSecrets:
  - name: ssl-certs
    defaultMode: 0440
    mountPath: /etc/ssl/certs

# Mount additional config maps
extraConfigs:
  - name: custom-scripts
    defaultMode: 0755
    mountPath: /docker-entrypoint-initdb.d

# Mount additional volumes
extraVolumes:
  - name: backup-storage
    mountPath: /backup
    pvcName: mariadb-backup-pvc
```

## Troubleshooting

### Connection Issues

1. **Check StatefulSet and service status**:

   ```bash
   kubectl get statefulset -l app.kubernetes.io/name=mariadb
   kubectl get svc -l app.kubernetes.io/name=mariadb
   kubectl get pods -l app.kubernetes.io/name=mariadb
   ```

2. **Test connection from within cluster**:

   ```bash
   kubectl run mariadb-client --rm --tty -i --restart='Never' --image docker.io/mariadb:11.8.2 -- bash
   mysql -h <service-name> -u root -p
   ```

3. **Connect to specific pod (for headless service)**:
   ```bash
   kubectl run mariadb-client --rm --tty -i --restart='Never' --image docker.io/mariadb:11.8.2 -- bash
   mysql -h mariadb-0.<service-name> -u root -p
   ```

### Password Issues

1. **Reset root password** (if using default secret):
   ```bash
   kubectl delete secret <release-name>-mariadb
   # Update values.yaml with new password and upgrade
   helm upgrade <release-name> charts/mariadb -f values.yaml
   ```

### Storage Issues

1. **Check PVC status (StatefulSet creates PVCs automatically)**:

   ```bash
   kubectl get pvc -l app.kubernetes.io/name=mariadb
   # For StatefulSets, PVCs are named: data-<statefulset-name>-<pod-index>
   kubectl get pvc data-mariadb-0
   ```

2. **Check available storage classes**:

   ```bash
   kubectl get storageclass
   ```

3. **StatefulSet scaling considerations**:
   ```bash
   # Scaling down a StatefulSet does not delete PVCs automatically
   kubectl get pvc
   # You may need to manually clean up PVCs when scaling down
   ```

### Performance Tuning

For production workloads, consider:

- Setting appropriate resource limits based on your workload
- Configuring MariaDB parameters via `config.customConfiguration`
- Using fast storage classes (SSD-based)
- Enabling metrics for monitoring

## Links

- [MariaDB Official Documentation](https://mariadb.org/documentation/)
- [MariaDB Docker Hub](https://hub.docker.com/_/mariadb)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)