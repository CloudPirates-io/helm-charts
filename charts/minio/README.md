<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-minio/minio"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-minio" /></a>
</p>

# MinIO

A Helm chart for MinIO - High Performance Object Storage compatible with Amazon S3 APIs. MinIO is a high-performance,
distributed object storage server designed for large-scale data infrastructure.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

## Installing the Chart

To install the chart with the release name `my-minio`:

```bash
helm install my-minio oci://registry-1.docker.io/cloudpirates/minio
```

To install with custom values:

```bash
helm install my-minio oci://registry-1.docker.io/cloudpirates/minio -f my-values.yaml
```

Or install directly from the local chart:

```bash
helm install my-minio ./charts/minio
```

The command deploys MinIO on the Kubernetes cluster in the default configuration. The [Configuration](#configuration)
section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-minio` deployment:

```bash
helm uninstall my-minio
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/minio:<version>
```

## Configuration

The following table lists the configurable parameters of the MinIO chart and their default values.

### Global parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### MinIO image configuration

| Parameter               | Description                                                                                                     | Default                                                                                                      |
| ----------------------- | --------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `image.registry`        | MinIO image registry                                                                                            | `docker.io`                                                                                                  |
| `image.repository`      | MinIO image repository                                                                                          | `minio/minio`                                                                                                |
| `image.tag`             | MinIO image tag (immutable tags are recommended)                                                                | `"RELEASE.2025-09-07T16-13-09Z@sha256:14cea493d9a34af32f524e538b8346cf79f3321eff8e708c1e2960462bd8936e"`     |
| `image.useCpuV1`        | image.useCpuV1 Use the Minio image tags suitable for old cpus (see https://github.com/minio/minio/issues/18365) | `false`                                                                                                      |
| `image.tagCpuV1`        | image.useCpuV1 Use the Minio image tags suitable for old cpus (see https://github.com/minio/minio/issues/18365) | `RELEASE.2025-09-07T16-13-09Z-cpuv1@sha256:13582eff79c6605a2d315bdd0e70164142ea7e98fc8411e9e10d089502a6d883` |
| `image.imagePullPolicy` | MinIO image pull policy                                                                                         | `IfNotPresent`                                                                                               |

### MinIO Authentication

| Parameter                        | Description                                                          | Default      |
| -------------------------------- | -------------------------------------------------------------------- | ------------ |
| `auth.rootUser`                  | MinIO root username                                                  | `"admin"`    |
| `auth.rootPassword`              | MinIO root password. If not set, a random password will be generated | `""`         |
| `auth.existingSecret`            | Name of existing secret containing MinIO credentials                 | `""`         |
| `auth.existingSecretUserKey`     | Key in existing secret containing username                           | `"user"`     |
| `auth.existingSecretPasswordKey` | Key in existing secret containing password                           | `"password"` |

### MinIO configuration

| Parameter                                | Description                                                                                                                                                                                           | Default |
| ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `config.region`                          | MinIO server default region                                                                                                                                                                           | `""`    |
| `config.browserEnabled`                  | Enable MinIO web browser                                                                                                                                                                              | `true`  |
| `config.domain`                          | MinIO server domain                                                                                                                                                                                   | `""`    |
| `config.serverUrl`                       | MinIO server URL for console                                                                                                                                                                          | `""`    |
| `config.minioOpts`                       | String of parameteres to use when starting the MinIO Server (example: '--console-address=":9001"')                                                                                                    | `""`    |
| `config.minioVolumes`                    | The directories or drives the minio server uses as the storage backend (example: '/mnt/drive1/minio')                                                                                                 | `""`    |
| `config.minioConfigEnvFile`              | Specifies the full path to the file the MinIO server process uses for loading environment variables                                                                                                   | `""`    |
| `config.minioScannerSpeed`               | Manage the maximum wait period for the scanner when balancing MinIO read/write performance to scanner processes (fastest, fast, default, slow, slowest)                                               | `""`    |
| `config.minioCompressionEnabled`         | Set to on to enable data compression for new objects. Defaults to off.                                                                                                                                | `""`    |
| `config.minioCompressionAllowEncryption` | Set to on to encrypt objects after compressing them. Defaults to off.                                                                                                                                 | `""`    |
| `config.minioCompressionExtensions`      | Comma-separated list of the file extensions to compress. Setting a new list of file extensions replaces the previously configured list. Defaults to "*"                                               | `""`    |
| `config.minioCompressionMimeTypes`       | Comma-separated list of the MIME types to compress. Setting a new list of types replaces the previously configured list. Defaults to "text/*, application/json, application/xml, binary/octet-stream" | `""`    |
| `config.extraEnvVars`                    | Extra environment variables to be set on MinIO containers                                                                                                                                             | `[]`    |

### Deployment configuration

| Parameter          | Description                                 | Default |
| ------------------ | ------------------------------------------- | ------- |
| `replicaCount`     | Number of MinIO replicas to deploy          | `1`     |
| `nameOverride`     | String to partially override minio.fullname | `""`    |
| `fullnameOverride` | String to fully override minio.fullname     | `""`    |

### Pod annotations and labels

| Parameter        | Description                           | Default |
| ---------------- | ------------------------------------- | ------- |
| `podAnnotations` | Map of annotations to add to the pods | `{}`    |
| `podLabels`      | Map of labels to add to the pods      | `{}`    |

### Security Context

| Parameter                                           | Description                                       | Default   |
| --------------------------------------------------- | ------------------------------------------------- | --------- |
| `podSecurityContext.fsGroup`                        | Group ID for the volumes of the pod               | `1000`    |
| `containerSecurityContext.allowPrivilegeEscalation` | Enable container privilege escalation             | `false`   |
| `containerSecurityContext.runAsNonRoot`             | Configure the container to run as a non-root user | `true`    |
| `containerSecurityContext.runAsUser`                | User ID for the MinIO container                   | `1000`    |
| `containerSecurityContext.runAsGroup`               | Group ID for the MinIO container                  | `1000`    |
| `containerSecurityContext.readOnlyRootFilesystem`   | Mount container root filesystem as read-only      | `true`    |
| `containerSecurityContext.capabilities.drop`        | Linux capabilities to be dropped                  | `["ALL"]` |

### Service configuration

| Parameter                   | Description                | Default     |
| --------------------------- | -------------------------- | ----------- |
| `service.type`              | MinIO service type         | `ClusterIP` |
| `service.port`              | MinIO service port         | `9000`      |
| `service.consolePort`       | MinIO console service port | `9090`      |
| `service.annotations`       | Service annotations        | `{}`        |
| `service.nodePorts.api`     | Service api node port      | `""`        |
| `service.nodePorts.console` | Service console node port  | `""`        |

### Ingress configuration

| Parameter                            | Description                                             | Default       |
| ------------------------------------ | ------------------------------------------------------- | ------------- |
| `ingress.enabled`                    | Enable ingress record generation for MinIO              | `false`       |
| `ingress.className`                  | IngressClass that will be used to implement the Ingress | `""`          |
| `ingress.annotations`                | Additional annotations for the Ingress resource         | `{}`          |
| `ingress.hosts[0].host`              | Hostname for MinIO ingress                              | `minio.local` |
| `ingress.hosts[0].paths[0].path`     | Path for MinIO ingress                                  | `/`           |
| `ingress.hosts[0].paths[0].pathType` | Path type for MinIO ingress                             | `Prefix`      |
| `ingress.tls`                        | TLS configuration for MinIO ingress                     | `[]`          |

### Console Ingress configuration

| Parameter                                   | Description                                             | Default               |
| ------------------------------------------- | ------------------------------------------------------- | --------------------- |
| `consoleIngress.enabled`                    | Enable ingress record generation for MinIO Console      | `false`               |
| `consoleIngress.className`                  | IngressClass that will be used to implement the Ingress | `""`                  |
| `consoleIngress.annotations`                | Additional annotations for the Console Ingress resource | `{}`                  |
| `consoleIngress.hosts[0].host`              | Hostname for MinIO Console ingress                      | `minio-console.local` |
| `consoleIngress.hosts[0].paths[0].path`     | Path for MinIO Console ingress                          | `/`                   |
| `consoleIngress.hosts[0].paths[0].pathType` | Path type for MinIO Console ingress                     | `Prefix`              |
| `consoleIngress.tls`                        | TLS configuration for MinIO Console ingress             | `[]`                  |

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
| `persistence.size`          | Persistent Volume size                             | `10Gi`              |
| `persistence.accessModes`   | Persistent Volume access modes                     | `["ReadWriteOnce"]` |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`                |

### Liveness and readiness probes

| Parameter                            | Description                               | Default |
| ------------------------------------ | ----------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable livenessProbe on MinIO containers  | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe   | `30`    |
| `livenessProbe.periodSeconds`        | Period seconds for livenessProbe          | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe         | `5`     |
| `livenessProbe.failureThreshold`     | Failure threshold for livenessProbe       | `3`     |
| `livenessProbe.successThreshold`     | Success threshold for livenessProbe       | `1`     |
| `readinessProbe.enabled`             | Enable readinessProbe on MinIO containers | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe  | `5`     |
| `readinessProbe.periodSeconds`       | Period seconds for readinessProbe         | `5`     |
| `readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe        | `3`     |
| `readinessProbe.failureThreshold`    | Failure threshold for readinessProbe      | `3`     |
| `readinessProbe.successThreshold`    | Success threshold for readinessProbe      | `1`     |
| `startupProbe.enabled`               | Enable startupProbe on MinIO containers   | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay seconds for startupProbe    | `10`    |
| `startupProbe.periodSeconds`         | Period seconds for startupProbe           | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout seconds for startupProbe          | `5`     |
| `startupProbe.failureThreshold`      | Failure threshold for startupProbe        | `30`    |
| `startupProbe.successThreshold`      | Success threshold for startupProbe        | `1`     |

### Node Selection

| Parameter      | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `nodeSelector` | Node labels for pod assignment       | `{}`    |
| `tolerations`  | Toleration labels for pod assignment | `[]`    |
| `affinity`     | Affinity settings for pod assignment | `{}`    |

### Extra Configuration Parameters

| Parameter      | Description                                                             | Default |
| -------------- | ----------------------------------------------------------------------- | ------- |
| `extraObjects` | A list of additional Kubernetes objects to deploy alongside the release | `[]`    |

#### Extra Objects

You can use the `extraObjects` array to deploy additional Kubernetes resources (such as NetworkPolicies, ConfigMaps,
etc.) alongside the release. This is useful for customizing your deployment with extra manifests that are not covered by
the default chart options.

**Helm templating is supported in any field, but all template expressions must be quoted.** For example, to use the
release namespace, write `namespace: "{{ .Release.Namespace }}"`.

**Example: Deploy a NetworkPolicy with templating**

```yaml
extraObjects:
  - apiVersion: networking.k8s.io/v1
    kind: NetworkPolicy
    metadata:
      name: allow-dns
      namespace: "{{ .Release.Namespace }}"
    spec:
      podSelector: { }
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

All objects in `extraObjects` will be rendered and deployed with the release. You can use any valid Kubernetes manifest,
and reference Helm values or built-in objects as needed (just remember to quote template expressions).

## Examples

### Basic Deployment

Deploy MinIO with default configuration:

```bash
helm install my-minio ./charts/minio
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
  rootUser: "minio-admin"
  rootPassword: "your-secure-password"

ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: minio.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: minio-tls
      hosts:
        - minio.yourdomain.com

consoleIngress:
  enabled: true
  className: "nginx"
  hosts:
    - host: minio-console.yourdomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: minio-console-tls
      hosts:
        - minio-console.yourdomain.com
```

Deploy with production values:

```bash
helm install my-minio ./charts/minio -f values-production.yaml
```

### Exposing a Bucket Publicly (“CDN Server” Setup)

You can make a MinIO bucket publicly accessible (e.g. as a CDN endpoint) using Ingress and MinIO's CLI tool (`mc`).
Below is an example configuration
and the commands needed to set this up.

#### 1. Install the Helm Chart with Public Ingress

Ensure the **Ingress controller** (like [ingress-nginx](https://kubernetes.github.io/ingress-nginx/)) is deployed in
your cluster.

Example `values.yaml` snippet for Helm install (replace `cdn.my-domain.local` and `my-bucket-name` with your own
values):

```yaml
ingress:
  enabled: true
  className: nginx
  annotations:
    # Uncomment if using cert-manager for TLS certificates
    # kubernetes.io/tls-acme: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /my-bucket-name/$1
    nginx.ingress.kubernetes.io/use-regex: "true"
  hosts:
    - host: cdn.my-domain.local
      paths:
        - path: /(.*)
          pathType: ImplementationSpecific
  # Uncomment and configure for TLS
  # tls:
  #   - secretName: minio-ingress-tls
  #     hosts:
  #       - cdn.my-domain.local
```

Install or upgrade the chart with:

```bash
helm install my-minio <chart> -f values.yaml
# Or, if upgrading:
# helm upgrade my-minio <chart> -f values.yaml
```

#### 2. Configure Your Bucket for Public Access

You need the [MinIO Client (`mc`)](https://min.io/docs/minio/linux/reference/minio-mc.html) to manage bucket policies.
You can access `mc` directly in the MinIO pod:

```bash
kubectl exec -it -n <NAMESPACE> <MINIO_POD_NAME> -- bash
```

Inside the pod, configure as follows (replace `my-bucket-name` as needed):

1. **Set up access alias** (for local MinIO within pod):

    ```bash
    mc alias set local http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
    ```

2. **Create your bucket** (skip if already exists):

    ```bash
    mc mb local/my-bucket-name
    ```

3. Create a custom policy in `/tmp/policy.json` to only allow `GetObject`, alternatively use the predefined `download`
   policy:
    ```bash
    echo '
    {
      "Statement": [
        {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Principal": {
          "AWS": [
          "*"
          ]
        },
        "Resource": [
          "arn:aws:s3:::my-bucket-name/*"
        ]
        }
      ],
      "Version": "2012-10-17"
    }' > /tmp/policy.yaml
    ```
4. **Set bucket policy**:

    ```bash
    # Set to download (allow get and list objects)
    mc anonymous set download local/my-bucket-name

    # Set to custom policy (allow only get objects)
    mc anonymous set-json /tmp/policy.json local/my-bucket-name
    ```

**Summary:**  
After these steps, your bucket (`my-bucket-name`) will be accessible via `https://cdn.my-domain.local/<object>` (if
using TLS), and is publicly readable.

### Using Existing Secret for Credentials

```yaml
# values-external-secret.yaml
auth:
  existingSecret: "minio-credentials"
  existingSecretUserKey: "username"
  existingSecretPasswordKey: "password"
```

Create the secret first:

```bash
kubectl create secret generic minio-credentials \
  --from-literal=username=minio-admin \
  --from-literal=password=your-secure-password
```

## Access MinIO

### Via kubectl port-forward

```bash
# Access MinIO API
kubectl port-forward service/my-minio 9000:9000

# Access MinIO Console
kubectl port-forward service/my-minio-console 9090:9090
```

### Default Credentials

- **Username**: `admin` (or value from `auth.rootUser`)
- **Password**: Check secret for auto-generated password or use configured value

Get the auto-generated password:

```bash
kubectl get secret my-minio -o jsonpath="{.data.root-password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with permission errors**

    - Ensure your storage class supports the required access modes
    - Check if security contexts are compatible with your cluster policies

2. **Cannot access MinIO console**

    - Verify the console service is running: `kubectl get svc`
    - Check if ingress is properly configured
    - Ensure firewall rules allow access to port 9090

3. **Persistent volume not mounting**
    - Verify storage class exists: `kubectl get storageclass`
    - Check PVC status: `kubectl get pvc`
    - Review pod events: `kubectl describe pod <pod-name>`

### Getting Support

For issues related to this Helm chart, please check:

- [MinIO Documentation](https://docs.min.io/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
