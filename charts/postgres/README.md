![Version: 0.15.0](https://img.shields.io/badge/Version-0.15.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 18.1.0](https://img.shields.io/badge/AppVersion-18.1.0-informational?style=flat-square)
<a href="https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-postgres" /></a>

# PostgreSQL

The World's Most Advanced Open Source Relational Database

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/cloudpirates | common | 2.x.x |

## Installing the Chart

To install the chart with the release name `my-postgres`:

```bash
helm install my-postgres oci://registry-1.docker.io/cloudpirates/postgres
```

To install with custom values:

```bash
helm install my-postgres oci://registry-1.docker.io/cloudpirates/postgres -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-postgres ./charts/postgres
```

The command deploys PostgreSQL on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-postgres` deployment:

```bash
helm uninstall my-postgres
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/postgres:<version>
```

## Configuration

The following table lists the configurable parameters of the PostgreSQL chart and their default values.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity settings for pod assignment |
| args | string | `nil` | Override default container args (useful for hardened images that handle startup differently) # Leave unset or null to use default args, set to empty array [] to disable default args for hardened images like DHI |
| auth.database | string | `""` | Alternative name for the default database to be created at initialisation |
| auth.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| auth.password | string | `""` | Password for the custom user to create |
| auth.secretKeys.adminPasswordKey | string | `"postgres-password"` | Name of key in existing secret to use for PostgreSQL admin credentials |
| auth.username | string | `""` | Name for a custom superuser to create at initialisation. (This will also create a database with the same name) |
| command | list | `[]` | Override default container command (useful for hardened images) |
| commonAnnotations | object | `{}` | Annotations to add to all deployed objects |
| commonLabels | object | `{}` | Labels to add to all deployed objects |
| config.existingConfigmap | string | `""` | Name of existing ConfigMap with PostgreSQL configuration |
| config.extraConfig | list | `[]` | Additional PostgreSQL configuration parameters |
| config.mountConfigMap | bool | `true` | Enable mounting of ConfigMap with PostgreSQL configuration |
| config.pgHbaConfig | string | `""` | Content of a custom pg_hba.conf file to be used instead of the default config |
| config.postgresql.locale | string | `"en_US.utf8"` | Default locale setting |
| config.postgresql.timezone | string | `"UTC"` | Default timezone setting |
| config.postgresqlCheckpointCompletionTarget | string | `""` | Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval |
| config.postgresqlEffectiveCacheSize | string | `""` | Effective cache size |
| config.postgresqlLogMinDurationStatement | string | `""` | Sets the minimum execution time above which statements will be logged |
| config.postgresqlLogStatement | string | `""` | Sets the type of statements logged |
| config.postgresqlMaintenanceWorkMem | string | `""` | Maximum amount of memory to be used by maintenance operations |
| config.postgresqlMaxConnections | int | `100` | Maximum number of connections |
| config.postgresqlRandomPageCost | string | `""` | Sets the planner's estimate of the cost of a non-sequentially-fetched disk page |
| config.postgresqlSharedBuffers | string | `""` | Amount of memory the database server uses for shared memory buffers |
| config.postgresqlSharedPreloadLibraries | string | `""` | Shared preload libraries (comma-separated list) |
| config.postgresqlWalBuffers | string | `""` | Amount of memory used in shared memory for WAL data (deprecated, see postgresql.wal.buffers) |
| config.postgresqlWorkMem | string | `""` | Amount of memory to be used by internal sort operations and hash tables |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` | Enable container privilege escalation |
| containerSecurityContext.capabilities | object | `{"drop":["ALL"]}` | Linux capabilities to be dropped |
| containerSecurityContext.readOnlyRootFilesystem | bool | `false` | Mount container root filesystem as read-only |
| containerSecurityContext.runAsGroup | int | `999` | Group ID for the PostgreSQL container |
| containerSecurityContext.runAsNonRoot | bool | `true` | Configure the container to run as a non-root user |
| containerSecurityContext.runAsUser | int | `999` | User ID for the PostgreSQL container |
| customUser.database | string | `""` | Name of the database to be created |
| customUser.existingSecret | string | `""` | Existing secret, in which username, password and database name are saved |
| customUser.name | string | `""` | Name of the custom user to be created |
| customUser.password | string | `""` | Password to be used for the custom user |
| customUser.secretKeys.database | string | `"CUSTOM_DB"` | Custom user database secret reference (set empty to fallback to customUser.database) |
| customUser.secretKeys.name | string | `"CUSTOM_USER"` | Custom user name secret reference (set empty to fallback to customUser.name) |
| customUser.secretKeys.password | string | `"CUSTOM_PASSWORD"` |  |
| extraEnvVars | list | `[]` | Additional environment variables to set |
| extraEnvVarsSecret | string | `""` | Name of a secret containing additional environment variables |
| extraObjects | list | `[]` | Array of extra objects to deploy with the release |
| extraVolumeMounts | list | `[]` | Additional volume mounts to add to the MongoDB container |
| extraVolumes | list | `[]` | Additional volumes to add to the pod |
| fullnameOverride | string | `""` | String to fully override postgres.fullname |
| global.enableServiceLinks | bool | `true` | Whether to add service links env variables to pods |
| global.imagePullSecrets | list | `[]` | Global Docker registry secret names as an array |
| global.imageRegistry | string | `""` | Global Docker Image registry |
| image.imagePullPolicy | string | `"Always"` | PostgreSQL image pull policy |
| image.registry | string | `"docker.io"` | PostgreSQL image registry |
| image.repository | string | `"postgres"` | PostgreSQL image repository |
| image.tag | string | `"18.1@sha256:5773fe724c49c42a7a9ca70202e11e1dff21fb7235b335a73f39297d200b73a2"` | PostgreSQL image tag (immutable tags are recommended) |
| image.useHardenedImage | bool | `false` | Set to true when using hardened images (e.g., DHI) that have different PGDATA paths for Postgres <18 |
| ingress.annotations | object | `{}` | Additional annotations for the Ingress resource |
| ingress.className | string | `""` | IngressClass that will be used to implement the Ingress |
| ingress.enabled | bool | `false` | Enable ingress record generation for PostgreSQL |
| ingress.hosts[0].host | string | `"postgres.local"` | Hostname |
| ingress.hosts[0].paths[0].path | string | `"/"` | Base path |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` | Path type |
| ingress.tls | list | `[]` | TLS configuration for PostgreSQL ingress |
| initContainers | list | `[]` | Init containers to add to the PostgreSQL pods. Useful for tasks like pgautoupgrade for major version upgrades |
| initdb.args | string | `""` | Send arguments to postgres initdb. This is a space separated string of arguments |
| initdb.directory | string | `"/docker-entrypoint-initdb.d/"` | Directory where to load initScripts |
| initdb.scripts | object | `{}` | Dictionary of initdb scripts |
| initdb.scriptsConfigMap | string | `""` | ConfigMap with scripts to be run at first boot |
| livenessProbe.enabled | bool | `true` | Enable livenessProbe on PostgreSQL containers |
| livenessProbe.failureThreshold | int | `3` | Failure threshold for livenessProbe |
| livenessProbe.initialDelaySeconds | int | `30` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `10` | Period seconds for livenessProbe |
| livenessProbe.successThreshold | int | `1` | Success threshold for livenessProbe |
| livenessProbe.timeoutSeconds | int | `5` | Timeout seconds for livenessProbe |
| metrics.enabled | bool | `false` | Start a sidecar prometheus exporter to expose PostgreSQL metrics |
| metrics.image.pullPolicy | string | `"Always"` | PostgreSQL exporter image pull policy |
| metrics.image.registry | string | `"quay.io"` | PostgreSQL exporter image registry |
| metrics.image.repository | string | `"prometheuscommunity/postgres-exporter"` | PostgreSQL exporter image repository |
| metrics.image.tag | string | `"v0.18.1@sha256:fb96c4413985d4b23ab02b19022b3d70a86c8e0a62f41ab15ebb6f4673781a5d"` | PostgreSQL exporter image tag |
| metrics.resources | object | `{}` | Resource limits and requests for metrics container |
| metrics.service.annotations | object | `{}` | Additional custom annotations for Metrics service |
| metrics.service.labels | object | `{}` | Additional custom labels for Metrics service |
| metrics.service.port | int | `9187` | Metrics service port |
| metrics.serviceMonitor.annotations | object | `{}` | ServiceMonitor annotations |
| metrics.serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator |
| metrics.serviceMonitor.honorLabels | bool | `false` | honorLabels chooses the metric's labels on collisions with target labels |
| metrics.serviceMonitor.interval | string | `"30s"` | The interval at which metrics should be scraped |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | ServiceMonitor metricRelabelings configs to apply to samples before ingestion |
| metrics.serviceMonitor.namespace | string | `""` | The namespace in which the ServiceMonitor will be created |
| metrics.serviceMonitor.namespaceSelector | object | `{}` | ServiceMonitor namespace selector |
| metrics.serviceMonitor.relabelings | list | `[]` | ServiceMonitor relabel configs to apply to samples before scraping |
| metrics.serviceMonitor.scrapeTimeout | string | `"10s"` | The timeout after which the scrape is ended |
| metrics.serviceMonitor.selector | object | `{}` | Additional labels for ServiceMonitor resource |
| nameOverride | string | `""` | String to partially override postgres.fullname |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| persistence.accessModes | list | `["ReadWriteOnce"]` | Persistent Volume access modes |
| persistence.annotations | object | `{}` | Persistent Volume Claim annotations |
| persistence.enabled | bool | `true` | Enable persistence using Persistent Volume Claims |
| persistence.existingClaim | string | `""` | The name of an existing PVC to use for persistence |
| persistence.labels | object | `{}` | Labels for persistent volume claims |
| persistence.size | string | `"8Gi"` | Persistent Volume size |
| persistence.storageClass | string | `""` | Persistent Volume storage class |
| persistence.subPath | string | `""` | The subdirectory of the volume to mount to # Useful in dev environments and one PV for multiple services |
| persistence.volumeName | string | `"data"` | Container volume name and volume claim prefix |
| persistentVolumeClaimRetentionPolicy.enabled | bool | `false` | Enable Persistent volume retention policy for the Statefulset |
| persistentVolumeClaimRetentionPolicy.whenDeleted | string | `"Retain"` | Volume retention behavior that applies when the StatefulSet is deleted |
| persistentVolumeClaimRetentionPolicy.whenScaled | string | `"Retain"` | Volume retention behavior when the replica count of the StatefulSet is reduced |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| podLabels | object | `{}` | Map of labels to add to the pods |
| podSecurityContext.fsGroup | int | `999` | Group ID for the volumes of the pod |
| priorityClassName | string | `""` | Priority class name to be used for the pods |
| readinessProbe.enabled | bool | `true` | Enable readinessProbe on PostgreSQL containers |
| readinessProbe.failureThreshold | int | `3` | Failure threshold for readinessProbe |
| readinessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `5` | Period seconds for readinessProbe |
| readinessProbe.successThreshold | int | `1` | Success threshold for readinessProbe |
| readinessProbe.timeoutSeconds | int | `5` | Timeout seconds for readinessProbe |
| replicaCount | int | `1` | Number of PostgreSQL replicas to deploy (Note: PostgreSQL doesn't support multi-master replication by default) |
| replication.allowFrom.ipv4 | string | `"0.0.0.0/0"` | Allowed IPv4 network (set empty to disable that feature) |
| replication.allowFrom.ipv6 | string | `"::/0"` | Allowed IPv6 network (set empty to disable that feature) |
| replication.auth.existingSecret | string | `""` | Use existing secret reference instead of password |
| replication.auth.password | string | `""` | Password for replication user (cannot be empty) |
| replication.auth.secretKeys.password | string | `"replication-password"` | Secret key for replication password |
| replication.auth.username | string | `"replication"` | Username for replication user |
| replication.enabled | bool | `false` | Enables the WAL replication feature for both sides (primary and standby) |
| replication.primary.host | string | `""` | Hostname of the primary server |
| replication.primary.port | int | `5432` | Port of the primary server |
| resources | object | `{}` |  |
| service.annotations | object | `{}` | Service annotations |
| service.nodePort | int | `30432` | PostgreSQL NodePort port |
| service.port | int | `5432` | PostgreSQL service port |
| service.targetPort | int | `5432` | PostgreSQL container port |
| service.type | string | `"ClusterIP"` | PostgreSQL service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automountServiceAccountToken | bool | `false` | Whether to automount the SA token inside the pod |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the `fullname` template. |
| startupProbe.enabled | bool | `true` | Enable startupProbe on PostgreSQL containers |
| startupProbe.failureThreshold | int | `30` | Failure threshold for startupProbe |
| startupProbe.initialDelaySeconds | int | `30` | Initial delay seconds for startupProbe |
| startupProbe.periodSeconds | int | `10` | Period seconds for startupProbe |
| startupProbe.successThreshold | int | `1` | Success threshold for startupProbe |
| startupProbe.timeoutSeconds | int | `5` | Timeout seconds for startupProbe |
| terminationGracePeriodSeconds | int | `30` | Time for Kubernetes to wait for the pod to gracefully terminate |
| tolerations | list | `[]` | Toleration labels for pod assignment |

## Examples

### Extra Objects

You can use the `extraObjects` array to deploy additional Kubernetes resources (such as NetworkPolicies, ConfigMaps, etc.) alongside the release. This is useful for customizing your deployment with extra manifests that are not covered by the default chart options.

**Helm templating is supported in any field, but all template expressions must be quoted.** For example, to use the release namespace, write `namespace: "{{  .Release.Namespace }}"`.

**Example: Deploy a NetworkPolicy with templating**

```yaml
extraObjects:
  - apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-dns
      namespace: "{{  .Release.Namespace }}"
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

### Basic Deployment

Deploy PostgreSQL with default configuration:

```bash
helm install my-postgres ./charts/postgres
```

### Production Setup with Persistence and custom user

```yaml
# values-production.yaml
persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 100Gi

resources:
  requests:
    memory: "1Gi"
    cpu: "500m"
  limits:
    memory: "2Gi"
    cpu: "1000m"

auth:
  username: "myapp"
  password: "your-secure-app-password"

config:
  postgresqlMaxConnections: 200
  postgresqlSharedBuffers: "256MB"
  postgresqlEffectiveCacheSize: "1GB"
  postgresqlWorkMem: "8MB"
  postgresqlMaintenanceWorkMem: "128MB"

customUser:
  existingSecret: "postgres-custom-user"
  secretKeys:
    name: "username"
    password: "password"
    database: "mydatabase"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: postgres.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: postgres-tls
      hosts:
        - postgres.yourdomain.com
```

Deploy with production values:

```bash
helm install my-postgres ./charts/postgres -f values-production.yaml
```

### High Performance Configuration

```yaml
# values-performance.yaml
resources:
  requests:
    memory: "4Gi"
    cpu: "2000m"
  limits:
    memory: "8Gi"
    cpu: "4000m"

config:
  postgresqlMaxConnections: 500
  postgresqlSharedBuffers: "2GB"
  postgresqlEffectiveCacheSize: "6GB"
  postgresqlWorkMem: "16MB"
  postgresqlMaintenanceWorkMem: "512MB"
  postgresqlWalBuffers: "32MB"
  postgresqlCheckpointCompletionTarget: "0.9"
  postgresqlRandomPageCost: "1.0"
  extraConfig:
    - "wal_level = replica"
    - "max_wal_senders = 3"
    - "archive_mode = on"
    - "archive_command = 'test ! -f /backup/%f && cp %p /backup/%f'"

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
                  - postgres
          topologyKey: kubernetes.io/hostname
```

### Using Existing Secret for Authentication

```yaml
# values-external-secret.yaml
auth:
  existingSecret: "postgres-credentials"
  secretKeys:
    adminPasswordKey: "postgres-password"

# For custom users, use the customUser section
customUser:
  existingSecret: "postgres-custom-user"
  secretKeys:
    name: "username"  # Set empty for fallback to customUser.name
    database: "database"  # Set empty for fallback to customUser.database
    password: "password"
```

Create the secrets first:

```bash
# Admin/superuser credentials
kubectl create secret generic postgres-credentials \
  --from-literal=postgres-password=your-admin-password

# Custom user credentials (optional)
kubectl create secret generic postgres-custom-user \
  --from-literal=username=myuser \
  --from-literal=password=myuserpassword \
  --from-literal=database=mydb
```

### Custom Configuration with ConfigMap

```yaml
# values-custom-config.yaml
config:
  existingConfigmap: "postgres-custom-config"
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

The PostgreSQL exporter will expose metrics on port 9187, and if you have Prometheus Operator installed, the ServiceMonitor will automatically configure Prometheus to scrape the metrics.

You can access metrics directly via port-forward:

```bash
kubectl port-forward service/my-postgres-metrics 9187:9187
curl http://localhost:9187/metrics
```

### Replication setup

Replication setup only works for instances without an initialized database and `$PGDATA` directory.

#### Primary setup

This will create a replication user as init script. If you want to set up replication for an already initialized database, you need to create this user afterwards on your own.

```yaml
replication:
  enabled: true
  auth:
    password: "secret"
```

#### Standby setup

As soon as a primary host is configured, this instance is considered to be a standby server.

This will also create an `initContainer` name `replication-standby-init`, which:
- Creates/updates the `replication.pgpass` credentials file in the transient run directory
- Initializes the database using `pg_basebackup` if not already done using the credentials file above

```yaml
replication:
  enabled: true
  auth:
    password: "secret"  # Password must match primary
  primary:
    host: "your-database.namespace.svc.cluster.local"
```

### Using Hardened Images

When using hardened PostgreSQL images (such as from DHI or other security-focused registries), you need to configure several settings:

```yaml
# values-hardened-image.yaml
image:
  registry: dhi.io
  repository: postgres
  tag: "18.1"
  imagePullPolicy: IfNotPresent
  # Enable hardened image mode for correct PGDATA paths (required for Postgres <18)
  useHardenedImage: true

# Disable default args for hardened images
args: []

# Adjust security context to match hardened image requirements
podSecurityContext:
  fsGroup: 70

containerSecurityContext:
  runAsUser: 70
  runAsGroup: 70
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: false
  capabilities:
    drop:
      - ALL
```

**Important Notes:**

1. **PGDATA Paths:** The `image.useHardenedImage` parameter is particularly important for PostgreSQL versions below 18, as hardened images use different PGDATA paths (`/var/lib/postgresql/<version>/data`) compared to standard images (`/var/lib/postgresql/data/pgdata`). For PostgreSQL 18+, both image types use the same path structure.

2. **Persistent Storage:** When using hardened images with persistent storage, you **must** add an initContainer to fix directory permissions. Hardened images enforce strict permission checks (0700 or 0750) and will fail to start if the Kubernetes-managed volumes have incorrect permissions (typically 2770 with setgid bit).

```yaml
# values-hardened-image-with-persistence.yaml
image:
  registry: dhi.io
  repository: postgres
  tag: "17.7"
  imagePullPolicy: IfNotPresent
  useHardenedImage: true

args: []

podSecurityContext:
  fsGroup: 70

containerSecurityContext:
  runAsUser: 70
  runAsGroup: 70
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: false
  capabilities:
    drop:
      - ALL

# Enable persistence
persistence:
  enabled: true
  size: 10Gi

# REQUIRED: Init container to fix permissions for hardened images with persistence
initContainers:
  - name: fix-permissions
    image: busybox:1.36
    command:
      - sh
      - -c
      - |
        chown -R 70:70 /var/lib/postgresql
        find /var/lib/postgresql -type d -exec chmod 750 {} \;
    securityContext:
      runAsUser: 0
      runAsNonRoot: false
    volumeMounts:
      - name: data
        mountPath: /var/lib/postgresql
```

**Why is the initContainer needed?**

Hardened PostgreSQL images have strict security requirements and will not automatically fix directory permissions. When Kubernetes creates persistent volumes with `fsGroup`, it sets permissions to 2770 (including the setgid bit), which PostgreSQL's hardened images reject. The initContainer runs once before PostgreSQL starts to correct these permissions.

## Access PostgreSQL

### Via kubectl port-forward

```bash
kubectl port-forward service/my-postgres 5432:5432
```

### Connect using psql

```bash
# Connect as postgres user
PGPASSWORD=your-password psql -h localhost -U postgres -d postgres

# Connect as custom user
PGPASSWORD=your-password psql -h localhost -U myapp -d myappdb
```

### Default Credentials

- **Admin User**: `postgres` (if enabled)
- **Admin Password**: Auto-generated (check secret) or configured value
- **Custom User**: Configured username
- **Custom Password**: Auto-generated or configured value

Get the auto-generated passwords:

```bash
# Admin password
kubectl get secret my-postgres -o jsonpath="{.data.postgres-password}" | base64 --decode

# Custom user password
kubectl get secret my-postgres -o jsonpath="{.data.password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with permission errors**

   - Ensure your storage class supports the required access modes
   - Check if security contexts are compatible with your cluster policies
   - Verify the PostgreSQL data directory permissions

2. **Cannot connect to PostgreSQL**

   - Verify the service is running: `kubectl get svc`
   - Check if authentication is properly configured
   - Ensure firewall rules allow access to port 5432
   - Check PostgreSQL logs: `kubectl logs <pod-name>`

3. **Database initialization fails**

   - Check if persistent volume has enough space
   - Verify environment variables are set correctly
   - Review pod events: `kubectl describe pod <pod-name>`

4. **Hardened image fails with "invalid argument: postgres"**

   - This occurs when using hardened images with different entrypoint behavior
   - Solution: Set `args: []` in your values file to disable default args
   - See [Using Hardened Images](#using-hardened-images) example

5. **Permission denied errors with hardened images**

   - Occurs when switching from standard postgres image (UID 999) to hardened image (e.g., UID 70)
   - Existing data directory has wrong ownership
   - Solution: Add init container to fix permissions
   - After successful startup, remove the init container

6. **Performance issues**
   - Check configured memory settings
   - Monitor resource usage with `kubectl top pod`
   - Adjust PostgreSQL configuration parameters
   - Consider increasing resources

### Performance Tuning

1. **Memory Configuration**

   ```yaml
   config:
     postgresqlSharedBuffers: "256MB" # 25% of RAM
     postgresqlEffectiveCacheSize: "1GB" # 75% of RAM
     postgresqlWorkMem: "8MB" # RAM / max_connections
     postgresqlMaintenanceWorkMem: "128MB"
   ```

2. **Connection Settings**

   ```yaml
   config:
     postgresqlMaxConnections: 200
   ```

3. **WAL and Checkpoints**

   ```yaml
   config:
     postgresqlWalBuffers: "16MB"
     postgresqlCheckpointCompletionTarget: "0.7"
     extraConfig:
       - "wal_level = replica"
       - "max_wal_size = 2GB"
       - "min_wal_size = 1GB"
   ```

4. **Resource Limits**
   ```yaml
   resources:
     requests:
       memory: "2Gi"
       cpu: "1000m"
     limits:
       memory: "4Gi"
       cpu: "2000m"
   ```

### Backup and Recovery

**Manual Backup**

```bash
kubectl exec -it <pod-name> -- pg_dump -U postgres -d mydb > backup.sql
```

### Getting Support

For issues related to this Helm chart, please check:

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
