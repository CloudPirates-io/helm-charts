<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-ghost"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-ghost" /></a>
</p>


# Ghost Helm Chart

Ghost is a simple, powerful publishing platform for creating blogs and online publications. This Helm chart deploys Ghost on Kubernetes with optional MariaDB support.


## Installation

To install the chart with the release name `my-ghost`:

```bash
helm install my-ghost oci://registry-1.docker.io/cloudpirates/ghost
```

To install with custom values:

```bash
helm install my-ghost oci://registry-1.docker.io/cloudpirates/ghost -f my-values.yaml
```

The output should show you the URL's for your Ghost instance and Admin interface accoriding to your settings in my-values.yaml

```
URLS:
 1) Website: https://ghost.localhost
 2) Admin: https://admin.ghost.localhost/ghost
```

## Uninstalling

To uninstall/delete the `my-ghost` deployment:

```bash
helm uninstall my-ghost
```


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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/ghost:<version>
```


## Configuration

### External database support

If you want to use an external database (e.g., AWS RDS, DigitalOcean Managed Databases), you need to set the following values in your `my-values.yaml`:

```yaml
mariadb:
  enabled: false
config:
  database:
    client: "mysql"
    externalConnection:
      host: "ghost-mariadb"
      port: 3306
      user: "ghost"
      password: "changeme"
      database: "ghost"
    pool:
      min: 2
      max: 10
  ...
```


The following tables list the configurable parameters of the Ghost chart organized by category:

### Global & Common Parameters

| Parameter                 | Description                                  | Default |
| ------------------------- | -------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                 | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as array | `[]`    |
| `nameOverride`            | String to partially override ghost.fullname  | `""`    |
| `fullnameOverride`        | String to fully override ghost.fullname      | `""`    |
| `commonLabels`            | Labels to add to all deployed objects        | `{}`    |
| `commonAnnotations`       | Annotations to add to all deployed objects   | `{}`    |

### Image Parameters

| Parameter          | Description                        | Default     |
| ------------------ | ---------------------------------- | ----------- |
| `image.registry`   | Ghost image registry               | `docker.io` |
| `image.repository` | Ghost image repository             | `ghost`     |
| `image.tag`        | Ghost image tag                    | `6.0.9`     |
| `image.pullPolicy` | Ghost image pull policy            | `Always`    |
| `replicaCount`     | Number of Ghost replicas to deploy | `1`         |

### Network Parameters

| Parameter             | Description                         | Default                                                                                                                                   |
| --------------------- | ----------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| `containerPorts`      | List of container ports             | `[{name: http, containerPort: 2368}]`                                                                                                     |
| `service.type`        | Kubernetes service type             | `ClusterIP`                                                                                                                               |
| `service.ports`       | List of service ports               | `[{port: 80, targetPort: http}]`                                                                                                          |
| `ingress.enabled`     | Enable ingress record generation    | `true`                                                                                                                                    |
| `ingress.className`   | IngressClass for the ingress record | `""`                                                                                                                                      |
| `ingress.annotations` | Additional ingress annotations      | `{}`                                                                                                                                      |
| `ingress.hosts`       | List of ingress hosts               | `[{host: ghost.localhost, paths:[{path: /, pathType: Prefix}]}, {host: admin.ghost.localhost, paths:[{path: /ghost, pathType: Prefix}]}]` |
| `ingress.tls`         | TLS configuration for ingress       | `[]`                                                                                                                                      |

### Persistence Parameters

| Parameter                   | Description                     | Default           |
| --------------------------- | ------------------------------- | ----------------- |
| `persistence.enabled`       | Enable persistence using PVC    | `true`            |
| `persistence.annotations`   | Annotations for PVC             | `{}`              |
| `persistence.existingClaim` | Use an existing PVC             | `""`              |
| `persistence.storageClass`  | Storage class of backing PVC    | `""`              |
| `persistence.accessModes`   | PVC access modes                | `[ReadWriteOnce]` |
| `persistence.size`          | Size of persistent volume claim | `8Gi`             |

### Database Parameters

| Parameter                             | Description                              | Default    |
| ------------------------------------- | ---------------------------------------- | ---------- |
| `mariadb.enabled`                     | Deploy MariaDB as dependency             | `true`     |
| `mariadb.auth.database`               | MariaDB database name                    | `ghost`    |
| `mariadb.auth.username`               | MariaDB username                         | `ghost`    |
| `mariadb.auth.password`               | MariaDB password                         | `changeme` |
| `mariadb.auth.existingSecret`         | Existing secret with MariaDB credentials | `""`       |
| `mariadb.auth.allowEmptyRootPassword` | Allow empty root password                | `false`    |

### Pod Parameters

| Parameter                                           | Description                                | Default |
| --------------------------------------------------- | ------------------------------------------ | ------- |
| `resources`                                         | Resource limits and requests for pod       | `{}`    |
| `nodeSelector`                                      | Node selector for pod assignment           | `{}`    |
| `tolerations`                                       | Tolerations for pod assignment             | `[]`    |
| `affinity`                                          | Affinity for pod assignment                | `{}`    |
| `podSecurityContext.fsGroup`                        | Set pod's Security Context fsGroup         | `1000`  |
| `containerSecurityContext.runAsUser`                | Set container's Security Context runAsUser | `1000`  |
| `containerSecurityContext.runAsNonRoot`             | Run as non-root user                       | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation                 | `false` |

### Health Check Parameters

| Parameter                            | Description                       | Default     |
| ------------------------------------ | --------------------------------- | ----------- |
| `livenessProbe.enabled`              | Enable liveness probe             | `true`      |
| `livenessProbe.type`                 | Probe type (tcpSocket or httpGet) | `tcpSocket` |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds             | `30`        |
| `livenessProbe.periodSeconds`        | Period seconds                    | `10`        |
| `readinessProbe.enabled`             | Enable readiness probe            | `true`      |
| `readinessProbe.type`                | Probe type (tcpSocket or httpGet) | `tcpSocket` |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds             | `5`         |
| `readinessProbe.periodSeconds`       | Period seconds                    | `12`        |

### Init Container Parameters

| Parameter                             | Description                  | Default          |
| ------------------------------------- | ---------------------------- | ---------------- |
| `initContainers.waitForMariadb.image` | MariaDB init container image | `mariadb:12.0.2` |

### Autoscaling Parameters

| Parameter                                       | Description                | Default |
| ----------------------------------------------- | -------------------------- | ------- |
| `autoscaling.enabled`                           | Enable autoscaling         | `false` |
| `autoscaling.minReplicas`                       | Minimum number of replicas | `""`    |
| `autoscaling.maxReplicas`                       | Maximum number of replicas | `""`    |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization     | `""`    |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization  | `""`    |

### Additional Configuration

| Parameter           | Description                                | Default         |
| ------------------- | ------------------------------------------ | --------------- |
| `extraEnvVars`      | Additional environment variables           | `[]`            |
| `extraVolumes`      | Additional volumes                         | `[]`            |
| `extraVolumeMounts` | Additional volume mounts                   | `[]`            |
| `extraObjects`      | Extra Kubernetes objects to deploy         | `[]`            |
| `config`            | Ghost configuration (database, mail, etc.) | See values.yaml |


## Example: Custom Ghost Configuration
https://docs.ghost.org/config 

```yaml
config:
  database:
    client: "mysql"
    externalConnection:
      host: "ghost-mariadb"
      port: 3306
      user: "ghost"
      password: "changeme"
      database: "ghost"
    pool:
      min: 2
      max: 10
  mail:
    transport: "SMTP"
    options:
      service: "Mailgun"
      host: "smtp.mailgun.org"
      port: 465
      secure: true
      auth:
        user: "postmaster@example.mailgun.org"
        pass: "1234567890"
    from: "support@example.com"
  server:
    host: "0.0.0.0"
    port: 2368
  privacy:
    useUpdateCheck: false
    useGravatar: false
    useRpcPing: false
    useStructuredData: false
  security:
    staffDeviceVerification: false
  paths:
    contentPath: "content/"
  referrerPolicy: "origin-when-crossorigin"
  logging:
    path: "content/logs/"
    useLocalTime: true
    level: "info"
    rotation:
      enabled: true
      count: 10
      period: "1d"
    transports:
      - "stdout"
      - "file"
  caching:
    frontend:
      maxAge: 0
    contentAPI:
      maxAge: 10
    robotstxt:
      maxAge: 3600
    sitemap:
      maxAge: 3600
    sitemapXSL:
      maxAge: 86400
    wellKnown:
      maxAge: 86400
    cors:
      maxAge: 86400
    publicAssets:
      maxAge: 31536000
    threeHundredOne:
      maxAge: 31536000
    customRedirects:
      maxAge: 31536000
  compress: true
  imageOptimization:
    resize: false
  storage:
    active: "local-file-store"
  adapters:
    cache:
      imageSizes:
        adapter: "Redis"
        ttl: 3600
        keyPrefix: "image-sizes:"
  portal:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/portal@~{version}/umd/portal.min.js"
  sodoSearch:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/sodo-search@~{version}/umd/sodo-search.min.js"
    styles: "https://cdn.jsdelivr.net/npm/@tryghost/sodo-search@~{version}/umd/main.css"
  comments:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/comments-ui@~{version}/umd/comments-ui.min.js"
    styles: "https://cdn.jsdelivr.net/npm/@tryghost/comments-ui@~{version}/umd/main.css"
```


## Troubleshooting

### Connection Issues

1. **Check deployment and service status**:
  ```bash
  kubectl get deployment -l app.kubernetes.io/name=ghost
  kubectl get svc -l app.kubernetes.io/name=ghost
  kubectl get pods -l app.kubernetes.io/name=ghost
  ```
2. **Check pod logs**:
  ```bash
  kubectl logs <pod-name>
  ```

### Database Issues

- Ensure MariaDB is running and accessible if using the bundled database.
- Check database credentials in your values file.

### Performance Tuning

- Adjust resources in `values.yaml` for production workloads.
- Use persistent storage for content.
- Monitor pod health and logs for errors.


## Useful Links

- [Ghost Documentation](https://ghost.org/docs/)
- [Ghost Docker Hub](https://hub.docker.com/_/ghost)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
