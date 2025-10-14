{{/*
Expand the name of the chart.
*/}}
{{- define "mariadb.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mariadb.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mariadb.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mariadb.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mariadb.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper MariaDB image name
*/}}
{{- define "mariadb.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "mariadb.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}
{{/*
Get the secret name for MariaDB root password
*/}}
{{- define "mariadb.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- include "mariadb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Validate values of MariaDB - Authentication
*/}}
{{- define "mariadb.validateValues.auth" -}}
{{/* No validation needed - empty rootPassword will trigger auto-generation */}}
{{- end }}

{{/*
Return the MariaDB ConfigMap Name
*/}}
{{- define "mariadb.configMapName" -}}
{{- if .Values.config.existingConfigMap }}
{{- printf "%s" (tpl .Values.config.existingConfigMap $) -}}
{{- else }}
{{- include "mariadb.fullname" . }}
{{- end }}
{{- end }}

