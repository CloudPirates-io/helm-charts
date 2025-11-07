<p align="center">
    <a href="https://artifacthub.io/packages/search?org=cloudpirates">
      <img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates" />
    </a>
    <a href="https://discord.gg/XUn9Kt5dsy">
      <img src="https://img.shields.io/badge/contributions-welcome-purple.svg" />
    </a>
    <a href="https://discord.gg/XUn9Kt5dsy">
      <img src="https://img.shields.io/discord/1426189195285762150?logo=discord&label=Discord" />
    </a>
</p>

# CloudPirates Open Source Helm Charts

A curated collection of production-ready Helm charts for open-source cloud-native applications.
This repository provides secure, well-documented, and configurable Helm charts following cloud-native best practices (project name "nonami").

## Available Charts

| Chart                                  | Description                                                                                                                      | Version                                                                                                                                                                                    |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [ClusterPirate](charts/clusterpirate/) | Client agent for the CloudPirates Managed Observability Platform to connect your Kubernetes cluster to our infrastructure        | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/clusterpirate/Chart.yaml&label=&query=version&prefix=v) |
| [Common](charts/common/)               | A library chart for common templates and helper functions                                                                        | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/common/Chart.yaml&label=&query=version&prefix=v)        |
| [Etcd](charts/etcd/)                   | A distributed reliable key-value store                                                                                           | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/etcd/Chart.yaml&label=&query=version&prefix=v)          |
| [Ghost](charts/ghost/)                 | A simple, powerful publishing platform that allows you to share your stories with the world.                                     | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/ghost/Chart.yaml&label=&query=version&prefix=v)         |
| [Keycloak](charts/keycloak/)           | Open Source Identity and Access Management solution                                                                              | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/keycloak/Chart.yaml&label=&query=version&prefix=v)      |
| [MariaDB](charts/mariadb/)             | High-performance, open-source relational database server that is a drop-in replacement for MySQL                                 | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/mariadb/Chart.yaml&label=&query=version&prefix=v)       |
| [Memcached](charts/memcached/)         | High-performance, distributed memory object caching system                                                                       | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/memcached/Chart.yaml&label=&query=version&prefix=v)     |
| [MinIO](charts/minio/)                 | High-Performance Object Storage compatible with Amazon S3 APIs                                                                   | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/minio/Chart.yaml&label=&query=version&prefix=v)         |
| [MongoDB](charts/mongodb/)             | MongoDB a flexible NoSQL database for scalable, real-time data management                                                        | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/mongodb/Chart.yaml&label=&query=version&prefix=v)       |
| [Nginx](charts/nginx/)                 | High-performance HTTP server and reverse proxy                                                                                   | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/nginx/Chart.yaml&label=&query=version&prefix=v)         |
| [PostgreSQL](charts/postgres/)         | The World's Most Advanced Open Source Relational Database                                                                        | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/postgres/Chart.yaml&label=&query=version&prefix=v)      |
| [RabbitMQ](charts/rabbitmq/)           | A messaging broker that implements the Advanced Message Queuing Protocol (AMQP)                                                  | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/rabbitmq/Chart.yaml&label=&query=version&prefix=v)      |
| [Redis](charts/redis/)                 | In-memory data structure store, used as a database, cache, and message broker                                                    | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/redis/Chart.yaml&label=&query=version&prefix=v)         |
| [RustFS](charts/rustfs/)               | High-performance distributed object storage with S3-compatible API (MinIO alternative) [ALPHA]                                   | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/rustfs/Chart.yaml&label=&query=version&prefix=v)        |
| [TimescaleDB](charts/timescaledb/)     | TimescaleDB is a PostgreSQL extension for high-performance real-time analytics on time-series and event data                     | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/timescaledb/Chart.yaml&label=&query=version&prefix=v)   |
| [Valkey](charts/valkey/)               | High-performance in-memory data structure store, fork of Redis                                                                   | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/valkey/Chart.yaml&label=&query=version&prefix=v)        |
| [Zookeeper](charts/zookeeper/)         | Centralized service for maintaining configuration information, naming, providing distributed synchronization, and group services | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/CloudPirates-io/helm-charts/main/charts/zookeeper/Chart.yaml&label=&query=version&prefix=v)     |

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installing Charts

```bash
# From Docker Hub registry
helm install my-release oci://registry-1.docker.io/cloudpirates/<chartname>

# From GitHub Container Registry (GHCR)
helm install my-release oci://ghcr.io/cloudpirates-io/helm-charts/<chartname>

# From local clone
helm install my-release ./charts/<chart-name>
```

## Chart Features

All charts in this repository provide:

### **Security First**

- **Cryptographically Signed**: All charts are signed with [Cosign](COSIGN.md) for supply chain security
- Non-root containers by default
- Read-only root filesystems where possible
- Dropped Linux capabilities
- Security contexts configured
- No hardcoded credentials

### **Production Ready**

- Comprehensive health checks (liveness, readiness, startup probes)
- Resource requests and limits support
- Persistent storage configurations
- Rolling update strategies
- Health check endpoints

### **Highly Configurable**

- Extensive values.yaml with detailed documentation
- Support for existing secrets and ConfigMaps
- Flexible ingress configurations
- Service account customization
- Common labels and annotations support

## Configuration

Each chart provides extensive configuration options through `values.yaml`. Key configuration areas include:

- **Authentication & Security**: User credentials, existing secrets, security contexts
- **Storage**: Persistent volumes, storage classes, backup configurations
- **Networking**: Services, ingress, network policies
- **Scaling**: Replica counts, autoscaling, resource limits
- **Monitoring**: Metrics, service monitors, health checks

Refer to individual chart READMEs for detailed configuration options.

## Get Involved

Want to contribute? Awesome! The most basic way to show your support is to star the project, or to raise issues.

If you want to open a PR, read our [contributing guidelines](CONTRIBUTING.md) for information about setting up your environment and instructions on the signature verification that we require.

> [!TIP] Chat with us!
> Need help or just want to talk?
> Chat with us and the community on our [Discord server](https://discord.gg/XUn9Kt5dsy)
>
> [![Discord](https://img.shields.io/discord/1426189195285762150?logo=discord&label=Discord)](https://discord.gg/XUn9Kt5dsy)

**This project is built and maintained by our growing community of contributors!**

<a href="https://github.com/CloudPirates-io/helm-charts/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=CloudPirates-io/helm-charts" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

### Chart Issues

For issues specific to these Helm charts:

- Check individual chart README files for troubleshooting
- Review chart documentation and examples
- Verify configuration values
- Open an issue on GitHub
