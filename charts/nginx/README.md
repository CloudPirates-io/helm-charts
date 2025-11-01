<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-nginx"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-nginx" /></a>
</p>

# Nginx

nginx ("engine x") is an HTTP web server, reverse proxy, content cache, load balancer, TCP/UDP proxy server, and mail proxy server. 

## Installing the Chart

To install the chart with the release name `my-nginx`:

```bash
helm install my-nginx oci://registry-1.docker.io/cloudpirates/nginx
```

To install with custom values:

```bash
helm install my-nginx oci://registry-1.docker.io/cloudpirates/nginx -f my-values.yaml
```

## Uninstalling the Chart

To uninstall/delete the `my-nginx` deployment:

```bash
helm uninstall my-nginx
```

This removes all the Kubernetes components associated with the chart and deletes the release.

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
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/nginx:<version>
```

## Common Use Cases

### Custom Container Port (e.g., 8080)

To run Nginx on port 8080 with matching health checks:

```yaml
# my-values.yaml
serverConfig: |
  server {
    listen 0.0.0.0:8080;
    root /usr/share/nginx/html;
    index index.html index.htm;
    
    location / {
      try_files $uri $uri/ /index.html;
    }
  }
livenessProbe:
  type: httpGet
  path: /
readinessProbe:
  type: httpGet
  path: /
```

Then install with:
```bash
helm install my-nginx oci://registry-1.docker.io/cloudpirates/nginx -f my-values.yaml
```

### Multiple Ports Configuration

For advanced setups with multiple ports:

```yaml
# advanced-values.yaml
containerPorts:
  - name: http
    containerPort: 80
    protocol: TCP
  - name: https
    containerPort: 443
    protocol: TCP
service:
  ports:
    - port: 80
      targetPort: http
      protocol: TCP
      name: http
    - port: 443
      targetPort: https
      protocol: TCP
      name: https
```

## Configuration

The following table lists the configurable parameters of the Nginx chart and their default values.

### Global Parameters

| Parameter                 | Description                                     | Default |
| ------------------------- | ----------------------------------------------- | ------- |
| `global.imageRegistry`    | Global Docker Image registry                    | `""`    |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`    |

### Common Parameters

| Parameter           | Description                                     | Default |
| ------------------- | ----------------------------------------------- | ------- |
| `nameOverride`      | String to partially override nginx.fullname     | `""`    |
| `fullnameOverride`  | String to fully override nginx.fullname         | `""`    |
| `commonLabels`      | Labels to add to all deployed objects           | `{}`    |
| `commonAnnotations` | Annotations to add to all deployed objects      | `{}`    |


### Nginx Image Parameters

| Parameter           | Description                                          | Default                                                                            |
| ------------------- | ---------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `image.registry`    | Nginx image registry                                 | `docker.io`                                                                        |
| `image.repository`  | Nginx image repository                               | `nginx`                                                                            |
| `image.tag`         | Nginx image tag                                      | `"1.28.0@sha256:24ccf9a6192d2c6c5c4a6e9d2fdfa2a8e382b15f8dd7d0e05a1579f6a46f7776"` |
| `image.pullPolicy`  | Nginx image pull policy                              | `Always`                                                                           |


### Nginx Configuration Parameters

Existing Configmaps are prioritized over inline configuration. Inline configuration will trigger a pod restart if changed.

| Parameter                             | Description                                                 | Default |
| ------------------------------------- | ----------------------------------------------------------- | ------- |
| `config`                              | Custom NGINX configuration file (nginx.conf)                | `""`    |
| `existingConfigConfigmap`             | Name of an existing ConfigMap containing nginx.conf         | `""`    |
| `serverConfig`                        | Custom server block to be added to NGINX configuration      | `""`    |
| `existingServerConfigConfigmap`       | Name of an existing ConfigMap containing server-config.conf | `""`    |
| `streamServerConfig`                  | Custom stream server block to be added to NGINX config      | `""`    |
| `existingStreamServerConfigConfigmap` | Name of an existing ConfigMap containing stream-server-config.conf | `""`    |

Example of an existing external `config`:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: example-nginx-config
data:
  nginx.conf: |-
    user  nginx;
    worker_processes  1;
    error_log  /var/log/nginx/error.log warn;
    pid        /run/nginx.pid;

    events {
        worker_connections  1024;
    }
    http {
        include       /etc/nginx/mime.types;
        default_type  application/octet-stream;
        log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                          '$status $body_bytes_sent "$http_referer" '
                          '"$http_user_agent" "$http_x_forwarded_for"';
        access_log  /var/log/nginx/access.log  main;
        sendfile        on;
        keepalive_timeout  65;
        include /etc/nginx/conf.d/*.conf;
    }
```

### Container Port Parameters

| Parameter         | Description                                                       | Default |
| ----------------- | ----------------------------------------------------------------- | ------- |
| `containerPorts`  | Array of container ports (advanced configuration) - see examples | `[]`    |

#### Container Ports Examples

**Multiple ports (advanced):**
```yaml
containerPorts:
  - name: http
    containerPort: 80
    protocol: TCP
  - name: https
    containerPort: 443
    protocol: TCP
```


### Service Parameters

| Parameter        | Description                                                | Default     |
| ---------------- | ---------------------------------------------------------- | ----------- |
| `service.type`   | Nginx service type                                         | `ClusterIP` |
| `service.ports`  | Array of service ports (advanced configuration) - see examples | `[]`    |
| `service.annotations`  | Additional annotations to add to the service | `{}`    |

#### Service Ports Examples

**Multiple service ports (advanced):**
```yaml
service:
  ports:
    - port: 80
      targetPort: nginx
      protocol: TCP
      name: http
    - port: 443
      targetPort: https
      protocol: TCP
      name: https
```


### Security Context Parameters

| Parameter                                           | Description                                             | Default |
| --------------------------------------------------- | ------------------------------------------------------- | ------- |
| `podSecurityContext.fsGroup`                        | Set Nginx pod's Security Context fsGroup                | `101`   |
| `containerSecurityContext.runAsUser`                | Set Nginx container's Security Context runAsUser        | `101`   |
| `containerSecurityContext.runAsNonRoot`             | Set Nginx container's Security Context runAsNonRoot     | `true`  |
| `containerSecurityContext.allowPrivilegeEscalation` | Set Nginx container's privilege escalation              | `false` |


### Resources Parameters

| Parameter   | Description                              | Default |
| ----------- | ---------------------------------------- | ------- |
| `resources` | Resource limits and requests for Nginx pod| `{}`    |


### Health Check Parameters

| Parameter                            | Description                                   | Default     |
| ------------------------------------ | --------------------------------------------- | ----------- |
| `livenessProbe.enabled`              | Enable liveness probe                         | `true`      |
| `livenessProbe.type`                 | Probe type (tcpSocket or httpGet)             | `tcpSocket` |
| `livenessProbe.path`                 | Path for HTTP probe (only used when type is httpGet) | `/`     |
| `livenessProbe.initialDelaySeconds`  | Initial delay before starting probes          | `30`        |
| `livenessProbe.periodSeconds`        | How often to perform the probe                | `10`        |
| `livenessProbe.timeoutSeconds`       | Timeout for each probe attempt                | `5`         |
| `livenessProbe.failureThreshold`     | Number of failures before pod is restarted    | `3`         |
| `livenessProbe.successThreshold`     | Number of successes to mark probe as successful| `1`        |
| `readinessProbe.enabled`             | Enable readiness probe                        | `true`      |
| `readinessProbe.type`                | Probe type (tcpSocket or httpGet)             | `tcpSocket` |
| `readinessProbe.path`                | Path for HTTP probe (only used when type is httpGet) | `/`     |
| `readinessProbe.initialDelaySeconds` | Initial delay before starting probes          | `5`         |
| `readinessProbe.periodSeconds`       | How often to perform the probe                | `5`         |
| `readinessProbe.timeoutSeconds`      | Timeout for each probe attempt                | `5`         |
| `readinessProbe.failureThreshold`    | Number of failures before pod is marked unready| `3`        |
| `readinessProbe.successThreshold`    | Number of successes to mark probe as successful| `1`        |

#### Health Check Examples

**HTTP-based probes for custom port 8080:**
```yaml
livenessProbe:
  enabled: true
  type: httpGet
  path: /health
readinessProbe:
  enabled: true
  type: httpGet
  path: /ready
```

**TCP-based probes (default):**
```yaml
livenessProbe:
  enabled: true
  type: tcpSocket
readinessProbe:
  enabled: true
  type: tcpSocket
```


### Service Account Parameters

| Parameter                                     | Description                                           | Default |
| --------------------------------------------- | ----------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a service account should be created | `true`  |
| `serviceAccount.annotations`                  | Annotations to add to the service account             | `{}`    |
| `serviceAccount.name`                         | The name of the service account to use                | `""`    |
| `serviceAccount.automountServiceAccountToken` | Automatically mount service account token             | `false` |


### Ingress Parameters

| Parameter             | Description                                                                   | Default                                                                                         |
| --------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `ingress.enabled`     | Enable ingress record generation                                              | `false`                                                                                         |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress                    | `""`                                                                                            |
| `ingress.annotations` | Additional annotations for the Ingress resource                               | `{}`                                                                                            |
| `ingress.hosts`       | An array with hosts and paths                                                 | `[{{host: "nginx.local", paths: [{{path: "/", pathType: "ImplementationSpecific"}}]}}]`      |
| `ingress.tls`         | TLS configuration for the Ingress                                             | `[]`                                                                                            |


### Metrics Parameters

| Parameter                       | Description                                                        | Default   |
|----------------------------------|--------------------------------------------------------------------|-----------|
| `metrics.enabled`                | Start a sidecar Prometheus exporter to expose Nginx metrics        | `false`   |
| `metrics.image.registry`         | Nginx exporter image registry                                      | `docker.io` |
| `metrics.image.repository`       | Nginx exporter image repository                                    | `nginx/nginx-prometheus-exporter` |
| `metrics.image.tag`              | Nginx exporter image tag                                           | `"1.4@sha256:..."` |
| `metrics.image.pullPolicy`       | Nginx exporter image pull policy                                   | `Always`  |
| `metrics.resources.limits.memory`| Memory limit for metrics container                                 | `64Mi`    |
| `metrics.resources.requests.cpu` | CPU request for metrics container                                  | `50m`     |
| `metrics.resources.requests.memory`| Memory request for metrics container                              | `64Mi`    |
| `metrics.extraArgs`              | Extra arguments for nginx exporter                                 | `[]`      |
| `metrics.service.type`           | Metrics service type                                               | `ClusterIP` |
| `metrics.service.port`           | Metrics service port                                               | `9113`    |
| `metrics.service.annotations`    | Additional custom annotations for Metrics service                  | `{}`      |
| `metrics.service.loadBalancerIP` | Load balancer IP if metrics service type is `LoadBalancer`         | `""`      |
| `metrics.service.loadBalancerSourceRanges` | Allowed addresses for LoadBalancer metrics service         | `[]`      |
| `metrics.service.clusterIP`      | Static clusterIP or None for headless metrics service              | `""`      |
| `metrics.service.nodePort`       | NodePort value for LoadBalancer/NodePort metrics service types     | `""`      |
| `metrics.serviceMonitor.enabled` | Create ServiceMonitor resource(s) for PrometheusOperator           | `false`   |
| `metrics.serviceMonitor.namespace`| Namespace for ServiceMonitor resource(s)                          | `""`      |
| `metrics.serviceMonitor.interval`| Interval for scraping metrics                                      | `30s`     |
| `metrics.serviceMonitor.scrapeTimeout`| Timeout for scraping metrics                                 | `""`      |
| `metrics.serviceMonitor.relabelings`| Additional relabeling of metrics                              | `[]`      |
| `metrics.serviceMonitor.metricRelabelings`| Additional metric relabeling of metrics                    | `[]`      |
| `metrics.serviceMonitor.honorLabels`| Honor metrics labels                                         | `false`   |
| `metrics.serviceMonitor.selector`| Prometheus instance selector labels                               | `{}`      |
| `metrics.serviceMonitor.annotations`| Additional annotations for ServiceMonitor                     | `{}`      |
| `metrics.serviceMonitor.namespaceSelector`| Namespace selector for ServiceMonitor                      | `{}`      |

**Note:**  
To enable metrics, set `metrics.enabled: true` and ensure your Nginx configuration includes a stub status endpoint, e.g.:
```nginx
location /stub_status {
  stub_status on;
}
```


### Extra Configuration Parameters

| Parameter           | Description                                                                         | Default |
| ------------------- | ----------------------------------------------------------------------------------- | ------- |
| `extraEnvVars`          | Additional environment variables to set                                             | `[]`    |
| `extraVolumes`      | Additional volumes to add to the pod                                                | `[]`    |
| `extraVolumeMounts` | Additional volume mounts to add to the Nginx container                             | `[]`    |
| `extraObjects`      | Array of extra objects to deploy with the release                                   | `[]`    |

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


### Pod Configuration Parameters

| Parameter           | Description                       | Default |
| ----------------    | ------------------------------    | ------- |
| `nodeSelector`      | Node selector for pod assignment  | `{}`    |
| `priorityClassName` | Priority class for pod eviction   | `""`    |
| `tolerations`       | Tolerations for pod assignment    | `[]`    |
| `affinity`          | Affinity rules for pod assignment | `{}`    |

## Examples


### Basic Installation

Create a `values.yaml` file:

```yaml
replicaCount: 2
resources:
  limits:
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
service:
  type: ClusterIP
  port: 8080
```

Install the chart:

```bash
helm install my-nginx charts/nginx -f values.yaml
```

### Custom NGINX Configuration

```yaml
config: |-
  user  nginx;
  worker_processes  1;
  error_log  /var/log/nginx/error.log warn;
  pid        /run/nginx.pid;
  events {
      worker_connections  1024;
  }
  http {
      include       /etc/nginx/mime.types;
      default_type  application/octet-stream;
      log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for"';
      access_log  /var/log/nginx/access.log  main;
      sendfile        on;
      keepalive_timeout  65;
      include /etc/nginx/conf.d/*.conf;
  }
```

### With Service Account

```yaml
serviceAccount:
  create: true
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/nginx-role
```

### Enable Ingress

```yaml
ingress:
  enabled: true
  className: "nginx"
  hosts:
    - host: nginx.local
      paths:
        - path: /
          pathType: ImplementationSpecific
```

### Enable Autoscaling

```yaml
autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 5
  targetCPUUtilizationPercentage: 80
```

## Troubleshooting


### Connection Issues

1. **Check deployment and service status**:

  ```bash
  kubectl get deployment -l app.kubernetes.io/name=nginx
  kubectl get svc -l app.kubernetes.io/name=nginx
  kubectl get pods -l app.kubernetes.io/name=nginx
  ```
2. **Check pod logs**:

  ```bash
  kubectl logs <pod-name>
  ```

### Performance Tuning

For production workloads, consider:

- Using a dedicated ConfigMap for Nginx configuration
- Implementing rate limiting and connection throttling
- Enabling gzip compression for responses
- Monitoring performance metrics with Prometheus

## Links

- [Nginx Official Documentation](https://nginx.org/)
- [Nginx Docker Hub](https://hub.docker.com/_/nginx)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
