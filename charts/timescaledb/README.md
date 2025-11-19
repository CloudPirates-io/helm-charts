<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-timescaledb/timescaledb"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-timescaledb" /></a>
</p>

# TimescaleDB

A Helm chart for TimescaleDB - The Open Source Time-Series Database for PostgreSQL. TimescaleDB is built on PostgreSQL and provides advanced time-series capabilities including automatic partitioning, columnar compression, continuous aggregates, and more.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-timescaledb`:

```bash
helm install my-timescaledb oci://registry-1.docker.io/cloudpirates/timescaledb
```

To install with custom values:

```bash
helm install my-timescaledb oci://registry-1.docker.io/cloudpirates/timescaledb -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-timescaledb ./charts/timescaledb
```

The command deploys TimescaleDB on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-timescaledb` deployment:

```bash
helm uninstall my-timescaledb
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/timescaledb:<version>
```

## Configuration

The following table lists the configurable parameters of the TimescaleDB chart and their default values.

### Global parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Image configuration

| Parameter          | Description                                            | Default                 |
| ------------------ | ------------------------------------------------------ | ----------------------- |
| `image.registry`   | TimescaleDB image registry                             | `docker.io`             |
| `image.repository` | TimescaleDB image repository                           | `timescale/timescaledb` |
| `image.tag`        | TimescaleDB image tag (immutable tags are recommended) | `"2.23.1-pg17@sha256:a6581100f2f1cd1e03a29a94a49c488a174de65e57301c04de255804645e5a31"`         |
| `image.pullPolicy` | TimescaleDB image pull policy                          | `Always`                |

### Common configuration

| Parameter           | Description                                                                                                      | Default |
| ------------------- | ---------------------------------------------------------------------------------------------------------------- | ------- |
| `replicaCount`      | Number of TimescaleDB replicas to deploy (Note: TimescaleDB doesn't support multi-master replication by default) | `1`     |
| `nameOverride`      | String to partially override timescaledb.fullname                                                                | `""`    |
| `fullnameOverride`  | String to fully override timescaledb.fullname                                                                    | `""`    |
| `commonLabels`      | Labels to add to all deployed objects                                                                            | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects                                                                       | `{}`    |

### Security Context

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `999`     |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the TimescaleDB container             | `999`     |
| `containerSecurityContext.runAsGroup`               | Group ID for the TimescaleDB container            | `999`     |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `false`   |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### TimescaleDB Authentication

| Parameter                          | Description                                                                           | Default               |
| ---------------------------------- | ------------------------------------------------------------------------------------- | --------------------- |
| `auth.postgresPassword`            | Password for the postgres admin user. If not set, a random password will be generated | `""`                  |
| `auth.existingSecret`              | Name of existing secret to use for TimescaleDB credentials                            | `""`                  |
| `auth.secretKeys.adminPasswordKey` | Name of key in existing secret to use for TimescaleDB credentials                     | `"postgres-password"` |

### TimescaleDB Configuration

| Parameter                                     | Description                                                                             | Default         |
| --------------------------------------------- | --------------------------------------------------------------------------------------- | --------------- |
| `config.postgresqlSharedPreloadLibraries`     | Shared preload libraries (comma-separated list)                                         | `"timescaledb"` |
| `config.postgresqlMaxConnections`             | Maximum number of connections                                                           | `100`           |
| `config.postgresqlSharedBuffers`              | Amount of memory the database server uses for shared memory buffers                     | `""`            |
| `config.postgresqlEffectiveCacheSize`         | Effective cache size                                                                    | `""`            |
| `config.postgresqlWorkMem`                    | Amount of memory to be used by internal sort operations and hash tables                 | `""`            |
| `config.postgresqlMaintenanceWorkMem`         | Maximum amount of memory to be used by maintenance operations                           | `""`            |
| `config.postgresqlWalBuffers`                 | Amount of memory used in shared memory for WAL data                                     | `""`            |
| `config.postgresqlCheckpointCompletionTarget` | Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval | `""`            |
| `config.postgresqlRandomPageCost`             | Sets the planner's estimate of the cost of a non-sequentially-fetched disk page         | `""`            |
| `config.postgresqlLogStatement`               | Sets the type of statements logged                                                      | `""`            |
| `config.postgresqlLogMinDurationStatement`    | Sets the minimum execution time above which statements will be logged                   | `""`            |
| `config.timescaledbTelemetry`                 | Enable/disable TimescaleDB telemetry                                                    | `"off"`         |
| `config.timescaledbMaxBackgroundWorkers`      | Maximum number of TimescaleDB background workers                                        | `8`             |
| `config.extraConfig`                          | Additional TimescaleDB configuration parameters                                         | `[]`            |
| `config.existingConfigmap`                    | Name of existing ConfigMap with TimescaleDB configuration                               | `""`            |

### Service configuration

| Parameter             | Description                | Default     |
| --------------------- | -------------------------- | ----------- |
| `service.type`        | TimescaleDB service type   | `ClusterIP` |
| `service.port`        | TimescaleDB service port   | `5432`      |
| `service.targetPort`  | TimescaleDB container port | `5432`      |
| `service.annotations` | Service annotations        | `{}`        |

### Ingress configuration

| Parameter                            | Description                                             | Default             |
| ------------------------------------ | ------------------------------------------------------- | ------------------- |
| `ingress.enabled`                    | Enable ingress record generation for TimescaleDB        | `false`             |
| `ingress.className`                  | IngressClass that will be used to implement the Ingress | `""`                |
| `ingress.annotations`                | Additional annotations for the Ingress resource         | `{}`                |
| `ingress.hosts[0].host`              | Hostname for TimescaleDB ingress                        | `timescaledb.local` |
| `ingress.hosts[0].paths[0].path`     | Path for TimescaleDB ingress                            | `/`                 |
| `ingress.hosts[0].paths[0].pathType` | Path type for TimescaleDB ingress                       | `Prefix`            |
| `ingress.tls`                        | TLS configuration for TimescaleDB ingress               | `[]`                |

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

| Parameter                            | Description                                     | Default |
| ------------------------------------ | ----------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on TimescaleDB containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe         | `30`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe                | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe               | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe             | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe             | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on TimescaleDB containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe        | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe               | `5`     |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe              | `5`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe            | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe            | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on TimescaleDB containers   | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe          | `30`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe                 | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe                | `5`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe              | `30`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe              | `1`     |

### Node Selection

| Parameter      | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `nodeSelector` | Node labels for pod assignment       | `{}`    |
| `tolerations`  | Toleration labels for pod assignment | `[]`    |
| `affinity`     | Affinity settings for pod assignment | `{}`    |

### Additional Configuration

| Parameter           | Description                                                             | Default |
| ------------------- | ----------------------------------------------------------------------- | ------- |
| `extraEnvVars`      | Additional environment variables to set                                 | `[]`    |
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

Deploy TimescaleDB with default configuration:

```bash
helm install my-timescaledb ./charts/timescaledb
```

### Production Setup with Persistence

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
  postgresPassword: "your-secure-admin-password"

config:
  postgresqlMaxConnections: 200
  postgresqlSharedBuffers: "256MB"
  postgresqlEffectiveCacheSize: "1GB"
  postgresqlWorkMem: "8MB"
  postgresqlMaintenanceWorkMem: "128MB"
  timescaledbMaxBackgroundWorkers: 16
  timescaledbTelemetry: "off"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: timescaledb.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: timescaledb-tls
      hosts:
        - timescaledb.yourdomain.com
```

Deploy with production values:

```bash
helm install my-timescaledb ./charts/timescaledb -f values-production.yaml
```

### High Performance Time-Series Configuration

```yaml
# values-timeseries.yaml
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
  timescaledbMaxBackgroundWorkers: 32
  timescaledbTelemetry: "off"
  extraConfig:
    - "timescaledb.max_background_workers = 32"
    - "effective_io_concurrency = 200"
    - "random_page_cost = 1.0"
    - "seq_page_cost = 1.0"

persistence:
  enabled: true
  storageClass: "fast-ssd"
  size: 500Gi

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
                  - timescaledb
          topologyKey: kubernetes.io/hostname
```

### Using Existing Secret for Authentication

```yaml
# values-external-secret.yaml
auth:
  existingSecret: "timescaledb-credentials"
  secretKeys:
    adminPasswordKey: "postgres-password"
```

Create the secret first:

```bash
kubectl create secret generic timescaledb-credentials \
  --from-literal=postgres-password=your-admin-password
```

### Custom Configuration with ConfigMap

```yaml
# values-custom-config.yaml
config:
  existingConfigmap: "timescaledb-custom-config"
```

Create the ConfigMap first:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: timescaledb-custom-config
data:
  postgresql.conf: |
    # Custom TimescaleDB configuration
    max_connections = 300
    shared_buffers = 512MB
    effective_cache_size = 2GB
    work_mem = 16MB
    maintenance_work_mem = 256MB

    # TimescaleDB specific settings
    shared_preload_libraries = 'timescaledb'
    timescaledb.telemetry_level = OFF
    timescaledb.max_background_workers = 16

    # Time-series optimizations
    effective_io_concurrency = 200
    random_page_cost = 1.0
    seq_page_cost = 1.0
```

## Access TimescaleDB

### Via kubectl port-forward

```bash
kubectl port-forward service/my-timescaledb 5432:5432
```

### Connect using psql

```bash
# Connect as postgres user
psql -h localhost -U postgres -d postgres -W
```

### Default Credentials

- **Admin User**: `postgres`
- **Admin Password**: Auto-generated (check secret) or configured value

Get the auto-generated password:

```bash
# Admin password
kubectl get secret my-timescaledb -o jsonpath="{.data.postgres-password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with permission errors**

   - Ensure your storage class supports the required access modes
   - Check if security contexts are compatible with your cluster policies
   - Verify the TimescaleDB data directory permissions

2. **Cannot connect to TimescaleDB**

   - Verify the service is running: `kubectl get svc`
   - Check if authentication is properly configured
   - Ensure firewall rules allow access to port 5432
   - Check TimescaleDB logs: `kubectl logs <pod-name>`

3. **TimescaleDB extension not loaded**

   - Verify `shared_preload_libraries` includes `timescaledb`
   - Check if the database initialization completed successfully
   - Review pod logs for TimescaleDB-specific errors

4. **Performance issues with time-series queries**
   - Check if tables are properly converted to hypertables
   - Review chunk intervals and partitioning strategy
   - Monitor resource usage with `kubectl top pod`
   - Consider adjusting TimescaleDB background workers

### Performance Tuning for Time-Series Workloads

1. **Memory Configuration for Time-Series**

   ```yaml
   config:
     postgresqlSharedBuffers: "512MB" # 25-30% of RAM for time-series
     postgresqlEffectiveCacheSize: "2GB" # 75% of RAM
     postgresqlWorkMem: "16MB" # Higher for analytical queries
     postgresqlMaintenanceWorkMem: "256MB"
     timescaledbMaxBackgroundWorkers: 16 # More workers for compression
   ```

2. **Connection Settings**

   ```yaml
   config:
     postgresqlMaxConnections: 200
   ```

3. **I/O Optimization**

   ```yaml
   config:
     postgresqlRandomPageCost: "1.0" # Lower for SSD storage
     extraConfig:
       - "effective_io_concurrency = 200"
       - "maintenance_io_concurrency = 10"
   ```

4. **TimescaleDB Specific Settings**
   ```yaml
   config:
     timescaledbTelemetry: "off"
     timescaledbMaxBackgroundWorkers: 32
     extraConfig:
       - "timescaledb.max_background_workers = 32"
       - "timescaledb.bgw_launcher_poll_time = 5s"
   ```

### Backup and Recovery

**Manual Backup with pg_dump**

```bash
kubectl exec -it <pod-name> -- pg_dump -U postgres -d mydb > backup.sql
```

**TimescaleDB-specific Backup**

```bash
kubectl exec -it <pod-name> -- pg_dump -U postgres -d mydb --schema-only > schema.sql
kubectl exec -it <pod-name> -- pg_dump -U postgres -d mydb --data-only > data.sql
```

### Getting Support

For issues related to this Helm chart, please check:

- [TimescaleDB Documentation](https://docs.timescale.com/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
