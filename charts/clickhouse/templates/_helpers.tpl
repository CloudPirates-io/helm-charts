{{/*
Expand the name of the chart.
*/}}
{{- define "clickhouse.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clickhouse.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "clickhouse.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "clickhouse.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "clickhouse.annotations" -}}
{{- with .Values.commonAnnotations }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "clickhouse.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper ClickHouse image name
*/}}
{{- define "clickhouse.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return ClickHouse credentials secret name
*/}}
{{- define "clickhouse.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) -}}
{{- else -}}
    {{- include "clickhouse.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return ClickHouse admin password key
*/}}
{{- define "clickhouse.passwordKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.secretKeys.passwordKey "context" .) | default "clickhouse-password" -}}
{{- else -}}
clickhouse-password
{{- end -}}
{{- end }}

{{/*
Return ClickHouse configuration ConfigMap name
*/}}
{{- define "clickhouse.configmapName" -}}
{{- if .Values.config.existingConfigmap -}}
    {{- .Values.config.existingConfigmap -}}
{{- else -}}
    {{- printf "%s-config" (include "clickhouse.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return ClickHouse users configuration ConfigMap name
*/}}
{{- define "clickhouse.usersConfigmapName" -}}
{{- if .Values.config.existingUsersConfigmap -}}
    {{- .Values.config.existingUsersConfigmap -}}
{{- else -}}
    {{- printf "%s-users" (include "clickhouse.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return ClickHouse init scripts ConfigMap name
*/}}
{{- define "clickhouse.initdb.scriptsCM" -}}
{{- if .Values.initdb.scriptsConfigMap -}}
    {{- printf "%s" (tpl .Values.initdb.scriptsConfigMap $) -}}
{{- else -}}
    {{- printf "%s-init-scripts" (include "clickhouse.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "clickhouse.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "clickhouse.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "clickhouse.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
