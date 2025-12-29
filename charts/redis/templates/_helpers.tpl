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
{{- if or .Values.serviceAccount.create (and .Values.sentinel.enabled .Values.sentinel.masterService.enabled) }}
{{- default (include "redis.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the ACL file name
*/}}
{{- define "redis.auth.acl.file" -}}
{{- default "users.acl" .Values.auth.acl.existingSecretACLKey -}}
{{- end -}}

{{/*
Shell command to extract password for a user from ACL file
Usage: {{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" $) }}
*/}}
{{- define "redis.auth.acl.awkCommand" -}}
{{- $aclFile := include "redis.auth.acl.file" .context -}}
awk '/user {{ .user }}/ { for(i=1;i<=NF;i++) if($i ~ /^>/) print substr($i,2) }' /etc/redis/{{ $aclFile }}
{{- end -}}

{{/*
Script block to setup ACL passwords in shell scripts
Usage: {{ include "redis.auth.acl.setupScript" (dict "type" "init|sentinel|metrics|job|prestop|probe" "context" $) }}
*/}}
{{- define "redis.auth.acl.setupScript" -}}
{{- if .context.Values.auth.acl.enabled -}}
{{- $aclFile := include "redis.auth.acl.file" .context -}}
{{- if eq .type "init" -}}
echo "aclfile /etc/redis/{{ $aclFile }}" >> /tmp/redis.conf
REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
if [ -z "$REDIS_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user default' in /etc/redis/{{ $aclFile }}"
  exit 1
fi
REDIS_SENTINEL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "sentinel" "context" .context) }})
if ! echo "$REDIS_SENTINEL_PASSWORD" | grep -q '[^[:space:]]'; then REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"; fi
{{- else if eq .type "sentinel" -}}
if [ -f /etc/redis/{{ $aclFile }} ]; then
  REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
  REDIS_SENTINEL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "sentinel" "context" .context) }})
  [ -z "$REDIS_SENTINEL_PASSWORD" ] && REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"
fi
{{- else if eq .type "metrics" -}}
if [ -f /etc/redis/{{ $aclFile }} ]; then
  ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
  if [ -n "$ACL_PASSWORD" ]; then
    export REDIS_PASSWORD="$ACL_PASSWORD"
  fi
fi
{{- else if eq .type "job" -}}
if [ -f /etc/redis/{{ $aclFile }} ]; then
  ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
  if [ -n "$ACL_PASSWORD" ]; then
    export REDIS_PASSWORD="$ACL_PASSWORD"
    export REDISCLI_AUTH="$ACL_PASSWORD"
  fi
fi
{{- else if eq .type "prestop" -}}
if [ -f /etc/redis/{{ $aclFile }} ]; then
    ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
    if [ -n "$ACL_PASSWORD" ]; then
        export REDISCLI_AUTH="$ACL_PASSWORD"
        export REDIS_PASSWORD="$ACL_PASSWORD"
    fi
    SENTINEL_ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "sentinel" "context" .context) }})
    if [ -n "$SENTINEL_ACL_PASSWORD" ]; then
        export REDIS_SENTINEL_PASSWORD="$SENTINEL_ACL_PASSWORD"
    else
        export REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"
    fi
fi
{{- else if eq .type "probe" -}}
export REDISCLI_AUTH=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
{{- else if eq .type "sentinel-probe" -}}
export REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "sentinel" "context" .context) }})
[ -z "$REDIS_PASSWORD" ] && export REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
{{- else if eq .type "master-discovery" -}}
if [ -f /etc/redis/{{ $aclFile }} ]; then
  ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "sentinel" "context" .context) }})
  [ -z "$ACL_PASSWORD" ] && ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" .context) }})
  if [ -n "$ACL_PASSWORD" ]; then
    REDIS_PASSWORD="$ACL_PASSWORD"
  fi
fi
{{- end -}}
{{- end -}}
{{- end -}}
