<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-clusterpirate"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-clusterpirate" /></a>
</p>

# ClusterPirate Helm Chart

> ⚠️ **Important**
>
> This chart requires an access token. You must obtain a token from our [Customer Portal](https://portal.cloudpirates.io) before installing this chart. For complete installation instructions and setup guide, please refer to our [Developer Portal](https://developer.cloudpirates.io).

A Helm chart for ClusterPirate - the client agent for CloudPirates Managed Observability Platform. This chart deploys the necessary components to connect your Kubernetes cluster to the CloudPirates managed observability service, enabling centralized monitoring, metrics collection, log aggregation, and cluster insights through our SaaS platform.

## What is ClusterPirate?

ClusterPirate is a lightweight client agent that runs in your Kubernetes cluster and acts as the bridge between your infrastructure and the CloudPirates Managed Observability Platform. It provides:

- **Automated Cluster Discovery**: Registers your cluster with the managed platform
- **Metrics Collection**: Gathers resource usage, performance metrics, and cluster health data
- **Event Monitoring**: Tracks Kubernetes events and system activities
- **Secure Data Transmission**: Encrypts and securely transmits observability data to the platform
- **Local Caching**: Uses Valkey for efficient data buffering and resilience

The collected data is processed and visualized through the CloudPirates web console, providing you with comprehensive insights into your cluster's health, performance, and resource utilization without the overhead of managing your own observability infrastructure.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- Access token for CloudPirates API
- PV provisioner support in the underlying infrastructure (if Valkey persistence is enabled)

## Installing the Chart

To install the chart with the release name `clusterpirate` in the `clusterpirate-system` namespace:

```bash
kubectl create namespace clusterpirate-system
helm install clusterpirate --namespace clusterpirate-system oci://registry-1.docker.io/cloudpirates/clusterpirate
```

Or install directly from the local chart:

```bash
kubectl create namespace clusterpirate-system
helm install clusterpirate ./charts/clusterpirate --namespace clusterpirate-system
```

The command deploys ClusterPirate on the Kubernetes cluster in the default configuration. The [Configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `clusterpirate` deployment:

```bash
helm uninstall clusterpirate --namespace clusterpirate-system
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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/clusterpirate:<version>
```

## Configuration

The following table lists the configurable parameters of the ClusterPirate chart and their default values.

### Global parameters

| Parameter           | Description                                | Default                      |
| ------------------- | ------------------------------------------ | ---------------------------- |
| `commonLabels`      | Labels to add to all deployed objects      | `{}`                         |
| `commonAnnotations` | Annotations to add to all deployed objects | `{}`                         |
| `imagePullSecrets`  | Docker registry secret names as an array   | `[{"name": "k7r-registry"}]` |

### Deployment configuration

| Parameter                              | Description                                | Default                                     |
| -------------------------------------- | ------------------------------------------ | ------------------------------------------- |
| `deployment.image.registry`            | ClusterPirate image registry               | `harbor.cloudpirates.io`                    |
| `deployment.image.repository`          | ClusterPirate image repository             | `koperator-internal/services/clusterpirate` |
| `deployment.image.tag`                 | ClusterPirate image tag                    | `latest`                                    |
| `deployment.image.pullPolicy`          | ClusterPirate image pull policy            | `Always`                                    |
| `deployment.resources.limits.memory`   | Memory limit for ClusterPirate container   | `300Mi`                                     |
| `deployment.resources.requests.memory` | Memory request for ClusterPirate container | `100Mi`                                     |
| `deployment.resources.requests.cpu`    | CPU request for ClusterPirate container    | `10m`                                       |
| `deployment.extraEnvVars`              | Additional environment variables           | `[]`                                        |

### Health probe configuration

| Parameter                                              | Description                                       | Default |
| ------------------------------------------------------ | ------------------------------------------------- | ------- |
| `deployment.probes.livenessProbe.enabled`              | Enable livenessProbe on ClusterPirate containers  | `true`  |
| `deployment.probes.livenessProbe.initialDelaySeconds`  | Initial delay seconds for livenessProbe           | `30`    |
| `deployment.probes.livenessProbe.periodSeconds`        | Period seconds for livenessProbe                  | `10`    |
| `deployment.probes.livenessProbe.timeoutSeconds`       | Timeout seconds for livenessProbe                 | `5`     |
| `deployment.probes.livenessProbe.failureThreshold`     | Failure threshold for livenessProbe               | `3`     |
| `deployment.probes.livenessProbe.successThreshold`     | Success threshold for livenessProbe               | `1`     |
| `deployment.probes.readinessProbe.enabled`             | Enable readinessProbe on ClusterPirate containers | `true`  |
| `deployment.probes.readinessProbe.initialDelaySeconds` | Initial delay seconds for readinessProbe          | `5`     |
| `deployment.probes.readinessProbe.periodSeconds`       | Period seconds for readinessProbe                 | `5`     |
| `deployment.probes.readinessProbe.timeoutSeconds`      | Timeout seconds for readinessProbe                | `3`     |
| `deployment.probes.readinessProbe.failureThreshold`    | Failure threshold for readinessProbe              | `3`     |
| `deployment.probes.readinessProbe.successThreshold`    | Success threshold for readinessProbe              | `1`     |

### ClusterPirate Application Configuration

| Parameter                                        | Description                                                 | Default |
| ------------------------------------------------ | ----------------------------------------------------------- | ------- |
| `clusterPirate.logLevel`                         | Application logging level (debug, info, warn, error, fatal) | `info`  |
| `clusterPirate.healthPort`                       | Health check server port                                    | `3000`  |
| `clusterPirate.metrics.enabled`                  | Enable/disable metrics collection                           | `true`  |
| `clusterPirate.metrics.updateIntervalSeconds`    | Interval in seconds for metrics updates                     | `60`    |
| `clusterPirate.metrics.cache.host`               | Valkey server hostname or IP address                        | `""`    |
| `clusterPirate.metrics.cache.port`               | Valkey server port                                          | `6379`  |
| `clusterPirate.metrics.cache.password`           | Valkey authentication password                              | `""`    |
| `clusterPirate.metrics.cache.ttl`                | Time-to-live for cached metrics in seconds                  | `86400` |
| `clusterPirate.monitoring.resourceEventsEnabled` | Enable monitoring of Kubernetes resources                   | `true`  |
| `clusterPirate.monitoring.systemEventsEnabled`   | Enable monitoring of Kubernetes system events               | `true`  |

### CloudPirates API Configuration

| Parameter                          | Description                           | Default                                                 |
| ---------------------------------- | ------------------------------------- | ------------------------------------------------------- |
| `cloudpiratesApi.registerEndpoint` | API endpoint for cluster registration | `https://api.cloudpirates.io/v1/clusterpirate/register` |

### Authentication Configuration

| Parameter                           | Description                                                   | Default         |
| ----------------------------------- | ------------------------------------------------------------- | --------------- |
| `auth.accessToken`                  | Access token for CloudPirates API                             | `""`            |
| `auth.existingSecret`               | Name of existing secret containing the access token           | `""`            |
| `auth.existingSecretAccessTokenKey` | Key within the existing secret that contains the access token | `"accessToken"` |

### RBAC Configuration

| Parameter     | Description                                                           | Default |
| ------------- | --------------------------------------------------------------------- | ------- |
| `rbac.create` | Whether to create RBAC resources (ClusterRole and ClusterRoleBinding) | `true`  |

### Service Account Configuration

| Parameter               | Description                                  | Default |
| ----------------------- | -------------------------------------------- | ------- |
| `serviceAccount.create` | Whether to create a service account          | `true`  |
| `serviceAccount.name`   | Name of the service account to create or use | `""`    |

### Valkey Configuration (Dependency)

| Parameter                               | Description                                               | Default      |
| --------------------------------------- | --------------------------------------------------------- | ------------ |
| `valkey.enabled`                        | Enable/disable Valkey installation as a dependency        | `true`       |
| `valkey.auth.enabled`                   | Enable/disable password authentication for Valkey         | `true`       |
| `valkey.auth.password`                  | Valkey password                                           | `""`         |
| `valkey.auth.existingSecret`            | Name of existing secret containing the Valkey password    | `""`         |
| `valkey.auth.existingSecretPasswordKey` | Key within the existing secret that contains the password | `"password"` |

## Examples

### Basic Deployment

Deploy ClusterPirate with default configuration (requires access token):

```bash
kubectl create namespace clusterpirate-system
helm install clusterpirate ./charts/clusterpirate \
  --namespace clusterpirate-system \
  --set auth.accessToken="your-access-token-here"
```

### Production Setup with External Valkey

```yaml
# values-production.yaml
clusterPirate:
  logLevel: warn
  metrics:
    updateIntervalSeconds: 30
    cache:
      host: "external-valkey.example.com"
      port: 6379
      password: "secure-valkey-password"
      ttl: 43200 # 12 hours

deployment:
  resources:
    requests:
      memory: "200Mi"
      cpu: "50m"
    limits:
      memory: "500Mi"

auth:
  existingSecret: "clusterpirate-credentials"
  existingSecretAccessTokenKey: "accessToken"

valkey:
  enabled: false
```

Deploy with production values:

```bash
kubectl create namespace clusterpirate-system
helm install clusterpirate ./charts/clusterpirate \
  --namespace clusterpirate-system \
  -f values-production.yaml
```

### Using Existing Secrets

```yaml
# values-external-secrets.yaml
auth:
  existingSecret: "clusterpirate-auth"
  existingSecretAccessTokenKey: "accessToken"

valkey:
  auth:
    existingSecret: "valkey-credentials"
    existingSecretPasswordKey: "password"
```

Create the secrets first:

```bash
kubectl create namespace clusterpirate-system
kubectl create secret generic clusterpirate-auth \
  --namespace clusterpirate-system \
  --from-literal=accessToken=your-api-access-token

kubectl create secret generic valkey-credentials \
  --namespace clusterpirate-system \
  --from-literal=password=your-valkey-password
```

### Development Setup

```yaml
# values-development.yaml
clusterPirate:
  logLevel: debug
  metrics:
    updateIntervalSeconds: 120
    cache:
      ttl: 3600 # 1 hour

deployment:
  image:
    tag: "latest"
    pullPolicy: Always

valkey:
  persistence:
    enabled: false # Use emptyDir for development
```

## Access ClusterPirate

### Logs

View ClusterPirate logs:

```bash
kubectl logs -f deployment/clusterpirate --namespace clusterpirate-system
```

### Valkey Access

If using the Valkey dependency, access Valkey directly:

```bash
kubectl port-forward service/clusterpirate-valkey --namespace clusterpirate-system 6379:6379
```

Get the auto-generated Valkey password:

```bash
kubectl get secret clusterpirate-valkey --namespace clusterpirate-system -o jsonpath="{.data.password}" | base64 --decode
```

## Troubleshooting

### Common Issues

1. **Pod fails to start with authentication errors**

   - Ensure the access token is correctly configured
   - Verify the CloudPirates API endpoint is accessible
   - Check the secret name and key if using existing secrets

2. **Cannot connect to Valkey**

   - Verify Valkey is running: `kubectl get pods -l app.kubernetes.io/name=valkey --namespace clusterpirate-system`
   - Check if authentication is properly configured
   - Ensure the service is accessible within the cluster

3. **Metrics collection not working**

   - Verify RBAC permissions are created correctly
   - Check if the metrics server is running in the cluster
   - Review ClusterPirate logs for connection errors

4. **High memory usage**

   - Adjust metrics cache TTL to reduce memory footprint
   - Increase memory limits if necessary
   - Consider reducing the metrics update interval

5. **Permission denied errors**
   - Ensure RBAC is enabled (`rbac.create: true`)
   - Verify the service account has the required permissions
   - Check cluster security policies and admission controllers

### Performance Tuning

1. **Memory Optimization**

   ```yaml
   clusterPirate:
     metrics:
       cache:
         ttl: 7200 # Reduce cache TTL
       updateIntervalSeconds: 120 # Increase update interval

   deployment:
     resources:
       requests:
         memory: "150Mi"
       limits:
         memory: "400Mi"
   ```

### Getting Support

For issues related to this Helm chart, please check:

- [Developer Portal](https://developer.cloudpirates.io)
- Chart repository issues

## Requirements

### External Services

- **CloudPirates API**: Required for cluster registration and data submission
- **Kubernetes Metrics Server**: Required for resource metrics collection (usually pre-installed)

### Environment Variables

| Variable                             | Required | Default                                               | Description                     |
| ------------------------------------ | -------- | ----------------------------------------------------- | ------------------------------- |
| `LOG_LEVEL`                          | ✗        | info                                                  | Service log level               |
| `HEALTH_PORT`                        | ✗        | 3000                                                  | Health check server port        |
| `METRICS_ENABLED`                    | ✗        | true                                                  | Enable metrics collection       |
| `METRICS_UPDATE_INTERVAL_SECONDS`    | ✗        | 60                                                    | Metrics update interval         |
| `VALKEY_HOST`                        | ✗        | auto-configured                                       | Valkey server hostname          |
| `VALKEY_PORT`                        | ✗        | 6379                                                  | Valkey server port              |
| `VALKEY_PASSWORD`                    | ✗        | auto-generated                                        | Valkey authentication password  |
| `VALKEY_TTL`                         | ✗        | 86400                                                 | Cache TTL in seconds            |
| `MONITORING_RESOURCE_EVENTS_ENABLED` | ✗        | true                                                  | Enable resource monitoring      |
| `MONITORING_SYSTEM_EVENTS_ENABLED`   | ✗        | true                                                  | Enable system events monitoring |
| `CLOUDPIRATES_API_REGISTER_ENDPOINT` | ✗        | https://api.cloudpirates.io/v1/clusterpirate/register | API registration endpoint       |
| `ACCESS_TOKEN`                       | ✓        | -                                                     | CloudPirates API access token   |
