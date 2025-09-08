<p align="center">
    <a href="https://artifacthub.io/packages/search?org=cloudpirates">
      <img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates" />
    </a>
</p>

# CloudPirates Open Source Helm Charts

A curated collection of production-ready Helm charts for open-source cloud-native applications.
This repository provides secure, well-documented, and configurable Helm charts following cloud-native best practices (project name "nonami").

## Available Charts

| Chart                                  | Description                                                                                                               |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| [ClusterPirate](charts/clusterpirate/) | Client agent for the CloudPirates Managed Observability Platform to connect your Kubernetes cluster to our infrastructure |
| [Common](charts/common/)               | A library chart for common templates and helper functions                                                                 |
| [MariaDB](charts/mariadb/)             | High-performance, open-source relational database server that is a drop-in replacement for MySQL                          |
| [Memcached](charts/memcached/)         | High-performance, distributed memory object caching system                                                                |
| [MinIO](charts/minio/)                 | High-Performance Object Storage compatible with Amazon S3 APIs                                                            |
| [MongoDB](charts/mongodb/)             | MongoDB a flexible NoSQL database for scalable, real-time data management                                                 |
| [Nginx](charts/nginx/)                 | High-performance HTTP server and reverse proxy                                                                            |
| [PostgreSQL](charts/postgres/)         | The World's Most Advanced Open Source Relational Database                                                                 |
| [RabbitMQ](charts/rabbitmq/)           | A messaging broker that implements the Advanced Message Queuing Protocol (AMQP)                                           |
| [Redis](charts/redis/)                 | In-memory data structure store, used as a database, cache, and message broker                                             |
| [TimescaleDB](charts/timescaledb/)     | TimescaleDB is a PostgreSQL extension for high-performance real-time analytics on time-series and event data              |
| [Valkey](charts/valkey/)               | High-performance in-memory data structure store, fork of Redis                                                            |

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installing Charts

```bash
# From repository
helm install my-release oci://registry-1.docker.io/cloudpirates/<chartname>

# From local clone
helm install my-release ./charts/<chart-name>
```

## Chart Features

All charts in this repository provide:

### 🔒 **Security First**

- **Cryptographically Signed**: All charts are signed with [Cosign](COSIGN.md) for supply chain security
- Non-root containers by default
- Read-only root filesystems where possible
- Dropped Linux capabilities
- Security contexts configured
- No hardcoded credentials

### 📊 **Production Ready**

- Comprehensive health checks (liveness, readiness, startup probes)
- Resource requests and limits support
- Persistent storage configurations
- Rolling update strategies
- Health check endpoints

### 🎛️ **Highly Configurable**

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

## Contributing

Want to contribute? Awesome! The most basic way to show your support is to star the project, or to raise issues. If you want to open a pull request, please read the [contributing guidelines](CONTRIBUTING.md).

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
