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
Get the secret name for MongoDB root password
*/}}
{{- define "mongodb.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
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
{{- .Values.auth.existingSecret }}
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
