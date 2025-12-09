<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-keycloak/keycloak"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-keycloak" /></a>
</p>

# Keycloak

A Helm chart for Keycloak - Open Source Identity and Access Management Solution. Keycloak provides user federation, strong authentication, user management, fine-grained authorization, and more. It supports modern standards like OpenID Connect, OAuth 2.0, and SAML.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-keycloak`:

```bash
helm install my-keycloak oci://registry-1.docker.io/cloudpirates/keycloak
```

To install with custom values:

```bash
helm install my-keycloak oci://registry-1.docker.io/cloudpirates/keycloak -f my-values.yaml
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
| `image.tag`             | Keycloak image tag (immutable tags are recommended) | `"26.4.7@sha256:9409c59bdfb65dbffa20b11e6f18b8abb9281d480c7ca402f51ed3d5977e6007"` |
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
| `preserveThemes`    | Preserve the original themes folder of the image      | `false` |
| `preserveProviders` | Preserve the original providers folder of the image   | `false` |

### Extra init containers for Keycloak pod

| Parameter             | Description                                       | Default |
| --------------------- | ------------------------------------------------- | ------- |
| `extraInitContainers` | Array of initContainer to add to the keycloak pod | `[]`    |

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
| `keycloak.extraArgs`                   | Additional arguments to pass to the Keycloak startup command                                                 | `[]`               |

### TLS Configuration

| Parameter                         | Description                                                                                            | Default                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------------------ | ------------------------------------------- |
| `tls.enabled`                     | Enable TLS/HTTPS support using custom certificates                                                     | `false`                                     |
| `tls.existingSecret`              | Name of existing secret containing TLS certificate and key (PEM format, keys: tls.crt, tls.key)        | `""`                                        |
| `tls.certificateFile`             | Path where the TLS certificate file will be mounted (internal)                                         | `"/opt/keycloak/certs/tls.crt"`             |
| `tls.certificateKeyFile`          | Path where the TLS certificate key file will be mounted (internal)                                     | `"/opt/keycloak/certs/tls.key"`             |
| `tls.certManager.enabled`         | Enable cert-manager integration for automatic certificate provisioning                                 | `false`                                     |
| `tls.certManager.issuerRef.name`  | Name of the cert-manager Issuer or ClusterIssuer                                                       | `""`                                        |
| `tls.certManager.issuerRef.kind`  | Kind of the cert-manager issuer (Issuer or ClusterIssuer)                                              | `ClusterIssuer`                             |
| `tls.certManager.issuerRef.group` | Group of the cert-manager issuer                                                                       | `cert-manager.io`                           |
| `tls.certManager.duration`        | Certificate duration (e.g., 2160h for 90 days)                                                         | `""`                                        |
| `tls.certManager.renewBefore`     | Time before expiry to renew certificate (e.g., 360h for 15 days)                                       | `""`                                        |
| `tls.certManager.commonName`      | Certificate common name (defaults to first dnsName if not specified)                                   | `""`                                        |
| `tls.certManager.dnsNames`        | List of DNS names for the certificate (uses ingress.hosts if not specified)                            | `[]`                                        |
| `tls.certManager.ipAddresses`     | List of IP addresses for the certificate                                                               | `[]`                                        |
| `tls.certManager.secretName`      | Name for the generated secret (defaults to `<fullname>-tls`)                                           | `""`                                        |
| `tls.certManager.usages`          | Certificate key usages                                                                                 | `["digital signature", "key encipherment"]` |
| `tls.certManager.annotations`     | Additional annotations for the Certificate resource                                                    | `{}`                                        |
| `tls.truststoreEnabled`           | Enable truststore for client certificate validation or outgoing HTTPS requests                         | `false`                                     |
| `tls.truststoreExistingSecret`    | Name of existing secret containing truststore file (Java Keystore format, default-key: truststore.jks) | `""`                                        |
| `tls.truststoreExistingSecretKey` | Key of the secret to get the trustStorePassword from                                                   | `"truststore.jks"`                          |
| `tls.truststorePassword`          | Password for the truststore (use with caution - consider using existing secret)                        | `""`                                        |
| `tls.truststoreFile`              | Path where the truststore file will be mounted (internal)                                              | `"/opt/keycloak/truststore/truststore.jks"` |

### Database Configuration

| Parameter                         | Description                                                                                                                   | Default         |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | --------------- |
| `database.type`                   | Database type (postgres, mysql, mariadb, mssql). Note: H2 databases are not supported due to readonly filesystem restrictions | `postgres`      |
| `database.host`                   | Database host (only used when not using embedded database)                                                                    | `""`            |
| `database.port`                   | Database port (only used when not using embedded database, defaults: postgres=5432, mysql/mariadb=3306, mssql=1433)           | `""`            |
| `database.schema`                 | Database schema                                                                                                               | `""`            |
| `database.urlProperties`          | Additional database url properties                                                                                            | `""`            |
| `database.name`                   | Database name (only used when not using embedded database)                                                                    | `keycloak`      |
| `database.username`               | Database username (only used when not using embedded database)                                                                | `keycloak`      |
| `database.password`               | Database password (only used when not using embedded database)                                                                | `""`            |
| `database.existingSecret`         | Name of existing secret for database credentials (only used when not using embedded database)                                 | `""`            |
| `database.secretKeys.passwordKey` | Name of key in existing secret for database password                                                                          | `"db-password"` |
| `database.secretKeys.usernameKey` | Name of key in existing secret for database username                                                                          | `"db-username"` |
| `database.jdbcParams`             | Additional JDBC parameters                                                                                                    | `""`            |

### Cache Configuration

| Parameter          | Description                        | Default |
| ------------------ | ---------------------------------- | ------- |
| `cache.stack`      | Cache stack (local, ispn, default) | `local` |
| `cache.configFile` | Custom cache configuration file    | `""`    |

### Realm Configuration

| Parameter          | Description                                                                            | Default |
| ------------------ | -------------------------------------------------------------------------------------- | ------- |
| `realm.import`     | Enable import of realms from /opt/keycloak/data/import (production mode must be false) | `false` |
| `realm.configFile` | Json config for initial realm configuration, mounted in /opt/keycloak/data/import      | `""`    |

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

| Parameter   | Description                                                                 | Default |
| ----------- |-----------------------------------------------------------------------------| ------- |
| `resources` | The resources to allocate for each container (including the InitContainers) | `{}`    |

### Persistence

| Parameter                   | Description                                        | Default             |
| --------------------------- | -------------------------------------------------- | ------------------- |
| `persistence.enabled`       | Enable persistence using Persistent Volume Claims  | `false`             |
| `persistence.storageClass`  | Persistent Volume storage class                    | `""`                |
| `persistence.annotations`   | Persistent Volume Claim annotations                | `{}`                |
| `persistence.size`          | Persistent Volume size                             | `1Gi`               |
| `persistence.accessModes`   | Persistent Volume access modes                     | `["ReadWriteOnce"]` |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`                |

### Metrics

| Parameter                                  | Description                                                                      | Default        |
| ------------------------------------------ | -------------------------------------------------------------------------------- | -------------- |
| `metrics.enabled`                          | Enable metrics endpoint on Keycloak                                              | `false`        |
| `metrics.service.type`                     | Metrics service type                                                             | `ClusterIP`    |
| `metrics.service.port`                     | Metrics service port                                                             | `9000`         |
| `metrics.service.targetPort`               | Metrics service target port                                                      | `http-metrics` |
| `metrics.service.annotations`              | Additional annotations for metrics service                                       | `{}`           |
| `metrics.service.labels`                   | Additional labels for metrics service                                            | `{}`           |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource for scraping metrics using PrometheusOperator     | `false`        |
| `metrics.serviceMonitor.namespace`         | Namespace in which ServiceMonitor is created                                     | `""`           |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped                                      | `30s`          |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                          | `""`           |
| `metrics.serviceMonitor.additionalLabels`  | Additional labels for ServiceMonitor                                             | `{}`           |
| `metrics.serviceMonitor.annotations`       | Additional annotations for ServiceMonitor                                        | `{}`           |
| `metrics.serviceMonitor.relabelings`       | RelabelConfigs to apply to samples before scraping                               | `[]`           |
| `metrics.serviceMonitor.metricRelabelings` | MetricRelabelConfigs to apply to samples before ingestion                        | `[]`           |
| `metrics.serviceMonitor.honorLabels`       | Specify honorLabels parameter to add the scrape endpoint                         | `false`        |
| `metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as the job name in Prometheus | `""`           |

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

### Scheduling

| Parameter                   | Description                                    | Default |
| --------------------------- | ---------------------------------------------- | ------- |
| `nodeSelector`              | Node labels for pod assignment                 | `{}`    |
| `tolerations`               | Toleration labels for pod assignment           | `[]`    |
| `affinity`                  | Affinity settings for pod assignment           | `{}`    |
| `topologySpreadConstraints` | Topology Spread Constraints for pod assignment | `[]`    |
| `priorityClassName`         | Priority class name for pod eviction           | `""`    |

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
| `extraEnvVars`       | Additional environment variables to set                                | `[]`    |
| `extraEnvVarsSecret` | Name of an existing secret containing additional environment variables | ``      |

### Extra Configuration Parameters

| Parameter      | Description                                       | Default |
| -------------- | ------------------------------------------------- | ------- |
| `extraObjects` | Array of extra objects to deploy with the release | `[]`    |

### Init Container Configuration

| Parameter                              | Description                                 | Default                                                                                  |
| -------------------------------------- | ------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `initContainers.waitForPostgres.image` | PostgreSQL init container image for waiting | `postgres:17.6@sha256:e6a4209d1a4893f2df3bdcde58f8926c3c929c4d51df90990ed1b36d83c1382a`  |
| `initContainers.waitForMariadb.image`  | MariaDB init container image for waiting    | `mariadb:12.0.2@sha256:03a03a6817bb9eaa21e5aed1b734d432ec3f80021f5a2de1795475f158217545` |

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

### Realm import

```yaml
realm:
  import: true
  configFile: |
    {
      "realm": "my-realm",
      "enabled": true
    }
```

### Using Custom Themes and Providers

The Keycloak deployment automatically mounts empty directories at `/opt/keycloak/themes` and `/opt/keycloak/providers`. You can use initContainers to copy custom themes and providers into these directories.

To disable this feature, set preserveThemes = true, preserveProviders = true. This will keep the original themes and providers respectively intact.

**Example: Adding custom themes and providers with an initContainer**

```yaml
# values-custom-themes.yaml
extraInitContainers:
  - name: add-custom-themes
    image: your-registry/keycloak-themes:latest
    imagePullPolicy: Always
    command:
      - sh
      - -c
      - |
        cp -r /themes/* /opt/keycloak/themes/
        cp -r /providers/* /opt/keycloak/providers/
    volumeMounts:
      - name: keycloak-themes
        mountPath: /opt/keycloak/themes
      - name: keycloak-providers
        mountPath: /opt/keycloak/providers
```

In this example:
- Create a Docker image containing your custom themes in `/themes` and providers in `/providers`
- The initContainer copies these files to the mounted volumes
- Keycloak will automatically detect and use them on startup

You can also use this approach to download themes/providers from external sources:

```yaml
extraInitContainers:
  - name: download-themes
    image: curlimages/curl:latest
    command:
      - sh
      - -c
      - |
        curl -L -o /tmp/theme.zip https://example.com/theme.zip
        unzip /tmp/theme.zip -d /opt/keycloak/themes/
    volumeMounts:
      - name: keycloak-themes
        mountPath: /opt/keycloak/themes
```

### Using Custom TLS Certificates

#### Option 1: Using cert-manager (Recommended)

Automatically provision and renew certificates using cert-manager:

```yaml
# values-tls-certmanager.yaml
tls:
  enabled: true
  certManager:
    enabled: true
    issuerRef:
      name: "letsencrypt-prod"
      kind: ClusterIssuer
    # dnsNames will be automatically populated from ingress.hosts if not specified
    dnsNames:
      - auth.yourdomain.com

keycloak:
  httpEnabled: false  # Disable HTTP when using TLS
  production: true
  hostname: "auth.yourdomain.com"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: auth.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
```

**Prerequisites:**
- cert-manager must be installed in your cluster
- A ClusterIssuer or Issuer must be configured (e.g., Let's Encrypt)

Install cert-manager if not already installed:

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml
```

Create a ClusterIssuer for Let's Encrypt:

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
      - http01:
          ingress:
            class: nginx
```

#### Option 2: Using Existing TLS Certificates

Use pre-existing certificates:

```yaml
# values-tls.yaml
tls:
  enabled: true
  existingSecret: "keycloak-tls-certs"

keycloak:
  httpEnabled: false  # Disable HTTP when using TLS
  production: true
  hostname: "auth.yourdomain.com"
```

Create the TLS secret first with your certificate and key in PEM format:

```bash
kubectl create secret tls keycloak-tls-certs \
  --cert=/path/to/certificate.pem \
  --key=/path/to/private-key.pem
```

#### Using Truststore for Client Certificates or Outgoing HTTPS

```yaml
# values-tls-truststore.yaml
tls:
  enabled: true
  existingSecret: "keycloak-tls-certs"
  truststoreEnabled: true
  truststoreExistingSecret: "keycloak-truststore"
  truststorePassword: "changeit"
```

Create the truststore secret:

```bash
kubectl create secret generic keycloak-truststore \
  --from-file=truststore.jks=/path/to/truststore.jks
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
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
