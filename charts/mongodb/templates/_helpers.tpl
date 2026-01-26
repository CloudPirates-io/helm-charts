{{/*
Expand the name of the chart.
*/}}
{{- define "mongodb.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "mongodb.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongodb.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongodb.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongodb.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "mongodb.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongodb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mongodb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get the secret name for MongoDB root password
*/}}
{{- define "mongodb.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) }}
{{- else }}
{{- include "mongodb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Get the secret key for MongoDB root password
*/}}
{{- define "mongodb.secretPasswordKey" -}}
{{- if .Values.auth.existingSecretPasswordKey }}
{{- .Values.auth.existingSecretPasswordKey }}
{{- else }}mongodb-root-password
{{- end }}
{{- end }}

{{/*
Return the proper MongoDB image name
*/}}
{{- define "mongodb.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "mongodb.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{- define "mongodb.configFullName" -}}
{{- if and .Values.config.existingConfigmapKey .Values.config.existingConfigmap }}
{{- printf "%s/%s" .Values.config.mountPath .Values.config.existingConfigmapKey }}
{{- else }}
{{- printf "%s/mongod.conf" .Values.config.mountPath }}
{{- end -}}
{{- end -}}

{{/*
Return the proper MongoDB Exporter image name
*/}}
{{- define "mongodb.metrics.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.metrics.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the MongoDB connection string for metrics
*/}}
{{- define "mongodb.metrics.connectionString" -}}
{{- if .Values.auth.enabled -}}
mongodb://$(MONGO_METRICS_USERNAME):$(MONGO_METRICS_PASSWORD)@127.0.0.1:27017/admin?authSource=admin
{{- else -}}
mongodb://127.0.0.1:27017
{{- end -}}
{{- end -}}

{{/*
Get the secret name for MongoDB metrics user
*/}}
{{- define "mongodb.metrics.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) }}
{{- else if and .Values.metrics.username .Values.metrics.enabled }}
{{- printf "%s-metrics" (include "mongodb.fullname" .) }}
{{- else }}
{{- include "mongodb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Return metrics service name
*/}}
{{- define "mongodb.metrics.fullname" -}}
{{- printf "%s-metrics" (include "mongodb.fullname" .) -}}
{{- end -}}

{{/*
Return ServiceMonitor labels
*/}}
{{- define "mongodb.metrics.serviceMonitor.labels" -}}
{{- include "mongodb.labels" . }}
{{- with .Values.metrics.serviceMonitor.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{/*
Additional helper functions needed for sharded cluster
*/}}
{{- define "mongodb.metricsSecretPasswordKey" -}}
{{- if and .Values.metrics.username .Values.metrics.enabled }}
mongodb-metrics-password
{{- else }}
{{- include "mongodb.secretPasswordKey" . -}}
{{- end }}
{{- end -}}

{{- define "mongodb.configMapName" -}}
{{- if .Values.config.existingConfigmap }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.config.existingConfigmap "context" .) }}
{{- else }}
{{- include "mongodb.fullname" . }}
{{- end }}
{{- end -}}

{{/*
Helper functions for sharded cluster configuration
*/}}

{{/*
Return the keyfile secret name for replica set authentication
*/}}
{{- define "mongodb.keyfileSecretName" -}}
{{- if .Values.replicaSet.keySecretName }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.replicaSet.keySecretName "context" .) }}
{{- else }}
{{- printf "%s-keyfile" (include "mongodb.fullname" .) }}
{{- end }}
{{- end -}}

{{/*
Validate sharded cluster configuration
*/}}
{{- define "mongodb.validateShardedCluster" -}}
{{- if and .Values.shardedCluster.enabled .Values.replicaSet.enabled }}
{{- fail "Cannot enable both shardedCluster and replicaSet modes simultaneously" }}
{{- end }}
{{- if and .Values.shardedCluster.enabled (lt (int .Values.shardedCluster.shards) 2) }}
{{- fail "Sharded cluster requires at least 2 shards (shardedCluster.shards >= 2)" }}
{{- end }}
{{- if and .Values.shardedCluster.enabled (lt (int .Values.shardedCluster.configsvr.replicaCount) 1) }}
{{- fail "Sharded cluster requires at least 1 config server (shardedCluster.configsvr.replicaCount >= 1)" }}
{{- end }}
{{- if and .Values.shardedCluster.enabled (lt (int .Values.shardedCluster.mongos.replicaCount) 1) }}
{{- fail "Sharded cluster requires at least 1 mongos router (shardedCluster.mongos.replicaCount >= 1)" }}
{{- end }}
{{- if and .Values.shardedCluster.enabled (lt (int .Values.shardedCluster.shardsvr.dataNode.replicaCount) 1) }}
{{- fail "Each shard requires at least 1 data node replica (shardedCluster.shardsvr.dataNode.replicaCount >= 1)" }}
{{- end }}
{{- end -}}

{{/*
Return config server connection string for mongos
*/}}
{{- define "mongodb.configServerConnectionString" -}}
{{- $configRsName := printf "%s-configserver-rs" (include "mongodb.fullname" .) -}}
{{- $configService := printf "%s-configserver-headless.%s.svc.%s" (include "mongodb.fullname" .) .Release.Namespace (.Values.replicaSet.clusterDomain | default "cluster.local") -}}
{{- $configServers := list -}}
{{- range $i := until (int .Values.shardedCluster.configsvr.replicaCount) -}}
{{- $host := printf "%s-configserver-%d.%s:27017" (include "mongodb.fullname" $) $i $configService -}}
{{- $configServers = append $configServers $host -}}
{{- end -}}
{{- printf "%s/%s" $configRsName (join "," $configServers) -}}
{{- end -}}

{{/*
Return shard replica set connection string
*/}}
{{- define "mongodb.shardConnectionString" -}}
{{- $shardIndex := .shardIndex -}}
{{- $context := .context -}}
{{- $shardRsName := printf "%s-shard-%d-rs" (include "mongodb.fullname" $context) $shardIndex -}}
{{- $shardService := printf "%s-shard-%d-headless.%s.svc.%s" (include "mongodb.fullname" $context) $shardIndex $context.Release.Namespace ($context.Values.replicaSet.clusterDomain | default "cluster.local") -}}
{{- $shardMembers := list -}}
{{- range $i := until (int $context.Values.shardedCluster.shardsvr.dataNode.replicaCount) -}}
{{- $host := printf "%s-shard-%d-%d.%s:27017" (include "mongodb.fullname" $context) $shardIndex $i $shardService -}}
{{- $shardMembers = append $shardMembers $host -}}
{{- end -}}
{{- printf "%s/%s" $shardRsName (join "," $shardMembers) -}}
{{- end -}}

{{/*
Return deployment mode for current configuration
*/}}
{{- define "mongodb.deploymentMode" -}}
{{- if .Values.shardedCluster.enabled -}}
sharded-cluster
{{- else if .Values.replicaSet.enabled -}}
replica-set
{{- else -}}
standalone
{{- end -}}
{{- end -}}
