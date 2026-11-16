# phpMyAdmin

phpMyAdmin is a free and open source administration tool for MySQL and MariaDB. It provides a web interface to manage databases, tables, columns, relations, indexes, users, permissions, etc. This Helm chart deploys phpMyAdmin on Kubernetes with comprehensive configuration options for development and production environments.

## Installing the Chart

To install the chart with the release name `my-phpmyadmin`:

```bash
helm install my-phpmyadmin oci://registry-1.docker.io/cloudpirates/phpmyadmin
```

To install with custom values:

```bash
helm install my-phpmyadmin oci://registry-1.docker.io/cloudpirates/phpmyadmin -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-phpmyadmin ./charts/phpmyadmin
```

## Uninstalling the Chart

To uninstall/delete the `my-phpmyadmin` deployment:

```bash
helm uninstall my-phpmyadmin
```

This removes all the Kubernetes components associated with the chart and deletes the release.

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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/phpmyadmin:<version>
```

## Configuration

### Connection Modes

phpMyAdmin supports multiple connection modes:

#### 1. Arbitrary Server Selection (Default)

Allow users to select the server to connect to at login time:

```yaml
config:
  auth:
    arbitrary: true
    cookieAuth: true
```

#### 2. Fixed Database Connection

Connect to a specific database server. **Important:** if `config.database.host` is empty, the phpMyAdmin image falls back to a hardcoded `db` hostname internally — always set `config.auth.arbitrary: false` together with a real `config.database.host`, never leave `host` empty with `arbitrary: false`.

```yaml
config:
  database:
    host: mariadb.default.svc.cluster.local
    port: 3306
    user: root
  auth:
    arbitrary: false
    cookieAuth: true
```

#### 3. Multiple Database Servers

Configure multiple servers by setting `absoluteUri` and using a custom config:

```yaml
config:
  database:
    absoluteUri: "https://phpmyadmin.example.com/"
  auth:
    arbitrary: true
```

### Configuration Parameters

The following table lists the configurable parameters of the phpMyAdmin chart and their default values.

#### Global Parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

#### Common Parameters

| Parameter           | Description                                              | Default |
| ------------------- | -------------------------------------------------------- | ------- |
| `nameOverride`      | String to partially override phpmyadmin.fullname         | `""`    |
| `fullnameOverride`  | String to fully override phpmyadmin.fullname             | `""`    |
| `namespaceOverride` | String to override the namespace for all resources       | `""`    |
| `commonLabels`      | Labels to add to all deployed objects                    | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects               | `{}`    |
| `podAnnotations`    | Annotations to add to the pods created by the deployment | `{}`    |
| `podLabels`         | Labels to add to the pods created by the deployment      | `{}`    |

#### Deployment Parameters

| Parameter      | Description                           | Default |
| -------------- | ------------------------------------- | ------- |
| `replicaCount` | Number of phpMyAdmin replicas         | `1`     |

#### phpMyAdmin Image Parameters

| Parameter           | Description                          | Default                       |
| ------------------- | ------------------------------------ | ----------------------------- |
| `image.registry`    | phpMyAdmin image registry            | `docker.io`                   |
| `image.repository`  | phpMyAdmin image repository          | `phpmyadmin`                  |
| `image.tag`         | phpMyAdmin image tag                 | `5.2.3-apache`                |
| `image.pullPolicy`  | phpMyAdmin image pull policy         | `Always`                      |

#### phpMyAdmin Configuration Parameters

| Parameter                            | Description                                                 | Default        |
| ------------------------------------- | ------------------------------------------------------------ | -------------- |
| `config.database.host`                | Database host (empty = show connection dialog)               | `""`            |
| `config.database.port`                | Database port                                                 | `3306`          |
| `config.database.user`                | Database default user (plain text)                            | `""`            |
| `config.database.userSecret`          | Secret name containing the database user (overrides `user`)  | `""`            |
| `config.database.userSecretKey`       | Key in Secret for the username                                 | `username`      |
| `config.database.password`            | Database default user password (plain text)                   | `""`            |
| `config.database.passwordSecret`      | Secret name containing the password (overrides `password`)     | `""`            |
| `config.database.passwordSecretKey`   | Key in Secret for the password                                  | `password`      |
| `config.database.absoluteUri`         | Absolute URI of phpMyAdmin installation                        | `""`            |
| `config.auth.arbitrary`               | Allow arbitrary server connection. Keep `true` unless `config.database.host` is set — otherwise the image's hardcoded `db` fallback hostname leaves you unable to log in | `true` |
| `config.auth.cookieAuth`              | Use cookie-based authentication                                 | `true`          |
| `config.control.user`                 | Control user for advanced features (plain text)                | `pma`           |
| `config.control.userSecret`           | Secret name containing the control user (overrides `user`)     | `""`            |
| `config.control.userSecretKey`        | Key in Secret for the control username                          | `username`      |
| `config.control.password`             | Control user password. **If left empty and `passwordSecret` is not set, a random 32-char password is auto-generated** and stored in a chart-managed Secret (`<release>-control`), preserved across upgrades | `""` |
| `config.control.passwordSecret`       | Secret name containing the control password. **Setting this disables auto-generation.** | `""` |
| `config.control.passwordSecretKey`    | Key in Secret for the control password                          | `password`      |
| `config.control.pmadb`                | Database for phpMyAdmin configuration storage                   | `phpmyadmin`    |
| `config.control.pmadbSecret`          | Secret name containing the pmadb name (overrides `pmadb`)        | `""`            |
| `config.control.pmadbSecretKey`       | Key in Secret for the pmadb name                                  | `database`      |
| `config.control.createTables`         | Auto-create the phpMyAdmin config storage tables via a post-install/upgrade Job (see caveat below) | `false` |
| `config.debug.verbose`                | Display verbose error messages                                    | `false`         |
| `config.debug.verboseCheck`           | Verify MySQL connection details                                   | `false`         |

#### PHP Configuration Parameters

| Parameter                  | Description                   | Default  |
| -------------------------- | ----------------------------- | -------- |
| `php.maxExecutionTime`     | Maximum script execution time | `300`    |
| `php.memoryLimit`          | PHP memory limit              | `256M`   |
| `php.postMaxSize`          | Maximum POST data size        | `16M`    |
| `php.uploadMaxFilesize`    | Maximum file upload size      | `16M`    |
| `php.displayErrors`        | Display PHP errors            | `Off`    |
| `php.logErrors`            | Log PHP errors                | `On`     |

#### Apache Configuration Parameters

| Parameter              | Description          | Default |
| ---------------------- | -------------------- | ------- |
| `apache.serverTokens`  | Apache ServerTokens  | `Prod`  |
| `apache.serverSignature` | Apache ServerSignature | `Off` |

#### Service Parameters

| Parameter         | Description            | Default     |
| ----------------- | ---------------------- | ----------- |
| `service.type`    | Kubernetes service type | `ClusterIP` |
| `service.port`    | Service port           | `80`        |

#### Ingress Parameters

| Parameter               | Description                                      | Default |
| ----------------------- | ------------------------------------------------ | ------- |
| `ingress.enabled`       | Enable ingress                                   | `false` |
| `ingress.className`     | IngressClass name                               | `""`    |
| `ingress.annotations`   | Additional annotations for Ingress               | `{}`    |
| `ingress.hosts`         | Ingress hostnames and paths                      | `[]`    |
| `ingress.tls`           | TLS configuration for Ingress                    | `[]`    |

#### Traefik IngressRoute Parameters

| Parameter                              | Description                      | Default |
| -------------------------------------- | -------------------------------- | ------- |
| `traefik.ingressRoute.enabled`         | Enable Traefik IngressRoute      | `false` |
| `traefik.ingressRoute.annotations`     | Additional annotations           | `{}`    |
| `traefik.ingressRoute.entryPoints`     | Traefik entry points             | `[web]` |
| `traefik.ingressRoute.hosts`           | Hostnames for IngressRoute       | `[]`    |
| `traefik.ingressRoute.tls.enabled`     | Enable TLS                       | `false` |
| `traefik.ingressRoute.tls.secretName`  | TLS certificate secret name      | `""`    |
| `traefik.ingressRoute.middlewares`     | Traefik middlewares to apply     | `[]`    |

#### Gateway API HTTPRoute Parameters

| Parameter                             | Description                      | Default |
| ------------------------------------- | -------------------------------- | ------- |
| `gatewayAPI.httpRoute.enabled`        | Enable Gateway API HTTPRoute     | `false` |
| `gatewayAPI.httpRoute.annotations`    | Additional annotations           | `{}`    |
| `gatewayAPI.httpRoute.parentRefs`     | References to parent Gateways    | `[]`    |
| `gatewayAPI.httpRoute.hostnames`      | Hostnames for HTTPRoute          | `[]`    |
| `gatewayAPI.httpRoute.rules`          | HTTPRoute rules                  | `[]`    |

#### Pod Disruption Budget Parameters

| Parameter          | Description                                       | Default |
| ------------------ | ------------------------------------------------- | ------- |
| `pdb.create`       | Enable Pod Disruption Budget                      | `false` |
| `pdb.minAvailable` | Minimum pods available                            | `""`    |
| `pdb.maxUnavailable` | Maximum pods unavailable                        | `""`    |

#### Security Context Parameters

| Parameter                              | Description                    | Default |
| -------------------------------------- | ------------------------------ | ------- |
| `containerSecurityContext.runAsUser`   | User ID to run container       | `33`    |
| `containerSecurityContext.runAsNonRoot` | Run as non-root               | `true`  |
| `podSecurityContext.fsGroup`           | Pod fsGroup                    | `33`    |

#### Resource Parameters

| Parameter                  | Description           | Default |
| -------------------------- | --------------------- | ------- |
| `resources.limits.cpu`     | CPU limit             | `""`    |
| `resources.limits.memory`  | Memory limit          | `""`    |
| `resources.requests.cpu`   | CPU request           | `""`    |
| `resources.requests.memory` | Memory request        | `""`    |

#### Other Parameters

| Parameter              | Description                                      | Default |
| ---------------------- | ------------------------------------------------ | ------- |
| `nodeSelector`         | Node selector for pod assignment                 | `{}`    |
| `tolerations`          | Tolerations for pod assignment                   | `[]`    |
| `affinity`             | Affinity rules for pod assignment                | `{}`    |
| `priorityClassName`    | Priority class for the pod                       | `""`    |
| `extraEnvVars`         | Additional environment variables                 | `[]`    |
| `extraVolumes`         | Additional volumes to add to pod                 | `[]`    |
| `extraVolumeMounts`    | Additional volume mounts                         | `[]`    |
| `extraObjects`         | Additional Kubernetes objects to deploy          | `[]`    |

## Example Deployments

### Basic Deployment with Arbitrary Server Selection

```yaml
replicaCount: 1

config:
  auth:
    arbitrary: true
    cookieAuth: true

resources:
  requests:
    cpu: 100m
    memory: 256Mi
  limits:
    memory: 512Mi
```

### Production Deployment with MariaDB

```yaml
replicaCount: 2

config:
  database:
    host: mariadb.database.svc.cluster.local
    port: 3306
    user: phpmyadmin
  auth:
    arbitrary: false
    cookieAuth: true
  control:
    user: pma_control
    pmadb: phpmyadmin

php:
  maxExecutionTime: 600
  memoryLimit: 512M
  postMaxSize: 64M
  uploadMaxFilesize: 64M

resources:
  requests:
    cpu: 200m
    memory: 512Mi
  limits:
    cpu: 500m
    memory: 1Gi

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: phpmyadmin.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: phpmyadmin-tls
      hosts:
        - phpmyadmin.example.com

pdb:
  create: true
  minAvailable: 1
```

### Traefik Deployment

```yaml
config:
  auth:
    arbitrary: true
  database:
    absoluteUri: "https://phpmyadmin.example.com/"

traefik:
  ingressRoute:
    enabled: true
    hosts:
      - phpmyadmin.example.com
    tls:
      enabled: true
      certResolver: letsencrypt
      secretName: phpmyadmin-tls
```

## Advanced Configuration

### Custom PHP Configuration

Mount custom PHP configuration via `configMap`:

```yaml
configMap:
  create: true
  data: |
    <?php
    $cfg['LoginCookieStore'] = 'db';
    $cfg['TempDir'] = '/tmp';
```

### Multiple Database Servers

Use the configMap to define multiple servers:

```yaml
configMap:
  create: true
  data: |
    <?php
    $i = 0;
    $i++;
    $cfg['Servers'][$i]['host'] = 'mariadb-primary';
    $cfg['Servers'][$i]['user'] = 'pma';
    $i++;
    $cfg['Servers'][$i]['host'] = 'mariadb-secondary';
    $cfg['Servers'][$i]['user'] = 'pma';
```

### Using Kubernetes Secrets

Every sensitive `config` field (`database.user`, `database.password`, `control.user`, `control.password`, `control.pmadb`) can be sourced from an existing Secret instead of plain text:

```yaml
config:
  database:
    host: mariadb
    userSecret: mariadb-credentials
    userSecretKey: username
    passwordSecret: mariadb-credentials
    passwordSecretKey: password
  control:
    userSecret: mariadb-credentials
    userSecretKey: username
    passwordSecret: mariadb-credentials
    passwordSecretKey: password
    pmadbSecret: mariadb-credentials
    pmadbSecretKey: database
```

### Auto-Generated Control Password

If `config.control.password` is left empty and `config.control.passwordSecret` is not set, the chart auto-generates a random 32-character password and stores it in a chart-managed Secret named `<release>-control`. This password is preserved across `helm upgrade` (it won't regenerate on every deploy). Retrieve it with:

```bash
kubectl get secret <release>-control -o jsonpath='{.data.password}' | base64 -d
```

Setting `config.control.passwordSecret` disables auto-generation entirely — the chart will not create its own Secret and will read from the one you provide instead.

### Auto-Creating the Configuration Storage Tables

By default, phpMyAdmin shows a "configuration storage is not completely configured" warning until its `create_tables.sql` has been run against the config-storage database once. Set `config.control.createTables: true` to have the chart run this automatically via a post-install/post-upgrade Job — it extracts `create_tables.sql` directly from the phpMyAdmin image and executes it using the `control.user`/`control.password` credentials.

```yaml
config:
  database:
    host: mariadb
  control:
    createTables: true
```

**Caveats:**
- Requires `config.database.host` to be set (not used in arbitrary-server mode).
- phpMyAdmin's `create_tables.sql` has the database name `phpmyadmin` hardcoded internally (`USE phpmyadmin;`), so this only creates tables in the right place if `config.control.pmadb` is left at its default (`phpmyadmin`). If you rename it, the tables will be created in a database literally named `phpmyadmin` regardless of what `pmadb` says.
- The control user must already have `CREATE TABLE` privileges on that database (e.g. granted via your MariaDB chart's `auth.database`/`auth.username`).

## Testing

Run the chart tests locally:

```bash
./test-charts.sh phpmyadmin
```

This will run all CI scenarios defined in `ci/` directory with verification jobs.

## License

Apache License 2.0
