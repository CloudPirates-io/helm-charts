{{/*
Expand the name of the chart.
*/}}
{{- define "postgres.name" -}}
{{- include "common.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgres.fullname" -}}
{{- include "common.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "postgres.chart" -}}
{{- include "common.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgres.labels" -}}
{{- include "common.labels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "postgres.annotations" -}}
{{- with .Values.commonAnnotations }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgres.selectorLabels" -}}
{{- include "common.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper PostgreSQL image name
*/}}
{{- define "postgres.image" -}}
{{- include "common.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return PostgreSQL credentials secret name
*/}}
{{- define "postgres.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- .Values.auth.existingSecret -}}
{{- else -}}
    {{- include "postgres.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return PostgreSQL admin password key
*/}}
{{- define "postgres.adminPasswordKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- .Values.auth.secretKeys.adminPasswordKey -}}
{{- else -}}
postgres-password
{{- end -}}
{{- end }}

{{/*
Return PostgreSQL user password key
*/}}
{{- define "postgres.userPasswordKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- .Values.auth.secretKeys.userPasswordKey -}}
{{- else -}}
password
{{- end -}}
{{- end }}

{{/*
Return PostgreSQL configuration ConfigMap name
*/}}
{{- define "postgres.configmapName" -}}
{{- if .Values.config.existingConfigmap -}}
    {{- .Values.config.existingConfigmap -}}
{{- else -}}
    {{- include "postgres.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return PostgreSQL initialization scripts ConfigMap name
*/}}
{{- define "postgres.initdb.scriptsCM" -}}
{{- if .Values.initdb.scriptsConfigMap -}}
    {{- printf "%s" (tpl .Values.initdb.scriptsConfigMap $) -}}
{{- else -}}
    {{- printf "%s-init-scripts" (include "postgres.fullname" .) -}}
{{- end -}}
{{- end -}}


{{/*
Return PostgreSQL config directory
*/}}
{{- define "postgres.configDir" -}}
{{- printf "/etc/postgresql" -}}
{{- end }}

{{/*
Return PostgreSQL run directory
*/}}
{{- define "postgres.runDir" -}}
{{- printf "/var/run/postgresql" -}}
{{- end }}

{{/*
Get PostgreSQL database name
*/}}
{{- define "postgres.database" -}}
{{- if .Values.auth.database -}}
{{- .Values.auth.database -}}
{{- else -}}
postgres
{{- end -}}
{{- end }}

{{/*
Get PostgreSQL username
*/}}
{{- define "postgres.username" -}}
{{- if .Values.auth.username -}}
{{- .Values.auth.username -}}
{{- else -}}
postgres
{{- end -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "postgres.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "postgres.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "postgres.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "postgres.custom-user-configname" -}}
{{- printf "%s-custom-user-credentials" (include "postgres.fullname" .) -}}
{{- end }}

{{/*
Extract PostgreSQL major version from image tag
*/}}
{{- define "postgres.majorVersion" -}}
{{- $tag := .Values.image.tag -}}
{{- if contains "@" $tag -}}
  {{- $tag = (split "@" $tag)._0 -}}
{{- end -}}
{{- if contains "." $tag -}}
  {{- (split "." $tag)._0 -}}
{{- else -}}
  {{- $tag -}}
{{- end -}}
{{- end }}

{{/*
Return PostgreSQL data directory based on major version
For PostgreSQL 18+, use version-specific path; for older versions use traditional path
*/}}
{{- define "postgres.dataDir" -}}
{{- $majorVersion := include "postgres.majorVersion" . | int -}}
{{- if ge $majorVersion 18 -}}
{{- printf "/var/lib/postgresql" -}}
{{- else -}}
{{- printf "/var/lib/postgresql/data" -}}
{{- end -}}
{{- end }}

{{/*
Return PGDATA path based on major version
For PostgreSQL 18+, use version-specific PGDATA; for older versions use traditional PGDATA
*/}}
{{- define "postgres.pgdataPath" -}}
{{- $majorVersion := include "postgres.majorVersion" . | int -}}
{{- if ge $majorVersion 18 -}}
{{- printf "/var/lib/postgresql/%d/docker" $majorVersion -}}
{{- else -}}
{{- printf "/var/lib/postgresql/data/pgdata" -}}
{{- end -}}
{{- end }}