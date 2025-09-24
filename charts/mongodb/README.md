<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-mongodb"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-mongodb" /></a>
</p>

# MongoDB

A flexible NoSQL database for scalable, real-time data management.

## Description

This Helm chart provides a complete MongoDB StatefulSet deployment solution with persistent storage, authentication, health checks, and security configurations. It uses the official `mongo` Docker image and supports various deployment scenarios from development to production environments.

## Features

- **Official MongoDB Image**: Uses the official `mongo` Docker image from Docker Hub
- **Authentication**: Configurable MongoDB authentication with root user credentials
- **Persistent Storage**: Automatic persistent volume management through StatefulSet volumeClaimTemplates
- **Security**: Non-root container execution with proper security contexts
- **Health Checks**: Liveness and readiness probes using mongosh
- **Flexible Configuration**: Comprehensive configuration options for various deployment needs
- **Service Account**: RBAC-ready with configurable service account
- **Resource Management**: Configurable CPU and memory limits/requests

## Installing the Chart

To install the chart with the release name `my-mongodb`:

```bash
helm install my-mongodb oci://registry-1.docker.io/cloudpirates/mongodb
```

To install with custom values:

```bash
helm install my-mongodb oci://registry-1.docker.io/cloudpirates/mongodb -f my-values.yaml
```

## Uninstalling the Chart

To uninstall/delete the `my-mongodb` deployment:

```bash
helm delete my-mongodb
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/mongodb:<version>
```

## Configuration

The following table lists the configurable parameters of the MongoDB chart and their default values.

### Global Parameters

| Parameter          | Description                                   | Default |
| ------------------ | --------------------------------------------- | ------- |
| `replicaCount`     | Number of MongoDB replicas to deploy          | `1`     |
| `nameOverride`     | String to partially override mongodb.fullname | `""`    |
| `fullnameOverride` | String to fully override mongodb.fullname     | `""`    |

### Image Parameters

| Parameter          | Description                     | Default                                                                     |
| ------------------ | ------------------------------- | --------------------------------------------------------------------------- |
| `image.repository` | MongoDB Docker image repository | `mongo`                                                                     |
| `image.tag`        | MongoDB Docker image tag        | `"8.0.12"`                                                                  |
| `image.digest`     | MongoDB Docker image digest     | `"sha256:a6bda40d00e56682aeaa1bfc88e024b7dd755782c575c02760104fe02010f94f"` |
| `image.pullPolicy` | MongoDB image pull policy       | `IfNotPresent`                                                              |

### Service Parameters

| Parameter      | Description             | Default     |
| -------------- | ----------------------- | ----------- |
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | MongoDB service port    | `27017`     |

### MongoDB Configuration Parameters

| Parameter                        | Description                                                         | Default |
| -------------------------------- | ------------------------------------------------------------------- | ------- |
| `auth.enabled`                   | Enable MongoDB authentication                                       | `true`  |
| `auth.rootUsername`              | MongoDB root username                                               | `admin` |
| `auth.rootPassword`              | MongoDB root password (if empty, random password will be generated) | `""`    |
| `auth.existingSecret`            | Name of existing secret containing MongoDB password                 | `""`    |
| `auth.existingSecretPasswordKey` | Key in existing secret containing MongoDB password                  | `""`    |
| `config`                         | MongoDB configuration options                                       | `{}`    |

### Custom User Configuration
| Parameter                   | Description                                                                        | Default                                  |
| --------------------------- | ---------------------------------------------------------------------------------- | ---------------------------------------- |
| `customUser`                | Optional user to be created at initialisation with a custom password and database  | `{}`                                     |
| `customUser.name`           | Name of the custom user to be created                                              | `""`                                     |
| `customUser.database`       | Name of the database to be created                                                 | `""`                                     |
| `customUser.password`       | Password to be used for the custom user                                            | `""`                                     |
| `customUser.existingSecret` | Existing secret, in which username, password and database name are saved           | `""`                                     |
| `customUser.secretKeys`     | Name of keys in existing secret to use the custom user name, password and database | `{name: "", database: "", password: ""}` |

### Persistence Parameters

| Parameter                  | Description                                | Default         |
| -------------------------- | ------------------------------------------ | --------------- |
| `persistence.enabled`      | Enable persistent storage                  | `true`          |
| `persistence.storageClass` | Storage class to use for persistent volume | `""`            |
| `persistence.accessMode`   | Access mode for persistent volume          | `ReadWriteOnce` |
| `persistence.size`         | Size of persistent volume                  | `8Gi`           |
| `persistence.mountPath`    | Mount path for MongoDB data                | `/data/db`      |
| `persistence.annotations`  | Annotations for persistent volume claims   | `{}`            |

### Resource Parameters

| Parameter      | Description                                  | Default |
| -------------- | -------------------------------------------- | ------- |
| `resources`    | Resource limits and requests for MongoDB pod | `{}`    |
| `nodeSelector` | Node selector for pod assignment             | `{}`    |
| `tolerations`  | Tolerations for pod assignment               | `[]`    |
| `affinity`     | Affinity rules for pod assignment            | `{}`    |

### Security Parameters

| Parameter                      | Description                       | Default |
| ------------------------------ | --------------------------------- | ------- |
| `securityContext.fsGroup`      | Group ID for filesystem ownership | `999`   |
| `securityContext.runAsUser`    | User ID to run the container      | `999`   |
| `securityContext.runAsNonRoot` | Run as non-root user              | `true`  |
| `podSecurityContext`           | Security context for the pod      | `{}`    |

### Health Check Parameters

| Parameter                            | Description                                     | Default |
| ------------------------------------ | ----------------------------------------------- | ------- |
| `livenessProbe.enabled`              | Enable liveness probe                           | `true`  |
| `livenessProbe.initialDelaySeconds`  | Initial delay before starting probes            | `30`    |
| `livenessProbe.periodSeconds`        | How often to perform the probe                  | `10`    |
| `livenessProbe.timeoutSeconds`       | Timeout for each probe attempt                  | `5`     |
| `livenessProbe.failureThreshold`     | Number of failures before pod is restarted      | `6`     |
| `livenessProbe.successThreshold`     | Number of successes to mark probe as successful | `1`     |
| `readinessProbe.enabled`             | Enable readiness probe                          | `true`  |
| `readinessProbe.initialDelaySeconds` | Initial delay before starting probes            | `5`     |
| `readinessProbe.periodSeconds`       | How often to perform the probe                  | `10`    |
| `readinessProbe.timeoutSeconds`      | Timeout for each probe attempt                  | `5`     |
| `readinessProbe.failureThreshold`    | Number of failures before pod is marked unready | `6`     |
| `readinessProbe.successThreshold`    | Number of successes to mark probe as successful | `1`     |

### Additional Parameters

| Parameter           | Description                                              | Default |
| ------------------- | -------------------------------------------------------- | ------- |
| `extraEnv`          | Additional environment variables to set                  | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod                     | `[]`    |
| `extraVolumeMounts` | Additional volume mounts to add to the MongoDB container | `[]`    |
| `extraObjects`      | Additional Kubernetes objects to deploy                  | `[]`    |

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

## Example Values

### Basic Installation with Authentication

```yaml
mongodb:
  auth:
    enabled: true
    rootUsername: admin
    rootPassword: "mySecretPassword"

persistence:
  enabled: true
  size: 20Gi
```

### Production Setup with Resources

```yaml
replicaCount: 1

resources:
  limits:
    cpu: 2000m
    memory: 4Gi
  requests:
    cpu: 1000m
    memory: 2Gi

persistence:
  enabled: true
  storageClass: "default"
  size: 100Gi

mongodb:
  auth:
    enabled: true
    rootUsername: admin
    existingSecret: mongodb-credentials
    existingSecretPasswordKey: password
```

### Development Setup (No Persistence)

```yaml
persistence:
  enabled: false

mongodb:
  auth:
    enabled: false

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

## Accessing MongoDB

### Get Connection Information

Once the chart is deployed, you can get the MongoDB connection details:

```bash
# Get the MongoDB password (if auto-generated)
kubectl get secret --namespace default my-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode

# Connect to MongoDB
kubectl run --namespace default my-mongodb-client --rm --tty -i --restart='Never' --image mongo:7.0 --command -- mongosh admin --host my-mongodb --authenticationDatabase admin -u admin -p [PASSWORD]
```

### Port Forward (for local access)

```bash
kubectl port-forward --namespace default svc/my-mongodb 27017:27017
```

Then connect using:

```bash
mongosh --host 127.0.0.1 --port 27017 --authenticationDatabase admin -u admin -p [PASSWORD]
```

## Upgrading

To upgrade the MongoDB deployment:

```bash
helm upgrade my-mongodb ./mongodb -f my-values.yaml
```
