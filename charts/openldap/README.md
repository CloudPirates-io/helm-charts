# OpenLDAP Helm Chart

OpenLDAP Software is an open source implementation of the Lightweight Directory Access Protocol. This Helm chart deploys OpenLDAP built from source with full customization capabilities.

## Features

- **Built from Source**: OpenLDAP compiled from official source code for maximum control and transparency
- **Multi-architecture Support**: Supports both AMD64 and ARM64 platforms
- **High Availability**: Support for multiple replicas with StatefulSet
- **Persistent Storage**: Configurable persistent volumes for data and configuration
- **TLS/LDAPS Support**: Optional TLS encryption for secure connections
- **Kubernetes Native**: Health checks, security contexts, and Kubernetes best practices
- **Fully Configurable**: Extensive configuration options via values.yaml

## Quick Start

### Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PersistentVolume provisioner support (if persistence is enabled)

### Installation

Add the CloudPirates Helm repository:

```bash
helm repo add cloudpirates https://cloudpirates-io.github.io/helm-charts
helm repo update
```

Install the chart:

```bash
helm install my-openldap cloudpirates/openldap
```

### Getting the Admin Password

```bash
kubectl get secret --namespace default my-openldap-openldap -o jsonpath="{.data.adminPassword}" | base64 -d
```

### Connecting to OpenLDAP

Port-forward the service:

```bash
kubectl port-forward svc/my-openldap-openldap 389:389
```

Connect using ldapsearch:

```bash
ldapsearch -x -H ldap://localhost:389 -D "cn=admin,dc=example,dc=org" -w <password> -b "dc=example,dc=org"
```

## Configuration

The following table lists the configurable parameters of the OpenLDAP chart and their default values.

### Global Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.imageRegistry` | Global Docker image registry | `""` |
| `global.imagePullSecrets` | Global Docker registry secret names | `[]` |

### Common Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nameOverride` | String to partially override openldap.fullname | `""` |
| `fullnameOverride` | String to fully override openldap.fullname | `""` |
| `commonLabels` | Labels to add to all deployed objects | `{}` |
| `commonAnnotations` | Annotations to add to all deployed objects | `{}` |

### Image Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.registry` | OpenLDAP image registry | `docker.io` |
| `image.repository` | OpenLDAP image repository | `cloudpirates/openldap` |
| `image.tag` | OpenLDAP image tag | `Chart.appVersion` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |

### Deployment Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of OpenLDAP replicas | `1` |
| `podLabels` | Additional labels for pods | `{}` |
| `podAnnotations` | Additional annotations for pods | `{}` |

### Service Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.ldapPort` | LDAP service port | `389` |
| `service.ldapsPort` | LDAPS service port | `636` |
| `service.annotations` | Service annotations | `{}` |

### Authentication Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `auth.adminPassword` | OpenLDAP admin password | Random 16 chars |
| `auth.existingSecret` | Name of existing secret containing password | `""` |
| `auth.existingSecretPasswordKey` | Key in secret containing password | `adminPassword` |

### Configuration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `config.domain` | LDAP domain | `example.org` |
| `config.organization` | Organization name | `Example Inc` |
| `config.baseDN` | Base DN (auto-generated from domain if empty) | `""` |
| `config.tls.enabled` | Enable TLS/LDAPS | `false` |
| `config.tls.existingSecret` | Name of existing secret with TLS certs | `""` |
| `config.tls.certKey` | Key in secret containing certificate | `tls.crt` |
| `config.tls.keyKey` | Key in secret containing private key | `tls.key` |
| `config.tls.caKey` | Key in secret containing CA certificate | `ca.crt` |

### Persistence Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `persistence.enabled` | Enable persistent storage | `true` |
| `persistence.storageClass` | Storage class for PVCs | `""` |
| `persistence.accessMode` | Access mode for PVCs | `ReadWriteOnce` |
| `persistence.size` | Size of data PVC | `8Gi` |
| `persistence.dataPath` | Mount path for LDAP data | `/var/lib/ldap` |
| `persistence.configPath` | Mount path for LDAP config | `/etc/ldap/slapd.d` |
| `persistence.annotations` | Annotations for PVCs | `{}` |

### Resource Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources.limits.memory` | Memory limit | `256Mi` |
| `resources.requests.cpu` | CPU request | `100m` |
| `resources.requests.memory` | Memory request | `128Mi` |

### Security Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `containerSecurityContext.runAsUser` | User ID to run container | `389` |
| `containerSecurityContext.runAsNonRoot` | Run as non-root user | `true` |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation | `false` |
| `podSecurityContext.fsGroup` | Pod's Security Context fsGroup | `389` |

## Examples

### Custom Domain and Organization

```yaml
config:
  domain: "mycompany.com"
  organization: "My Company"
```

This will create a base DN of `dc=mycompany,dc=com`.

### Enable TLS/LDAPS

First, create a secret with your TLS certificates:

```bash
kubectl create secret generic openldap-tls \
  --from-file=tls.crt=server.crt \
  --from-file=tls.key=server.key \
  --from-file=ca.crt=ca.crt
```

Then enable TLS in values:

```yaml
config:
  tls:
    enabled: true
    existingSecret: "openldap-tls"
```

### High Availability Setup

```yaml
replicaCount: 3
persistence:
  enabled: true
  size: 10Gi
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app.kubernetes.io/name: openldap
          topologyKey: kubernetes.io/hostname
```

### Using Existing Secret for Admin Password

```bash
kubectl create secret generic my-ldap-secret \
  --from-literal=adminPassword=mysecretpassword
```

```yaml
auth:
  existingSecret: "my-ldap-secret"
  existingSecretPasswordKey: "adminPassword"
```

## Building Custom Container

This chart includes a Dockerfile that builds OpenLDAP from source. The container is automatically built via GitHub Actions when changes are pushed to the repository.

### Manual Build

To build the container manually:

```bash
cd charts/openldap
docker build -t my-openldap:2.6.9 .
```

### Build Arguments

The Dockerfile accepts the following build arguments:

- `OPENLDAP_VERSION`: Version of OpenLDAP to build (default: 2.6.9)

Example:

```bash
docker build --build-arg OPENLDAP_VERSION=2.6.8 -t my-openldap:2.6.8 .
```

## Automated Container Builds

This chart uses a generic GitHub Actions workflow that automatically:

1. **Detects** any Helm chart with a Dockerfile
2. **Builds** the container for AMD64 and ARM64 platforms
3. **Pushes** to Docker Hub and GitHub Container Registry
4. **Signs** images with cosign for security
5. **Generates** SBOM (Software Bill of Materials)

The workflow is triggered when:
- Changes are pushed to `charts/*/Dockerfile` or `charts/*/Chart.yaml`
- Pull requests modify these files
- Manually triggered via workflow_dispatch

### Image Locations

Built images are available at:
- Docker Hub: `cloudpirates/openldap:2.6.9`
- GHCR: `ghcr.io/cloudpirates-io/openldap:2.6.9`

### Verifying Image Signatures

```bash
cosign verify --key cosign.pub cloudpirates/openldap:2.6.9
```

## Troubleshooting

### Pod is not starting

Check the pod logs:

```bash
kubectl logs <pod-name>
```

Common issues:
- Incorrect admin password format
- Permission issues with persistent volumes
- Resource constraints

### Cannot connect to LDAP

1. Verify the service is running:
   ```bash
   kubectl get pods
   kubectl get svc
   ```

2. Check connectivity from within the cluster:
   ```bash
   kubectl run -it --rm ldap-test --image=debian:12-slim --restart=Never -- bash
   apt-get update && apt-get install -y ldap-utils
   ldapsearch -x -H ldap://my-openldap-openldap.default.svc:389 -b "" -s base
   ```

### Performance issues

Consider:
- Increasing resource limits
- Enabling persistent storage
- Using faster storage class
- Scaling replicas for high availability

## Uninstalling

To uninstall/delete the `my-openldap` deployment:

```bash
helm uninstall my-openldap
```

This will remove all resources associated with the chart, except PersistentVolumeClaims (if created). To delete those:

```bash
kubectl delete pvc -l app.kubernetes.io/instance=my-openldap
```

## Source Code

- **Helm Chart**: [GitHub](https://github.com/CloudPirates-io/helm-charts/tree/main/charts/openldap)
- **OpenLDAP Source**: [OpenLDAP Git](https://git.openldap.org/openldap/openldap)
- **Container Images**: Built from source using the included Dockerfile

## License

This Helm chart is licensed under the Apache License 2.0. OpenLDAP itself is licensed under the OpenLDAP Public License.

## Support

For issues, questions, or contributions:
- GitHub Issues: https://github.com/CloudPirates-io/helm-charts/issues
- Website: https://www.cloudpirates.io
