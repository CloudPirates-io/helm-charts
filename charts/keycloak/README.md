<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-keycloak"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-keycloak" /></a>
</p>

# Keycloak

A Helm chart for Keycloak - Open Source Identity and Access Management Solution. Keycloak provides user federation, strong authentication, user management, fine-grained authorization, and more. It supports modern standards like OpenID Connect, OAuth 2.0, and SAML.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-keycloak`:

```bash
helm install my-keycloak oci://registry-1.docker.io/cloudpirates/keycloak
```

Or install directly from the local chart:

```bash
helm install my-keycloak ./charts/keycloak
```

The command deploys Keycloak on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-keycloak` deployment:

```bash
helm uninstall my-keycloak
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/keycloak:<version>
```

## Configuration

The following table lists the configurable parameters of the Keycloak chart and their default values.

### Global parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common parameters

| Parameter           | Description                                    | Default |
| ------------------- | ---------------------------------------------- | ------- |
| `nameOverride`      | String to partially override keycloak.fullname | `""`    |
| `fullnameOverride`  | String to fully override keycloak.fullname     | `""`    |
| `commonLabels`      | Labels to add to all deployed objects          | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects     | `{}`    |

### Keycloak image configuration

| Parameter               | Description                                         | Default                                                                            |
| ----------------------- | --------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `image.registry`        | Keycloak image registry                             | `docker.io`                                                                        |
| `image.repository`      | Keycloak image repository                           | `keycloak/keycloak`                                                                |
| `image.tag`             | Keycloak image tag (immutable tags are recommended) | `"26.3.4@sha256:2b32a51a31e8d780d9fa9a69a59ead69975263c61b5dd13559090e22aa26f100"` |
| `image.imagePullPolicy` | Keycloak image pull policy                          | `Always`                                                                           |

### Deployment configuration

| Parameter      | Description                           | Default |
| -------------- | ------------------------------------- | ------- |
| `replicaCount` | Number of Keycloak replicas to deploy | `1`     |

### Pod annotations and labels

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |

### Extra volumes and volumes mount

| Parameter           | Description                                           | Default |
| ------------------- | ----------------------------------------------------- | ------- |
| `extraVolumes`      | Array of Volume to add to the keycloak pod            | `[]`    |
| `extraVolumeMounts` | Array of VolumeMount to add to the keycloak container | `[]`    |

### Extra init containers for Keycloak pod

| Parameter             | Description                                           | Default |
| --------------------- | ----------------------------------------------------- | ------- |
| `extraInitContainers` | Array of initContainer to add to the keycloak pod     | `[]`    |

### Security

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `1001`    |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the Keycloak container                | `1001`    |
| `containerSecurityContext.runAsGroup`               | Group ID for the Keycloak container               | `1001`    |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `false`   |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### Keycloak Configuration

| Parameter                              | Description                                                                                                  | Default            |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------ |
| `keycloak.adminUser`                   | Keycloak admin username                                                                                      | `admin`            |
| `keycloak.adminPassword`               | Keycloak admin password                                                                                      | `""`               |
| `keycloak.existingSecret`              | Name of existing secret to use for Keycloak admin credentials                                                | `""`               |
| `keycloak.secretKeys.adminPasswordKey` | Secret key for admin credentials                                                                             | `"admin-password"` |
| `keycloak.hostname`                    | Keycloak hostname                                                                                            | `""`               |
| `keycloak.hostnameAdmin`               | Keycloak admin hostname                                                                                      | `""`               |
| `keycloak.hostnameStrict`              | Enable strict hostname resolution                                                                            | `false`            |
| `keycloak.hostnameBackchannel`         | Keycloak backchannel hostname                                                                                | `""`               |
| `keycloak.httpEnabled`                 | Enable HTTP listener                                                                                         | `true`             |
| `keycloak.httpPort`                    | HTTP port                                                                                                    | `8080`             |
| `keycloak.httpsPort`                   | HTTPS port                                                                                                   | `8443`             |
| `keycloak.proxyHeaders`                | The proxy headers that should be accepted by the server. (forwarded, xforwarded)                             | `""`               |
| `keycloak.proxyProtocolEnabled`        | Whether the server should use the HA PROXY protocol when serving requests from behind a proxy. (true, false) | `false`            |
| `keycloak.proxyTrustedAddresses`       | A comma separated list of trusted proxy addresses                                                            | `""`               |
| `keycloak.production`                  | Enable production mode                                                                                       | `false`            |
| `keycloak.httpRelativePath`            | Set relative path for serving resources; must start with a /                                                 | `""`               |

### Database Configuration

| Parameter                         | Description                                                                                                            | Default         |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------- |
| `database.type`                   | Database type (postgres, mysql, mariadb). Note: H2 databases are not supported due to readonly filesystem restrictions | `postgres`      |
| `database.host`                   | Database host (only used when not using embedded database)                                                             | `""`            |
| `database.port`                   | Database port (only used when not using embedded database, defaults: postgres=5432, mysql/mariadb=3306)                | `""`            |
| `database.name`                   | Database name (only used when not using embedded database)                                                             | `keycloak`      |
| `database.username`               | Database username (only used when not using embedded database)                                                         | `keycloak`      |
| `database.password`               | Database password (only used when not using embedded database)                                                         | `""`            |
| `database.existingSecret`         | Name of existing secret for database credentials (only used when not using embedded database)                          | `""`            |
| `database.secretKeys.passwordKey` | Name of key in existing secret for database password                                                                   | `"db-password"` |
| `database.secretKeys.usernameKey` | Name of key in existing secret for database username                                                                   | `"db-username"` |
| `database.jdbcParams`             | Additional JDBC parameters                                                                                             | `""`            |

### Cache Configuration

| Parameter          | Description                        | Default |
| ------------------ | ---------------------------------- | ------- |
| `cache.stack`      | Cache stack (local, ispn, default) | `local` |
| `cache.configFile` | Custom cache configuration file    | `""`    |

### Features Configuration

| Parameter           | Description               | Default |
| ------------------- | ------------------------- | ------- |
| `features.enabled`  | List of enabled features  | `[]`    |
| `features.disabled` | List of disabled features | `[]`    |

### Service configuration

| Parameter                     | Description                   | Default     |
| ----------------------------- | ----------------------------- | ----------- |
| `service.type`                | Keycloak service type         | `ClusterIP` |
| `service.httpPort`            | Keycloak HTTP service port    | `8080`      |
| `service.httpsPort`           | Keycloak HTTPS service port   | `8443`      |
| `service.httpTargetPort`      | Keycloak HTTP container port  | `8080`      |
| `service.httpsTargetPort`     | Keycloak HTTPS container port | `8443`      |
| `service.annotations`         | Service annotations           | `{}`        |
| `service.trafficDistribution` | Service traffic distribution  | `""`        |

### Ingress configuration

| Parameter                            | Description                                             | Default          |
| ------------------------------------ | ------------------------------------------------------- | ---------------- |
| `ingress.enabled`                    | Enable ingress record generation for Keycloak           | `false`          |
| `ingress.className`                  | IngressClass that will be used to implement the Ingress | `""`             |
| `ingress.annotations`                | Additional annotations for the Ingress resource         | `{}`             |
| `ingress.hosts[0].host`              | Hostname for Keycloak ingress                           | `keycloak.local` |
| `ingress.hosts[0].paths[0].path`     | Path for Keycloak ingress                               | `/`              |
| `ingress.hosts[0].paths[0].pathType` | Path type for Keycloak ingress                          | `Prefix`         |
| `ingress.tls`                        | TLS configuration for Keycloak ingress                  | `[]`             |

### Resources

| Parameter   | Description                                 | Default |
| ----------- | ------------------------------------------- | ------- |
| `resources` | The resources to allocate for the container | `{}`    |

### Persistence

| Parameter                   | Description                                        | Default             |
| --------------------------- | -------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims  | `false`             |
| `persistence.storageClass`  | Persistent Volume storage class                    | `""`                |
| `persistence.annotations`   | Persistent Volume Claim annotations                | `{}`                |
| `persistence.size`          | Persistent Volume size                             | `1Gi`               |
| `persistence.accessModes`   | Persistent Volume access modes                     | `["ReadWriteOnce"]` |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`                |

### Liveness and readiness probes

| Parameter                            | Description                                  | Default |
| ------------------------------------ | -------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on Keycloak containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe      | `60`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe             | `30`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe            | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe          | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe          | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on Keycloak containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe     | `30`    |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe            | `10`    |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe           | `5`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe         | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe         | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on Keycloak containers   | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe       | `30`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe              | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe             | `5`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe           | `60`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe           | `1`     |

### Node Selection

| Parameter                   | Description                                    | Default |
| --------------------------- | ---------------------------------------------- | ------- |
| `nodeSelector`              | Node labels for pod assignment                 | `{}`    |
| `tolerations`               | Toleration labels for pod assignment           | `[]`    |
| `affinity`                  | Affinity settings for pod assignment           | `{}`    |
| `topologySpreadConstraints` | Topology Spread Constraints for pod assignment | `[]`    |

### Service Account

| Parameter                                     | Description                                                                                                               | Default |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a service account should be created                                                                     | `false` |
| `serviceAccount.annotations`                  | Annotations to add to the service account                                                                                 | `{}`    |
| `serviceAccount.name`                         | The name of the service account to use. If not set and create is true, a name is generated using the `fullname` template. | `""`    |
| `serviceAccount.automountServiceAccountToken` | Whether to automount the SA token inside the pod                                                                          | `false` |

### Extra Environment

| Parameter            | Description                                                            | Default |
| -------------------- | ---------------------------------------------------------------------- | ------- |
| `extraEnv`           | Additional environment variables from key-value pairs                  | `{}`    |
| `extraEnvVarsSecret` | Name of an existing secret containing additional environment variables | ``      |

### Extra Configuration Parameters

| Parameter      | Description                                       | Default |
| -------------- | ------------------------------------------------- | ------- |
| `extraObjects` | Array of extra objects to deploy with the release | `[]`    |

### Init Container Configuration

| Parameter                              | Description                                 | Default                                                                                  |
| -------------------------------------- | ------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `initContainers.waitForPostgres.image` | PostgreSQL init container image for waiting | `postgres:17.6@sha256:feff5b24fedd610975a1f5e743c51a4b360437f4dc3a11acf740dcd708f413f6`  |
| `initContainers.waitForMariadb.image`  | MariaDB init container image for waiting    | `mariadb:12.0.2@sha256:8a061ef9813cf960f94a262930a32b190c3fbe5c8d3ab58456ef1df4b90fd5dc` |

### PostgreSQL Configuration

| Parameter                | Description                                                   | Default      |
| ------------------------ | ------------------------------------------------------------- | ------------ |
| `postgres.enabled`       | Enable embedded PostgreSQL database                           | `true`       |
| `postgres.auth.database` | PostgreSQL database name                                      | `"keycloak"` |
| `postgres.auth.username` | PostgreSQL database user (leave empty for default 'postgres') | `""`         |
| `postgres.auth.password` | PostgreSQL database password                                  | `""`         |

### MariaDB Configuration

| Parameter                   | Description                                       | Default      |
| --------------------------- | ------------------------------------------------- | ------------ |
| `mariadb.enabled`           | Enable embedded PostgreSQL database               | `false`      |
| `mariadb.auth.database`     | MariaDB database name                             | `"keycloak"` |
| `mariadb.auth.username`     | MariaDB database user (leave empty for root user) | `""`         |
| `mariadb.auth.password`     | MariaDB database password                         | `""`         |
| `mariadb.auth.rootPassword` | MariaDB root password                             | `""`         |

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

Deploy Keycloak with default configuration:

```bash
helm install my-keycloak ./charts/keycloak
```

### Production Setup with External Database

```yaml
# values-production.yaml
keycloak:
  adminPassword: "secure-admin-password"
  hostname: "auth.yourdomain.com"
  production: true
  proxyHeaders: "xforwarded"

database:
  type: "postgres"
  host: "postgres.database.svc.cluster.local"
  port: "5432"
  name: "keycloak"
  username: "keycloak"
  password: "secure-db-password"

# Disable embedded databases
postgres:
  enabled: false
mariadb:
  enabled: false

resources:
  requests:
    memory: "1Gi"
    cpu: "500m"
  limits:
    memory: "2Gi"
    cpu: "1000m"

ingress:
  enabled: true
  className: "nginx"
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: "HTTP"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  hosts:
    - host: auth.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: keycloak-tls
      hosts:
        - auth.yourdomain.com
```

Deploy with production values:

```bash
helm install my-keycloak ./charts/keycloak -f values-production.yaml
```

### Development Setup with Embedded Database

```yaml
# values-development.yaml
keycloak:
  adminPassword: "admin"
  httpEnabled: true
  production: false

postgres:
  enabled: true
  auth:
    database: "keycloak"
    password: "keycloak-db-password"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: keycloak.local
      paths:
        - path: /
          pathType: Prefix

persistence:
  enabled: true
  size: 5Gi
```

### Using Existing Secrets for Authentication

```yaml
# values-external-secret.yaml
keycloak:
  existingSecret: "keycloak-credentials"
  secretKeys:
    adminPasswordKey: "admin-password"

database:
  type: "postgres"
  host: "postgres.database.svc.cluster.local"
  existingSecret: "keycloak-db-credentials"
  secretKeys:
    passwordKey: "db-password"
    usernameKey: "db-username"

# Disable embedded databases
postgres:
  enabled: false
mariadb:
  enabled: false
```

Create the secrets first:

```bash
kubectl create secret generic keycloak-credentials \
  --from-literal=admin-password=your-admin-password

kubectl create secret generic keycloak-db-credentials \
  --from-literal=db-password=your-db-password \
  --from-literal=db-username=keycloak
```

### High Availability Setup

```yaml
# values-ha.yaml
replicaCount: 3

keycloak:
  adminPassword: "secure-admin-password"
  hostname: "auth.yourdomain.com"
  production: true
  proxyHeaders: "xforwarded"

cache:
  stack: "ispn" # Use Infinispan for clustering

database:
  type: "postgres"
  host: "postgres-ha.database.svc.cluster.local"
  name: "keycloak"
  username: "keycloak"
  password: "secure-db-password"

# Disable embedded databases
postgres:
  enabled: false
mariadb:
  enabled: false

resources:
  requests:
    memory: "2Gi"
    cpu: "1000m"
  limits:
    memory: "4Gi"
    cpu: "2000m"

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
                  - keycloak
          topologyKey: kubernetes.io/hostname
```

## Access Keycloak

### Via kubectl port-forward

```bash
kubectl port-forward service/my-keycloak 8080:8080
```

### Connect using browser

Navigate to `http://localhost:8080` and log in with the admin credentials.

### Default Credentials

- **Admin User**: `admin` (configurable)
- **Admin Password**: Auto-generated (check secret) or configured value

Get the auto-generated admin password:

```bash
kubectl get secret my-keycloak -o jsonpath="{.data.admin-password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with database connection errors**
   - Verify database connection parameters
   - Ensure the database is running and accessible
   - Check database credentials in secrets
   - Review pod logs: `kubectl logs <pod-name>`

2. **Cannot access Keycloak via ingress**
   - Verify ingress configuration and annotations
   - Check if ingress controller is installed
   - Ensure DNS resolves to the correct IP
   - Check TLS certificate configuration

3. **Admin login fails**
   - Verify admin password in the secret
   - Check if the admin user exists in the database
   - Review Keycloak logs for authentication errors

4. **Database initialization fails**
   - Ensure database schema permissions are correct
   - Check if the database already exists and is empty
   - Verify database connection and credentials
   - Review init container logs

### Performance Tuning

1. **Memory Configuration**

   ```yaml
   resources:
     requests:
       memory: "2Gi"
       cpu: "1000m"
     limits:
       memory: "4Gi"
       cpu: "2000m"
   ```

2. **JVM Settings (via extraEnv)**

   ```yaml
   extraEnv:
     JAVA_OPTS: "-Xms1024m -Xmx2048m -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=512m"
   ```

3. **Database Connection Pool**
   ```yaml
   database:
     jdbcParams: "?prepStmtCacheSize=250&prepStmtCacheSqlLimit=2048"
   ```

### Getting Support

For issues related to this Helm chart, please check:

- [Keycloak Documentation](https://www.keycloak.org/documentation)
- [Keycloak Server Administration Guide](https://www.keycloak.org/docs/latest/server_admin/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- Chart repository issues
