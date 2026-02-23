#!/bin/bash

# Update dependencies for all charts that have them
# The common chart is a library chart and doesn't have dependencies

charts=(
  "etcd"
  "ghost"
  "keycloak"
  "mariadb"
  "memcached"
  "minio"
  "mongodb"
  "nginx"
  "postgres"
  "rabbitmq-cluster-operator"
  "rabbitmq"
  "redis"
  "rustfs"
  "timescaledb"
  "valkey"
  "zookeeper"
  "clusterpirate"
)

echo "Updating Helm chart dependencies..."
echo "===================================="

for chart in "${charts[@]}"; do
  echo ""
  echo "Updating dependencies for $chart..."
  if helm dependency update "charts/$chart"; then
    echo "✓ Successfully updated dependencies for $chart"
  else
    echo "✗ Failed to update dependencies for $chart"
    exit 1
  fi
done

echo ""
echo "===================================="
echo "All chart dependencies updated successfully!"
