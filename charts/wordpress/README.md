# WordPress Helm Chart

This chart deploys WordPress on a Kubernetes cluster using the Helm package manager.

## TL;DR

```bash
$ helm repo add cloudpirates oci://registry-1.docker.io/cloudpirates
$ helm install my-release cloudpirates/wordpress
```

## Introduction

WordPress is a free and open-source content management system (CMS) written in PHP and paired with a MySQL or MariaDB database. Features include a plugin architecture and a template system, referred to within WordPress as Themes.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- ReadWriteMany volumes for deployment scaling

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install my-release cloudpirates/wordpress
```

The command deploys WordPress on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |

### Common parameters

| Name                | Description                                        | Value |
| ------------------- | -------------------------------------------------- | ----- |
| `nameOverride`      | String to partially override wordpress.fullname    | `""`  |
| `fullnameOverride`  | String to fully override wordpress.fullname        | `""`  |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`  |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`  |

### WordPress Image parameters

| Name                | Description                    | Value                    |
| ------------------- | ------------------------------ | ------------------------ |
| `image.registry`    | WordPress image registry       | `docker.io`             |
| `image.repository`  | WordPress image repository     | `wordpress`             |
| `image.tag`         | WordPress image tag            | `6.5.0-php8.2-apache`   |
| `image.pullPolicy`  | WordPress image pull policy    | `IfNotPresent`          |
| `replicaCount`      | Number of WordPress replicas   | `1`                     |

### WordPress Configuration parameters

| Name                     | Description                         | Value                |
| ------------------------ | ----------------------------------- | -------------------- |
| `wordpress.username`     | WordPress application username      | `user`               |
| `wordpress.password`     | WordPress application password      | `""`                 |
| `wordpress.email`        | WordPress application email         | `user@example.com`   |
| `wordpress.blogName`     | WordPress blog name                 | `WordPress Blog`     |
| `wordpress.tablePrefix`  | WordPress table prefix              | `wp_`                |

### Persistence parameters

| Name                          | Description                       | Value         |
| ----------------------------- | --------------------------------- | ------------- |
| `persistence.enabled`         | Enable persistence using PVC      | `true`        |
| `persistence.storageClass`    | PVC Storage Class                 | `""`          |
| `persistence.accessMode`      | PVC Access Mode                   | `ReadWriteOnce` |
| `persistence.size`            | PVC Storage Request               | `10Gi`        |
| `persistence.existingClaim`   | Use an existing PVC to persist data | `""`        |

### Exposure parameters

| Name                        | Description                                  | Value       |
| --------------------------- | -------------------------------------------- | ----------- |
| `service.type`              | Kubernetes service type                      | `ClusterIP` |
| `service.port`              | WordPress service port                       | `80`        |
| `ingress.enabled`           | Enable ingress record generation             | `true`      |
| `ingress.className`         | IngressClass that will be used               | `nginx`     |
| `ingress.annotations`       | Additional ingress annotations               | `{}`        |
| `ingress.hosts[0].host`     | Default host for the ingress record          | `wordpress.local` |
| `ingress.hosts[0].paths[0].path` | Default path for the ingress record    | `/`         |
| `ingress.hosts[0].paths[0].pathType` | Path type for the ingress record   | `ImplementationSpecific` |
| `ingress.tls`               | TLS configuration                           | `[]`        |

### Database Parameters

| Name                        | Description                                  | Value       |
| --------------------------- | -------------------------------------------- | ----------- |
| `mariadb.enabled`           | Whether to use the MariaDB chart             | `true`      |
| `mariadb.auth.rootPassword` | MariaDB root password                        | `""`        |
| `mariadb.auth.database`     | MariaDB custom database                      | `wordpress` |
| `mariadb.auth.username`     | MariaDB custom user name                     | `wordpress` |
| `mariadb.auth.password`     | MariaDB custom user password                 | `""`        |

### Apache Configuration Override Parameters

| Name                        | Description                                   | Value                           |
| --------------------------- | --------------------------------------------- | ------------------------------- |
| `apache.configOverride.htaccess` | Custom .htaccess content                 | (see values file)               |
| `apache.configOverride.apache2Conf` | Custom apache2.conf content           | (see values file)               |
| `apache.configOverride.portsConf` | Custom ports.conf content               | (see values file)               |
| `apache.configOverride.vhostConf` | Custom virtual host configuration (000-default.conf) | (see values file)  |
| `apache.configOverride.customConfigs` | Additional custom Apache configuration files | (see values file)      |

## Configuration and installation details

### Persistence

The [WordPress](https://hub.docker.com/_/wordpress/) image stores the WordPress data and configurations at the `/var/www/html` path of the container.

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Parameters](#parameters) section to configure the PVC or to disable persistence.

### Ingress

This chart provides support for ingress resources. If you have an ingress controller installed on your cluster, such as [nginx-ingress-controller](https://github.com/bitnami/charts/tree/main/bitnami/nginx-ingress-controller) or [contour](https://github.com/bitnami/charts/tree/main/bitnami/contour) you can utilize the ingress controller to serve your application.

To enable ingress integration, please set `ingress.enabled` to `true`.

### Apache Configuration Override

This chart allows you to override default Apache configuration files using a ConfigMap. This feature is useful for customizing Apache behavior, adding custom virtual hosts, or modifying server settings.

```yaml
apache:
  configOverride:
    htaccess: |
      # Custom .htaccess content
      RewriteEngine On
      RewriteRule ^(.*)$ /index.php [QSA,L]
    portsConf: |
      Listen 8080
      <IfModule mod_ssl.c>
          Listen 8443
      </IfModule>
    vhostConf: |
      <VirtualHost *:80>
          DocumentRoot /var/www/html
          ErrorLog ${APACHE_LOG_DIR}/error.log
          CustomLog ${APACHE_LOG_DIR}/access.log combined
      </VirtualHost>
    customConfigs:
      security.conf: |
        # Security configurations
        ServerTokens Prod
        ServerSignature Off
```

The configuration files will be mounted to the appropriate locations in the Apache container:
- `.htaccess` → `/var/www/html/.htaccess`
- `apache2.conf` → `/etc/apache2/apache2.conf`
- `vhostConf` → `/etc/apache2/sites-available/000-default.conf`

### TLS secrets

The chart also facilitates the creation of TLS secrets for use with the ingress controller, with different options for certificate management.