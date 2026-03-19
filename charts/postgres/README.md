<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-postgres/postgres"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-postgres" /></a>
</p>

# PostgreSQL

A Helm chart for PostgreSQL - The World's Most Advanced Open Source Relational Database. PostgreSQL is a powerful, open source object-relational database system with over 35 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

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
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE5U+rM2d3hDjgP5T3cLShuuQIU9vR
Z4/G+Nug6q5vRa+C3qUA1wXjbaJFAfcIrv5VjmYAYOj13shnPpp3Zh4fnQ==
-----END PUBLIC KEY-----
```

To verify the helm chart before installation, copy the public key to the file `cosign.pub` and run cosign:

```bash
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/postgres:<version>
```

## Configuration

The following table lists the configurable parameters of the PostgreSQL chart and their default values.

### Global parameters

| Parameter                   | Description                                     | Default |
| --------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`      | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets`   | Global Docker registry secret names as an array | `[]`    |
| `global.enableServiceLinks` | Enable service links in pods                    | `true`  |

### PostgreSQL image configuration

| Parameter                | Description                                                                                            | Default                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
| `image.registry`         | PostgreSQL image registry                                                                              | `docker.io`                                                                      |
| `image.repository`       | PostgreSQL image repository                                                                            | `postgres`                                                                       |
| `image.tag`              | PostgreSQL image tag (immutable tags are recommended)                                                  | `"18.3@sha256:69e8582b781cb44fa4557b98ed586fe68361e320d9b12f9707494335634f4f3d"` |
| `image.imagePullPolicy`  | PostgreSQL image pull policy                                                                           | `Always`                                                                         |
| `image.useHardenedImage` | Set to `true` when using hardened images (e.g., DHI) that have different PGDATA paths for Postgres <18 | `false`                                                                          |

### Deployment configuration

| Parameter                       | Description                                                                                                    | Default |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------- | ------- |
| `replicaCount`                  | Number of PostgreSQL replicas to deploy (Note: PostgreSQL doesn't support multi-master replication by default) | `1`     |
| `nameOverride`                  | String to partially override postgres.fullname                                                                 | `""`    |
| `fullnameOverride`              | String to fully override postgres.fullname                                                                     | `""`    |
| `commonLabels`                  | Labels to add to all deployed objects                                                                          | `{}`    |
| `commonAnnotations`             | Annotations to add to all deployed objects                                                                     | `{}`    |
| `priorityClassName`             | Priority class name to be used for the pods                                                                    | ``      |
| `terminationGracePeriodSeconds` | Time for Kubernetes to wait for the pod to gracefully terminate                                                | `30`    |

### Pod annotations and labels

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |

### Security Context

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `999`     |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the PostgreSQL container              | `999`     |
| `containerSecurityContext.runAsGroup`               | Group ID for the PostgreSQL container             | `999`     |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `false`   |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### PostgreSQL Authentication

| Parameter                          | Description                                                                                                           | Default               |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------- |
| `auth.username`                    | PostgreSQL superuser name (`POSTGRES_USER`). If empty, defaults to `postgres`.                                        | `""`                  |
| `auth.password`                    | Password for the PostgreSQL superuser (`POSTGRES_PASSWORD`). Auto-generated if empty.                                 | `""`                  |
| `auth.database`                    | Default database to create (`POSTGRES_DB`). Defaults to the superuser name if empty.                                  | `""`                  |
| `auth.existingSecret`              | Name of an existing secret containing the superuser password. When set, the chart does **not** create its own secret. | `""`                  |
| `auth.secretKeys.adminPasswordKey` | Key in `auth.existingSecret` that holds the superuser password.                                                       | `"postgres-password"` |

#### Chart-generated secret

When `auth.existingSecret` is **not** set the chart creates a secret named `<fullname>` (e.g. `my-postgres`) with the following keys:

| Key                 | Description                                     |
| ------------------- | ----------------------------------------------- |
| `postgres-password` | Superuser password (plain-text encoded)         |
| `host`              | Service hostname (`<fullname>.<namespace>.svc`) |
| `port`              | Service port                                    |
| `username`          | Superuser name                                  |
| `database`          | Default database name                           |
| `uri`               | Full `postgresql://` connection URI             |

When `auth.existingSecret` is set, none of these keys are generated. Your secret must contain at minimum the key referenced by `auth.secretKeys.adminPasswordKey`.

### PostgreSQL Configuration

| Parameter                                        | Description                                                                             | Default              |
| ------------------------------------------------ | --------------------------------------------------------------------------------------- | -------------------- |
| `config.mountConfigMap`                          | Enable mounting of ConfigMap with PostgreSQL configuration                              | `true`               |
| `config.extraConfig`                             | Additional PostgreSQL configuration parameters (list of raw config lines)               | `[]`                 |
| `config.existingConfigmap`                       | Name of existing ConfigMap with PostgreSQL configuration                                | `""`                 |
| `config.pgHbaConfig`                             | Content of a custom pg_hba.conf file to be used instead of the default config           | `""`                 |
| `config.postgresql.max_connections`              | Maximum number of connections                                                           | `100`                |
| `config.postgresql.shared_buffers`               | Amount of memory the database server uses for shared memory buffers                     | `128MB`              |
| `config.postgresql.effective_cache_size`         | Sets the planner's assumption about the total size of the data caches                   | `4GB`                |
| `config.postgresql.work_mem`                     | Amount of memory to be used by internal sort operations and hash tables                 | `4MB`                |
| `config.postgresql.maintenance_work_mem`         | Maximum amount of memory to be used by maintenance operations                           | `64MB`               |
| `config.postgresql.checkpoint_completion_target` | Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval | `0.7`                |
| `config.postgresql.random_page_cost`             | Sets the planner's estimate of the cost of a non-sequentially-fetched disk page         | `1.1`                |
| `config.postgresql.timezone`                     | Default timezone setting                                                                | `UTC`                |
| `config.postgresql.locale`                       | Locale setting for all lc\_\* settings                                                  | `en_US.utf8`         |
| `config.postgresql.default_text_search_config`   | Sets default text search configuration                                                  | `pg_catalog.english` |
| `config.postgresql.datestyle`                    | Sets the display format for date and time values                                        | `iso, mdy`           |
| `config.postgresql.log_destination`              | Sets the destination for server log output                                              | `stderr`             |
| `config.postgresql.logging_collector`            | Start a subprocess to capture stderr output into log files                              | `off`                |
| `config.postgresql.log_min_messages`             | Sets the message levels that are logged                                                 | `warning`            |
| `config.postgresql.log_min_error_statement`      | Causes all statements generating error at or above this level to be logged              | `error`              |
| `config.postgresql.log_statement`                | Sets the type of statements logged                                                      | `none`               |
| `config.postgresql.log_min_duration_statement`   | Sets the minimum execution time above which all statements will be logged               | `-1`                 |
| `config.postgresql.shared_preload_libraries`     | Shared preload libraries (comma-separated list)                                         | `""`                 |
| `config.postgresql.wal_buffers`                  | Amount of memory used in shared memory for WAL data                                     | `16MB`               |
| `config.postgresql.wal_level`                    | Determines how much information is written to the WAL                                   | `replica`            |
| `config.postgresql.max_wal_senders`              | Maximum number of concurrent connections from standby servers                           | `5`                  |
| `config.postgresql.wal_keep_size`                | Minimum size of past WAL files kept in the pg_wal directory (in MB)                     | `1024`               |

#### Deprecated Configuration Parameters

The following parameters are deprecated in favour of the `config.postgresql` block above. They still work and take precedence when set to a non-empty/non-zero value.

| Parameter                                     | Description                                                                             | Default |
| --------------------------------------------- | --------------------------------------------------------------------------------------- | ------- |
| `config.postgresqlSharedPreloadLibraries`     | Shared preload libraries (comma-separated list)                                         | `""`    |
| `config.postgresqlMaxConnections`             | Maximum number of connections (set to `0` to use `config.postgresql.max_connections`)   | `0`     |
| `config.postgresqlSharedBuffers`              | Amount of memory the database server uses for shared memory buffers                     | `""`    |
| `config.postgresqlEffectiveCacheSize`         | Effective cache size                                                                    | `""`    |
| `config.postgresqlWorkMem`                    | Amount of memory to be used by internal sort operations and hash tables                 | `""`    |
| `config.postgresqlMaintenanceWorkMem`         | Maximum amount of memory to be used by maintenance operations                           | `""`    |
| `config.postgresqlWalBuffers`                 | Amount of memory used in shared memory for WAL data                                     | `""`    |
| `config.postgresqlCheckpointCompletionTarget` | Time spent flushing dirty buffers during checkpoint, as fraction of checkpoint interval | `""`    |
| `config.postgresqlRandomPageCost`             | Sets the planner's estimate of the cost of a non-sequentially-fetched disk page         | `""`    |
| `config.postgresqlLogStatement`               | Sets the type of statements logged                                                      | `""`    |
| `config.postgresqlLogMinDurationStatement`    | Sets the minimum execution time above which statements will be logged                   | `""`    |

### Custom User Configuration

`customUser` creates an **additional, non-superuser** account during first initialisation. This is separate from the superuser configured in the `auth` section.

| Parameter                        | Description                                                                                                          | Default           |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ----------------- |
| `customUser.name`                | Name of the additional user to create                                                                                | `""`              |
| `customUser.database`            | Name of the database to create and grant to the user (defaults to `customUser.name` if empty)                        | `""`              |
| `customUser.password`            | Password for the custom user. Auto-generated and preserved across upgrades if empty.                                 | `""`              |
| `customUser.existingSecret`      | Name of an existing secret. When set the chart does **not** generate its own custom-user secret.                     | `""`              |
| `customUser.secretKeys.name`     | Key in the secret that holds the username. Set to empty to use `customUser.name` as a static value instead.          | `CUSTOM_USER`     |
| `customUser.secretKeys.database` | Key in the secret that holds the database name. Set to empty to use `customUser.database` as a static value instead. | `CUSTOM_DB`       |
| `customUser.secretKeys.password` | Key in the secret that holds the password. **Always read from the secret** — no static fallback.                     | `CUSTOM_PASSWORD` |

#### Chart-generated custom-user secret

When `customUser.name` is set and `customUser.existingSecret` is **not** set, the chart creates a secret named `<fullname>-custom-user-credentials` (e.g. `my-postgres-custom-user-credentials`) with the following keys:

| Key               | Description          |
| ----------------- | -------------------- |
| `CUSTOM_USER`     | Custom user name     |
| `CUSTOM_DB`       | Custom database name |
| `CUSTOM_PASSWORD` | Custom user password |

The password is auto-generated on first install and preserved on subsequent upgrades. To set a fixed password, use `customUser.password` or provide `customUser.existingSecret`.

### Container Command/Args Override

| Parameter | Description                                                                                                                                       | Default |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `command` | Override default container command (useful for hardened images)                                                                                   | `[]`    |
| `args`    | Override default container args (useful for hardened images that handle startup differently). Set to `null` to use defaults, `[]` to disable args | `null`  |

These parameters are useful when using hardened PostgreSQL images (such as from DHI or other security-focused registries) that have different entrypoint behaviors than the standard Docker Hub postgres image. When using such images, you may need to set `args: []` to prevent passing the default `postgres` binary name and configuration arguments.

### PostgreSQL Initdb Configuration

| Parameter                 | Description                                                                      | Default                        |
| ------------------------- | -------------------------------------------------------------------------------- | ------------------------------ |
| `initdb.args`             | Send arguments to postgres initdb. This is a space separated string of arguments | `""`                           |
| `initdb.scripts`          | Dictionary of initdb scripts                                                     | `{}`                           |
| `initdb.scriptsConfigMap` | ConfigMap with scripts to be run at first boot                                   | `""`                           |
| `initdb.directory`        | Directory inside the container where initdb scripts are mounted                  | `/docker-entrypoint-initdb.d/` |

### Service configuration

| Parameter                       | Description                                                                       | Default     |
| ------------------------------- | --------------------------------------------------------------------------------- | ----------- |
| `service.type`                  | PostgreSQL service type                                                           | `ClusterIP` |
| `service.port`                  | PostgreSQL service port                                                           | `5432`      |
| `service.targetPort`            | PostgreSQL container port                                                         | `5432`      |
| `service.nodePort`              | PostgreSQL NodePort port                                                          | `30432`     |
| `service.annotations`           | Service annotations                                                               | `{}`        |
| `service.loadBalancerIP`        | Load balancer IP (applies if service type is `LoadBalancer`)                      | `""`        |
| `service.externalTrafficPolicy` | External traffic policy (applies if service type is `LoadBalancer` or `NodePort`) | `""`        |

### Ingress configuration

| Parameter                            | Description                                             | Default          |
| ------------------------------------ | ------------------------------------------------------- | ---------------- |
| `ingress.enabled`                    | Enable ingress record generation for PostgreSQL         | `false`          |
| `ingress.className`                  | IngressClass that will be used to implement the Ingress | `""`             |
| `ingress.annotations`                | Additional annotations for the Ingress resource         | `{}`             |
| `ingress.hosts[0].host`              | Hostname for PostgreSQL ingress                         | `postgres.local` |
| `ingress.hosts[0].paths[0].path`     | Path for PostgreSQL ingress                             | `/`              |
| `ingress.hosts[0].paths[0].pathType` | Path type for PostgreSQL ingress                        | `Prefix`         |
| `ingress.tls`                        | TLS configuration for PostgreSQL ingress                | `[]`             |

### Resources

| Parameter   | Description                                 | Default |
| ----------- | ------------------------------------------- | ------- |
| `resources` | The resources to allocate for the container | `{}`    |

### Persistence

| Parameter                   | Description                                          | Default             |
| --------------------------- | ---------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims    | `true`              |
| `persistence.storageClass`  | Persistent Volume storage class                      | `""`                |
| `persistence.annotations`   | Persistent Volume Claim annotations                  | `{}`                |
| `persistence.labels`        | Labels for persistent volume claims                  | `{}`                |
| `persistence.size`          | Persistent Volume size                               | `8Gi`               |
| `persistence.accessModes`   | Persistent Volume access modes                       | `["ReadWriteOnce"]` |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence   | `""`                |
| `persistence.subPath`       | The subdirectory of the volume to mount to           | `""`                |
| `persistence.volumeName`    | Container volume name and VolumeClaimTemplate prefix | `data`              |

### Persistent Volume Claim Retention Policy

| Parameter                                          | Description                                                                    | Default    |
| -------------------------------------------------- | ------------------------------------------------------------------------------ | ---------- |
| `persistentVolumeClaimRetentionPolicy.enabled`     | Enable Persistent volume retention policy for the Statefulset                  | `false`    |
| `persistentVolumeClaimRetentionPolicy.whenDeleted` | Volume retention behavior that applies when the StatefulSet is deleted         | `"Retain"` |
| `persistentVolumeClaimRetentionPolicy.whenScaled`  | Volume retention behavior when the replica count of the StatefulSet is reduced | `"Retain"` |

### Liveness and readiness probes

| Parameter                            | Description                                    | Default |
| ------------------------------------ | ---------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on PostgreSQL containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe        | `30`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe               | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe              | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe            | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe            | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on PostgreSQL containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe       | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe              | `5`     |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe             | `5`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe           | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe           | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on PostgreSQL containers   | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe         | `30`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe                | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe               | `5`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe             | `30`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe             | `1`     |

### Node Selection

| Parameter      | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `nodeSelector` | Node labels for pod assignment       | `{}`    |
| `tolerations`  | Toleration labels for pod assignment | `[]`    |
| `affinity`     | Affinity settings for pod assignment | `{}`    |

### Service Account

| Parameter                                     | Description                                                                                                               | Default |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a service account should be created                                                                     | `false` |
| `serviceAccount.annotations`                  | Annotations to add to the service account                                                                                 | `{}`    |
| `serviceAccount.name`                         | The name of the service account to use. If not set and create is true, a name is generated using the `fullname` template. | `""`    |
| `serviceAccount.automountServiceAccountToken` | Whether to automount the SA token inside the pod                                                                          | `false` |

### Extra Configuration Parameters

| Parameter            | Description                                                            | Default |
| -------------------- | ---------------------------------------------------------------------- | ------- |
| `extraEnvVars`       | Additional environment variables to set                                | `[]`    |
| `extraVolumes`       | Additional volumes to add to the pod                                   | `[]`    |
| `extraVolumeMounts`  | Additional volume mounts to add to the MongoDB container               | `[]`    |
| `extraObjects`       | Array of extra objects to deploy with the release                      | `[]`    |
| `extraEnvVarsSecret` | Name of an existing Secret containing additional environment variables | ``      |

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

### Metrics Configuration

| Parameter                                  | Description                                                                     | Default                                 |
| ------------------------------------------ | ------------------------------------------------------------------------------- | --------------------------------------- |
| `metrics.enabled`                          | Start a sidecar prometheus exporter to expose PostgreSQL metrics                | `false`                                 |
| `metrics.image.registry`                   | PostgreSQL exporter image registry                                              | `quay.io`                               |
| `metrics.image.repository`                 | PostgreSQL exporter image repository                                            | `prometheuscommunity/postgres-exporter` |
| `metrics.image.tag`                        | PostgreSQL exporter image tag                                                   | `v0.19.1`                               |
| `metrics.image.pullPolicy`                 | PostgreSQL exporter image pull policy                                           | `Always`                                |
| `metrics.resources`                        | Resource limits and requests for metrics container                              | `{}`                                    |
| `metrics.service.annotations`              | Additional custom annotations for Metrics service                               | `{}`                                    |
| `metrics.service.labels`                   | Additional custom labels for Metrics service                                    | `{}`                                    |
| `metrics.service.port`                     | Metrics service port                                                            | `9187`                                  |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource(s) for scraping metrics using PrometheusOperator | `false`                                 |
| `metrics.serviceMonitor.namespace`         | The namespace in which the ServiceMonitor will be created                       | `""`                                    |
| `metrics.serviceMonitor.interval`          | The interval at which metrics should be scraped                                 | `30s`                                   |
| `metrics.serviceMonitor.scrapeTimeout`     | The timeout after which the scrape is ended                                     | `10s`                                   |
| `metrics.serviceMonitor.selector`          | Additional labels for ServiceMonitor resource                                   | `{}`                                    |
| `metrics.serviceMonitor.annotations`       | ServiceMonitor annotations                                                      | `{}`                                    |
| `metrics.serviceMonitor.honorLabels`       | honorLabels chooses the metric's labels on collisions with target labels        | `false`                                 |
| `metrics.serviceMonitor.relabelings`       | ServiceMonitor relabel configs to apply to samples before scraping              | `[]`                                    |
| `metrics.serviceMonitor.metricRelabelings` | ServiceMonitor metricRelabelings configs to apply to samples before ingestion   | `[]`                                    |
| `metrics.serviceMonitor.namespaceSelector` | ServiceMonitor namespace selector                                               | `{}`                                    |

### WAL Replication Configuration

| Parameter                              | Description                                                                          | Default                |
| -------------------------------------- | ------------------------------------------------------------------------------------ | ---------------------- |
| `replication.enabled`                  | Enable WAL replication (provides `REPLICATION_USER`/`REPLICATION_PASSWORD` env vars) | `false`                |
| `replication.primary.host`             | Hostname of the primary server (set to configure this instance as a standby)         | `""`                   |
| `replication.primary.port`             | Port of the primary server                                                           | `5432`                 |
| `replication.createUser`               | Whether to create the replication user via init script                               | `true`                 |
| `replication.auth.username`            | Username for the replication user                                                    | `replication`          |
| `replication.auth.password`            | Password for the replication user (required when not using `existingSecret`)         | `""`                   |
| `replication.auth.existingSecret`      | Existing secret containing the replication password                                  | `""`                   |
| `replication.auth.secretKeys.password` | Key for the password field in `replication.auth.existingSecret`                      | `replication-password` |
| `replication.allowFrom.ipv4`           | Allowed IPv4 network for replication connections (set empty to disable)              | `0.0.0.0/0`            |
| `replication.allowFrom.ipv6`           | Allowed IPv6 network for replication connections (set empty to disable)              | `::/0`                 |

## Examples

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
  postgresql:
    max_connections: 200
    shared_buffers: "256MB"
    effective_cache_size: "1GB"
    work_mem: "8MB"
    maintenance_work_mem: "128MB"

customUser:
  existingSecret: "postgres-custom-user"
  # default secretKeys (CUSTOM_USER / CUSTOM_DB / CUSTOM_PASSWORD) are used
  # create with: kubectl create secret generic postgres-custom-user
  #   --from-literal=CUSTOM_USER=myuser
  #   --from-literal=CUSTOM_DB=mydb
  #   --from-literal=CUSTOM_PASSWORD=mypassword

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
  postgresql:
    max_connections: 500
    shared_buffers: "2GB"
    effective_cache_size: "6GB"
    work_mem: "16MB"
    maintenance_work_mem: "512MB"
    wal_buffers: "32MB"
    checkpoint_completion_target: 0.9
    random_page_cost: 1.0
  extraConfig:
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

### Using Existing Secrets

#### Superuser credentials

Supply your own secret instead of letting the chart generate one. The secret must contain the key named by `auth.secretKeys.adminPasswordKey` (default `postgres-password`). Note: when using an existing secret the chart does **not** create its own, so the convenience keys (`host`, `port`, `uri`, etc.) will not be present.

```bash
kubectl create secret generic postgres-credentials \
  --from-literal=postgres-password=your-admin-password
```

```yaml
auth:
  existingSecret: "postgres-credentials"
  # secretKeys.adminPasswordKey defaults to "postgres-password", only override if your key differs
```

#### Custom user credentials

Supply your own secret for the custom user. All three keys (`name`, `database`, `password`) are read from the secret. The `name` and `database` keys can be left empty to fall back to the static values in `customUser.name` / `customUser.database`, but the `password` key **must always be present** in the secret — there is no static fallback for it.

```bash
kubectl create secret generic postgres-custom-user \
  --from-literal=CUSTOM_USER=myuser \
  --from-literal=CUSTOM_DB=mydb \
  --from-literal=CUSTOM_PASSWORD=myuserpassword
```

```yaml
customUser:
  existingSecret: "postgres-custom-user"
  # secretKeys default to CUSTOM_USER / CUSTOM_DB / CUSTOM_PASSWORD — only override if your keys differ
```

If your existing secret uses different key names, configure them explicitly:

```yaml
customUser:
  existingSecret: "postgres-custom-user"
  secretKeys:
    name: "username"
    database: "database"
    password: "password"
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

To use an existing secret instead of a plain-text password, create a secret containing the replication password under the key referenced by `replication.auth.secretKeys.password` (default `replication-password`):

```bash
kubectl create secret generic postgres-replication \
  --from-literal=replication-password=secret
```

```yaml
replication:
  enabled: true
  auth:
    existingSecret: "postgres-replication"
    # secretKeys.password defaults to "replication-password" — only override if your key differs
```

#### Standby setup

As soon as a primary host is configured, this instance is considered to be a standby server.

This will also create an `initContainer` named `replication-standby-init`, which:

- Creates/updates the `replication.pgpass` credentials file in the transient run directory
- Initializes the database using `pg_basebackup` if not already done using the credentials file above

The password on the standby must match what was configured on the primary.

```yaml
replication:
  enabled: true
  auth:
    password: "secret" # must match the primary's replication password
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
# Superuser (admin) password
kubectl get secret my-postgres -o jsonpath="{.data.postgres-password}" | base64 --decode

# Custom user password (in the separate custom-user secret)
kubectl get secret my-postgres-custom-user-credentials -o jsonpath="{.data.CUSTOM_PASSWORD}" | base64 --decode

# Full connection URI (superuser)
kubectl get secret my-postgres -o jsonpath="{.data.uri}" | base64 --decode
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
     postgresql:
       shared_buffers: "256MB" # 25% of RAM
       effective_cache_size: "1GB" # 75% of RAM
       work_mem: "8MB" # RAM / max_connections
       maintenance_work_mem: "128MB"
   ```

2. **Connection Settings**

   ```yaml
   config:
     postgresql:
       max_connections: 200
   ```

3. **WAL and Checkpoints**

   ```yaml
   config:
     postgresql:
       wal_buffers: "16MB"
       checkpoint_completion_target: 0.7
     extraConfig:
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
