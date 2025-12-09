{{/*
Expand the name of the chart.
*/}}
{{- define "redis.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "redis.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redis.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redis.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "redis.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "redis.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Get the secret name for Redis password
*/}}
{{- define "redis.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) }}
{{- else }}
{{- include "redis.fullname" . }}
{{- end }}
{{- end }}

{{/*
Get the secret key for Redis password
*/}}
{{- define "redis.secretPasswordKey" -}}
{{- if .Values.auth.existingSecretPasswordKey }}
{{- .Values.auth.existingSecretPasswordKey }}
{{- else }}redis-password
{{- end }}
{{- end }}

{{/*
Return the proper Redis image name
*/}}
{{- define "redis.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "redis.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{- define "redis.configFullName" -}}
{{- if and .Values.config.existingConfigmapKey .Values.config.existingConfigmap }}
{{- printf "%s/%s" .Values.config.mountPath .Values.config.existingConfigmapKey }}
{{- else }}
{{- printf "%s/redis.conf" .Values.config.mountPath }}
{{- end -}}
{{- end -}}

{{/*
Return the proper Redis Sentinel image name
*/}}
{{- define "redis.sentinel.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.sentinel.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Redis metrics image name
*/}}
{{- define "redis.metrics.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.metrics.image "global" .Values.global) -}}
{{- end }}

{{/*
Sentinel selector labels
*/}}
{{- define "redis.sentinel.selectorLabels" -}}
{{- include "redis.selectorLabels" . }}
app.kubernetes.io/component: sentinel
{{- end }}

{{/*
Generate Redis CLI command with automated auth
*/}}
{{- define "redis.cli" -}}
redis-cli
{{- end -}}

{{/*
Generate Redis CLI ping command with automated auth
*/}}
{{- define "redis.ping" -}}
{{ include "redis.cli" . }} ping
{{- end -}}


{{/*
Generate Sentinel CLI command with automated auth and connection info
*/}}
{{- define "redis.sentinelCli" -}}
{{- if .auth -}}
redis-cli -h {{ include "redis.fullname" .context }}-sentinel -p {{ .context.Values.sentinel.port }} -a "${REDIS_PASSWORD}"
{{- else -}}
redis-cli -h {{ include "redis.fullname" .context }}-sentinel -p {{ .context.Values.sentinel.port }}
{{- end -}}
{{- end -}}

{{/*
Common Sentinel master query command
*/}}
{{- define "redis.sentinelMasterQuery" -}}
{{- include "redis.sentinelCli" (dict "auth" .auth "context" .context) }} sentinel get-master-addr-by-name {{ .context.Values.sentinel.masterName }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "redis.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "redis.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
