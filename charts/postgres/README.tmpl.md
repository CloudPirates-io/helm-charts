{{ template "chart.badgesSection" . }}
<a href="https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-postgres" /></a>

# PostgreSQL

{{ template "chart.description" . }}

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

{{ template "chart.requirementsSection" . }}

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

{{ template "chart.valuesTable" . }}

## Examples

### Extra Objects

You can use the `extraObjects` array to deploy additional Kubernetes resources (such as NetworkPolicies, ConfigMaps, etc.) alongside the release. This is useful for customizing your deployment with extra manifests that are not covered by the default chart options.

**Helm templating is supported in any field, but all template expressions must be quoted.** For example, to use the release namespace, write `namespace: "{{ "{{" }}  .Release.Namespace {{ "}}" }}"`.

**Example: Deploy a NetworkPolicy with templating**

```yaml
extraObjects:
  - apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-dns
      namespace: "{{ "{{" }}  .Release.Namespace {{ "}}" }}"
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
