{{/*
Expand the name of the chart.
*/}}
{{- define "timescaledb.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "timescaledb.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "timescaledb.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "timescaledb.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "timescaledb.annotations" -}}
{{- with .Values.commonAnnotations }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "timescaledb.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper TimescaleDB image name
*/}}
{{- define "timescaledb.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return TimescaleDB credentials secret name
*/}}
{{- define "timescaledb.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) -}}
{{- else -}}
    {{- include "timescaledb.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return TimescaleDB admin password key
*/}}
{{- define "timescaledb.adminPasswordKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- .Values.auth.secretKeys.adminPasswordKey -}}
{{- else -}}
postgres-password
{{- end -}}
{{- end }}

{{/*
Return TimescaleDB configuration ConfigMap name
*/}}
{{- define "timescaledb.configmapName" -}}
{{- if .Values.config.existingConfigmap -}}
    {{- .Values.config.existingConfigmap -}}
{{- else -}}
    {{- include "timescaledb.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return TimescaleDB data directory
*/}}
{{- define "timescaledb.dataDir" -}}
{{- printf "/var/lib/postgresql/data" -}}
{{- end }}

{{/*
Return TimescaleDB config directory
*/}}
{{- define "timescaledb.configDir" -}}
{{- printf "/etc/postgresql" -}}
{{- end }}

{{/*
Return TimescaleDB run directory
*/}}
{{- define "timescaledb.runDir" -}}
{{- printf "/var/run/postgresql" -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "timescaledb.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}