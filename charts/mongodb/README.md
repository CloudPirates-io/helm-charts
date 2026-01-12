<p align="center">
    <a href="https://artifacthub.io/packages/helm/cloudpirates-mongodb/mongodb"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-mongodb" /></a>
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

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common Parameters

| Parameter              | Description                                                | Default         |
| ---------------------- | ---------------------------------------------------------- | --------------- |
| `nameOverride`         | String to partially override mongodb.fullname              | `""`            |
| `fullnameOverride`     | String to fully override mongodb.fullname                  | `""`            |
| `commonLabels`         | Labels to add to all deployed objects                      | `{}`            |
| `commonAnnotations`    | Annotations to add to all deployed objects                 | `{}`            |
| `podAnnotations`       | Annotations to add to the pod created by the statefulset   | `{}`            |
| `podLabels`            | Labels to add to the pod created by the statefulset        | `{}`            |
| `revisionHistoryLimit` | Maximum number of revisions maintained in revision history | `10`            |
| `podManagementPolicy`  | Pod management policy                                      | `OrderedReady`  |
| `updateStrategyType`   | Pod update strategy                                        | `RollingUpdate` |

### MongoDB Image Parameters

| Parameter          | Description                                                       | Default                                                                           |
| ------------------ | ----------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `image.registry`   | MongoDB image registry                                            | `docker.io`                                                                       |
| `image.repository` | MongoDB image repository                                          | `mongo`                                                                           |
| `image.tag`        | MongoDB image tag                                                 | `"8.2.1@sha256:86835e8da0f94efd61334decb320fa43e8a60027688cbd856bf29d065b470338"` |
| `image.pullPolicy` | MongoDB image pull policy                                         | `Always`                                                                          |
| `image.extraArgs`  | Override default container args (useful when using custom images) | `[]`                                                                              |

### Replica Configuration

| Parameter      | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `replicaCount` | Number of MongoDB replicas to deploy | `1`     |

### Service Parameters

| Parameter                       | Description                               | Default     |
| ------------------------------- | ----------------------------------------- | ----------- |
| `service.type`                  | Kubernetes service type                   | `ClusterIP` |
| `service.port`                  | MongoDB service port                      | `27017`     |
| `service.annotations`           | Annotations to add to the mongodb service | `{}`        |
| `service.headlessServiceSuffix` |                                           | `headless`  |

### MongoDB Authentication Parameters

| Parameter                        | Description                                                         | Default |
| -------------------------------- | ------------------------------------------------------------------- | ------- |
| `auth.enabled`                   | Enable MongoDB authentication                                       | `true`  |
| `auth.rootUsername`              | MongoDB root username                                               | `admin` |
| `auth.rootPassword`              | MongoDB root password (if empty, random password will be generated) | `""`    |
| `auth.existingSecret`            | Name of existing secret containing MongoDB password                 | `""`    |
| `auth.existingSecretPasswordKey` | Key in existing secret containing MongoDB password                  | `""`    |

### MongoDB Configuration Parameters

| Parameter                     | Description                                                  | Default                                                              |
| ----------------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------- |
| `config.mountPath`            | MongoDB configuration options                                | `/etc/mongo`                                                         |
| `config.content`              | Include your custom MongoDB configurations here as string    | `systemLog:\n  quiet: true\n  verbosity: 0\nnet:\n  bindIpAll: true` |
| `config.existingConfigmap`    | Name of an existing Configmap to use instead of creating one | `""`                                                                 |
| `config.existingConfigmapKey` | Name of the key in the Configmap that should be used         | `""`                                                                 |

### Custom User Configuration

| Parameter                        | Description                                                              | Default |
| -------------------------------- | ------------------------------------------------------------------------ | ------- |
| `customUser.name`                | Name of the custom user to be created                                    | `""`    |
| `customUser.database`            | Name of the database to be created                                       | `""`    |
| `customUser.password`            | Password to be used for the custom user                                  | `""`    |
| `customUser.existingSecret`      | Existing secret, in which username, password and database name are saved | `""`    |
| `customUser.secretKeys.name`     | Name of key in existing secret containing username                       | `""`    |
| `customUser.secretKeys.password` | Name of key in existing secret containing password                       | `""`    |
| `customUser.secretKeys.database` | Name of key in existing secret containing database                       | `""`    |

### Persistence Parameters

| Parameter                   | Description                                        | Default         |
| --------------------------- | -------------------------------------------------- | --------------- |
| `persistence.enabled`       | Enable persistent storage                          | `true`          |
| `persistence.storageClass`  | Storage class to use for persistent volume         | `""`            |
| `persistence.accessMode`    | Access mode for persistent volume                  | `ReadWriteOnce` |
| `persistence.size`          | Size of persistent volume                          | `8Gi`           |
| `persistence.mountPath`     | Mount path for MongoDB data                        | `/data/db`      |
| `persistence.annotations`   | Annotations for persistent volume claims           | `{}`            |
| `persistence.labels`        | Labels for persistent volume claims                | `{}`            |
| `persistence.existingClaim` | The name of an existing PVC to use for persistence | `""`            |
| `persistence.subPath`       | The subdirectory of the volume to mount to         | `""`            |

### Resource Parameters

| Parameter      | Description                                  | Default                                                        |
| -------------- | -------------------------------------------- | -------------------------------------------------------------- |
| `resources`    | Resource limits and requests for MongoDB pod | `limits: {memory: 512Mi}, requests: {cpu: 50m, memory: 512Mi}` |
| `nodeSelector` | Node selector for pod assignment             | `{}`                                                           |
| `tolerations`  | Tolerations for pod assignment               | `[]`                                                           |
| `affinity`     | Affinity rules for pod assignment            | `{}`                                                           |

### Security Parameters

| Parameter                                           | Description                                  | Default |
| --------------------------------------------------- | -------------------------------------------- | ------- |
| `containerSecurityContext.runAsUser`                | User ID to run the container                 | `999`   |
| `containerSecurityContext.runAsNonRoot`             | Run as non-root user                         | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Set MongoDB container's privilege escalation | `false` |
| `podSecurityContext.fsGroup`                        | Set MongoDB pod's Security Context fsGroup   | `999`   |

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
| `startupProbe.enabled`               | Enable startup probe                            | `true`  |
| `startupProbe.initialDelaySeconds`   | Initial delay before starting probes            | `10`    |
| `startupProbe.timeoutSeconds`        | Timeout for each probe attempt                  | `5`     |
| `startupProbe.failureThreshold`      | Number of failures before pod is marked unready | `30`    |
| `startupProbe.successThreshold`      | Number of successes to mark probe as successful | `1`     |
| `startupProbe.periodSeconds`         | How often to perform the probe                  | `10`    |

### Additional Parameters

| Parameter           | Description                                              | Default |
| ------------------- | -------------------------------------------------------- | ------- |
| `extraEnvVars`      | Additional environment variables to set                  | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod                     | `[]`    |
| `extraVolumeMounts` | Additional volume mounts to add to the MongoDB container | `[]`    |
| `extraObjects`      | Array of extra objects to deploy with the release        | `[]`    |

### Network Policy Parameters

| Parameter                      | Description                                  | Default |
| ------------------------------ | -------------------------------------------- | ------- |
| `networkPolicy.enabled`        | Enable NetworkPolicy for MongoDB and metrics | `false` |
| `networkPolicy.allowedSources` | List of allowed sources for network policy   | `[]`    |

### Metrics Parameters

| Parameter                          | Description                                                         | Default                                                                                                                              |
| ---------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `metrics.enabled`                  | Enable metrics collection                                           | `false`                                                                                                                              |
| `metrics.username`                 | Username for metrics collection (defaults to root if not specified) | `""`                                                                                                                                 |
| `metrics.image.registry`           | MongoDB Exporter image registry                                     | `docker.io`                                                                                                                          |
| `metrics.image.repository`         | MongoDB Exporter image repository                                   | `percona/mongodb_exporter`                                                                                                           |
| `metrics.image.tag`                | MongoDB Exporter image tag                                          | `0.47.2`                                                                                                                             |
| `metrics.image.pullPolicy`         | MongoDB Exporter image pull policy                                  | `IfNotPresent`                                                                                                                       |
| `metrics.resources`                | Resource limits and requests for metrics container                  | `limits: { memory: 256Mi }, requests: { cpu: 10m, memory: 64Mi }`                                                                    |
| `metrics.containerSecurityContext` | Security context for metrics container                              | `runAsUser: 65534, runAsNonRoot: true, allowPrivilegeEscalation: false, readOnlyRootFilesystem: true, capabilities: { drop: [ALL] }` |

### Metrics Service Parameters

| Parameter                     | Description                                | Default        |
| ----------------------------- | ------------------------------------------ | -------------- |
| `metrics.service.type`        | Metrics service type                       | `ClusterIP`    |
| `metrics.service.port`        | Metrics service port                       | `9216`         |
| `metrics.service.targetPort`  | Metrics service target port                | `http-metrics` |
| `metrics.service.annotations` | Additional annotations for metrics service | `{}`           |
| `metrics.service.labels`      | Additional labels for metrics service      | `{}`           |

### ServiceMonitor Parameters

| Parameter                                  | Description                                                                  | Default |
| ------------------------------------------ | ---------------------------------------------------------------------------- | ------- |
| `metrics.serviceMonitor.enabled`           | Create ServiceMonitor resource for scraping metrics                          | `false` |
| `metrics.serviceMonitor.namespace`         | Namespace in which ServiceMonitor is created                                 | `""`    |
| `metrics.serviceMonitor.interval`          | Interval at which metrics should be scraped                                  | `30s`   |
| `metrics.serviceMonitor.scrapeTimeout`     | Timeout after which the scrape is ended                                      | `""`    |
| `metrics.serviceMonitor.additionalLabels`  | Additional labels for ServiceMonitor                                         | `{}`    |
| `metrics.serviceMonitor.annotations`       | Additional annotations for ServiceMonitor                                    | `{}`    |
| `metrics.serviceMonitor.relabelings`       | RelabelConfigs to apply to samples before scraping                           | `[]`    |
| `metrics.serviceMonitor.metricRelabelings` | MetricRelabelConfigs to apply to samples before ingestion                    | `[]`    |
| `metrics.serviceMonitor.honorLabels`       | Specify honorLabels parameter to add the scrape endpoint                     | `false` |
| `metrics.serviceMonitor.jobLabel`          | The name of the label on the target service to use as job name in Prometheus | `""`    |

### Metrics Liveness Probe Parameters

| Parameter                                   | Description                                      | Default |
| ------------------------------------------- | ------------------------------------------------ | ------- |
| `metrics.livenessProbe.enabled`             | Enable liveness probe for metrics container      | `true`  |
| `metrics.livenessProbe.initialDelaySeconds` | Initial delay before starting liveness probes    | `15`    |
| `metrics.livenessProbe.periodSeconds`       | How often to perform the liveness probe          | `10`    |
| `metrics.livenessProbe.timeoutSeconds`      | Timeout for each liveness probe attempt          | `5`     |
| `metrics.livenessProbe.failureThreshold`    | Number of failures before container is restarted | `3`     |
| `metrics.livenessProbe.successThreshold`    | Number of successes to mark probe as successful  | `1`     |

### Metrics Readiness Probe Parameters

| Parameter                                    | Description                                           | Default |
| -------------------------------------------- | ----------------------------------------------------- | ------- |
| `metrics.readinessProbe.enabled`             | Enable readiness probe for metrics container          | `true`  |
| `metrics.readinessProbe.initialDelaySeconds` | Initial delay before starting readiness probes        | `5`     |
| `metrics.readinessProbe.periodSeconds`       | How often to perform the readiness probe              | `10`    |
| `metrics.readinessProbe.timeoutSeconds`      | Timeout for each readiness probe attempt              | `5`     |
| `metrics.readinessProbe.failureThreshold`    | Number of failures before container is marked unready | `3`     |
| `metrics.readinessProbe.successThreshold`    | Number of successes to mark readiness as successful   | `1`     |

### Metrics Additional Parameters

| Parameter              | Description                                            | Default |
| ---------------------- | ------------------------------------------------------ | ------- |
| `metrics.extraEnvVars` | Additional environment variables for metrics container | `[]`    |
| `metrics.extraArgs`    | Additional command line arguments for MongoDB Exporter | `[]`    |

### Service Account Parameters

| Parameter                    | Description                                                                                                            | Default |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`      | Specifies whether a service account should be created                                                                  | `false` |
| `serviceAccount.annotations` | Annotations to add to the service account                                                                              | `{}`    |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`    |

### Init Container Parameters

| Parameter                 | Description                                  | Default |
| ------------------------- | -------------------------------------------- | ------- |
| `initContainer.resources` | Resource limits and requests for the arbiter | `{}`    |

### Replica Set Parameters

| Parameter                  | Description                                                                                                            | Default         |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------- |
| `replicaSet.enabled`       | Enables replica set deployment mode                                                                                    | `false`         |
| `replicaSet.name`          | Replica set name                                                                                                       | `"repl"`        |
| `replicaSet.key`           | Key for internal replica set authentication (base64 encoded string 6-1024 chars.)                                      |                 |
| `replicaSet.keySecretName` | Alternative to 'key' - Name of an existing secret with a file named "keyfile" containing the base64 encoded key string |                 |
| `replicaSet.clusterDomain` | Default Kubernetes cluster domain                                                                                      | `cluster.local` |
| `replicaSet.secondaries`   | Number of secondary instances (should be at least 2 - or - one secondary and an arbiter)                               | `2`             |

### Replica Set Hidden Secondaries Parameters

| Parameter                                                                   | Description                                                                                                                                             | Default                   |
| --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| `replicaSet.hiddenSecondaries.instances`                                    | Number of hidden secondary instances                                                                                                                    | `0`                       |
| `replicaSet.hiddenSecondaries.headlessServiceSuffix`                        | Suffix of the headless service name for hidden secondary instances                                                                                      | `hidden`                  |
| `replicaSet.hiddenSecondaries.nodeSelector`                                 | Additional node selector                                                                                                                                | `{}`                      |
| `replicaSet.hiddenSecondaries.resources`                                    | Resource limits and requests for the hidden secondary instance                                                                                          | `{}`                      |
| `replicaSet.hiddenSecondaries.tolerations`                                  | Pod tolerations                                                                                                                                         | `[]`                      |
| `replicaSet.hiddenSecondaries.affinity`                                     | Pod affinity                                                                                                                                            | `{}`                      |
| `replicaSet.hiddenSecondaries.topologySpreadConstraints`                    | Topology spread constraints for pods                                                                                                                    | `{}`                      |
| `replicaSet.hiddenSecondaries.storage.persistentVolumeClaimName`            | Set persistentVolumenClaimName to reference an existing PVC                                                                                             |                           |
| `replicaSet.hiddenSecondaries.storage.persistentVolumeClaimRetentionPolicy` | Set persistentVolumeClaimRetentionPolicy to explicitly control how PVCs are managed when a stateful set is scaled or deleted. (new feature in k8s 1.32) |                           |
| `replicaSet.hiddenSecondaries.storage.volumeName`                           | Internal volume name and prefix of a created PVC                                                                                                        | `"mongodb-hidden-volume"` |
| `replicaSet.hiddenSecondaries.storage.requestedSize`                        | Alternative set requestedSize to define a size for a dynamically created PVC                                                                            | `8Gi`                     |
| `replicaSet.hiddenSecondaries.storage.className`                            | The storage class name                                                                                                                                  |                           |
| `replicaSet.hiddenSecondaries.storage.accessModes`                          | Default access mode (ReadWriteOnce)                                                                                                                     | `ReadWriteOnce`           |
| `replicaSet.hiddenSecondaries.storage.annotations`                          | Additional storage annotations                                                                                                                          | `{}`                      |
| `replicaSet.hiddenSecondaries.storage.labels`                               | Additional storage labels                                                                                                                               | `{}`                      |
| `replicaSet.hiddenSecondaries.extraArgs`                                    | Additional arguments for the hiddenSecondarie container                                                                                                 | `[]`                      |

### Replica Set Arbiter Parameters

| Parameter                                                         | Description                                                                                                                                             | Default                    |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------- |
| `replicaSet.arbiter.enabled`                                      | Enable arbiter deployment                                                                                                                               | `false`                    |
| `replicaSet.arbiter.headlessServiceSuffix`                        | Suffix of the arbiters headless service name                                                                                                            | `arbiter`                  |
| `replicaSet.arbiter.resources`                                    | Resource limits and requests for the arbiter                                                                                                            | `{}`                       |
| `replicaSet.arbiter.nodeSelector`                                 | Additional node selector                                                                                                                                | `{}`                       |
| `replicaSet.arbiter.tolerations`                                  | Pod tolerations                                                                                                                                         | `[]`                       |
| `replicaSet.arbiter.affinity`                                     | Pod affinity                                                                                                                                            | `{}`                       |
| `replicaSet.arbiter.topologySpreadConstraints`                    | Topology spread constraints for pods                                                                                                                    | `{}`                       |
| `replicaSet.arbiter.storage.persistentVolumeClaimName`            | Set persistentVolumenClaimName to reference an existing PVC                                                                                             |                            |
| `replicaSet.arbiter.storage.persistentVolumeClaimRetentionPolicy` | Set persistentVolumeClaimRetentionPolicy to explicitly control how PVCs are managed when a stateful set is scaled or deleted. (new feature in k8s 1.32) |                            |
| `replicaSet.arbiter.storage.volumeName`                           | Internal volume name and prefix of a created PVC                                                                                                        | `"mongodb-arbiter-volume"` |
| `replicaSet.arbiter.storage.requestedSize`                        | Alternative set requestedSize to define a size for a dynamically created PVC                                                                            |                            |
| `replicaSet.arbiter.storage.className`                            | The storage class name                                                                                                                                  |                            |
| `replicaSet.arbiter.storage.accessModes`                          | Default access mode (ReadWriteOnce)                                                                                                                     | `ReadWriteOnce`            |
| `replicaSet.arbiter.storage.annotations`                          | Additional storage annotations                                                                                                                          | `{}`                       |
| `replicaSet.arbiter.storage.labels`                               | Additional storage labels                                                                                                                               | `{}`                       |
| `replicaSet.arbiter.extraArgs`                                    | Additional arguments for the arbiter container                                                                                                          | `[]`                       |

### Replica Set Extra Init Parameters

| Parameter                        | Description                                                                         | Default |
| -------------------------------- | ----------------------------------------------------------------------------------- | ------- |
| `replicaSet.extraInit.retries`   | Number of retries to detect whether mongod is fully up and running in background    | `10`    |
| `replicaSet.extraInit.delay`     | Seconds to wait between retries                                                     | `3`     |
| `replicaSet.extraInit.initDelay` | Seconds to wait after mongod is running to give it time for internal initialization | `5`     |

### Replica Set Shutdown Parameters

| Parameter                   | Description                                                                                                                | Default |
| --------------------------- | -------------------------------------------------------------------------------------------------------------------------- | ------- |
| `replicaSet.shutdown.delay` | Delay until termination request is forwarded to mongod process to give ReplicaSet time for electing a new primary instance | `10`    |

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

## Troubleshooting

### Getting Support

For issues related to this Helm chart, please check:

- [MongoDB Documentation](https://www.mongodb.com/docs/get-started/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Create an issue](https://github.com/CloudPirates-io/helm-charts/issues)
