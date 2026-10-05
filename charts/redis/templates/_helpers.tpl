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
{{- .Values.auth.existingSecretPasswordKey }}
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
Return the proper Redis volume permissions image name
*/}}
{{- define "redis.volumePermissions.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.volumePermissions.image "global" .Values.global) -}}
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
redis-cli -h {{ include "redis.fullname" .context }}-sentinel -p {{ .context.Values.sentinel.port }}
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
Validate ACL configuration - ensure existingSecret and existingFilePath are mutually exclusive
Usage: {{ include "redis.acl.validate" (dict "values" .Values.auth.acl "label" "auth.acl") }}
*/}}
{{- define "redis.acl.validate" -}}
{{- if and .values.existingSecret .values.existingFilePath -}}
{{- fail (printf "%s.existingSecret and %s.existingFilePath are mutually exclusive. Please use only one of them." .label .label) -}}
{{- end -}}
{{- if and .values.enabled (not .values.existingSecret) (not .values.existingFilePath) -}}
{{- fail (printf "%s.enabled is true but neither %s.existingSecret nor %s.existingFilePath is set. Please provide an ACL source." .label .label .label) -}}
{{- end -}}
{{- end -}}

{{- define "redis.auth.acl.validate" -}}
{{- include "redis.acl.validate" (dict "values" .Values.auth.acl "label" "auth.acl") -}}
{{- end -}}

{{- define "redis.sentinel.acl.validate" -}}
{{- include "redis.acl.validate" (dict "values" .Values.sentinel.acl "label" "sentinel.acl") -}}
{{- end -}}

{{/*
Validate externalMaster configuration - only supported for architecture=replication, and requires a host
*/}}
{{- define "redis.externalMaster.validate" -}}
{{- if .Values.externalMaster.enabled -}}
{{- if ne .Values.architecture "replication" -}}
{{- fail "externalMaster.enabled is only supported when architecture=replication." -}}
{{- end -}}
{{- if not .Values.externalMaster.host -}}
{{- fail "externalMaster.enabled is true but externalMaster.host is not set. Please provide the external master's hostname or IP." -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the ACL file name
Usage: {{ include "redis.acl.file" (dict "values" .Values.auth.acl "defaultFile" "users.acl") }}
*/}}
{{- define "redis.acl.file" -}}
{{- default .defaultFile .values.existingSecretACLKey -}}
{{- end -}}

{{- define "redis.auth.acl.file" -}}
{{- include "redis.acl.file" (dict "values" .Values.auth.acl "defaultFile" "users.acl") -}}
{{- end -}}

{{- define "redis.sentinel.acl.file" -}}
{{- include "redis.acl.file" (dict "values" .Values.sentinel.acl "defaultFile" "sentinel-users.acl") -}}
{{- end -}}

{{/*
Return the full path to an ACL file
Usage: {{ include "redis.acl.path" (dict "values" .Values.auth.acl "defaultFile" "users.acl" "basePath" "/etc/redis") }}
*/}}
{{- define "redis.acl.path" -}}
{{- if .values.existingFilePath -}}
{{- .values.existingFilePath -}}
{{- else -}}
{{- printf "%s/%s" .basePath (include "redis.acl.file" (dict "values" .values "defaultFile" .defaultFile)) -}}
{{- end -}}
{{- end -}}

{{- define "redis.auth.acl.path" -}}
{{- include "redis.acl.path" (dict "values" .Values.auth.acl "defaultFile" "users.acl" "basePath" "/etc/redis") -}}
{{- end -}}

{{- define "redis.sentinel.acl.path" -}}
{{- include "redis.acl.path" (dict "values" .Values.sentinel.acl "defaultFile" "sentinel-users.acl" "basePath" "/etc/redis/sentinel") -}}
{{- end -}}

{{/*
Return an ACL username, validating it against the allowed character set
Usage: {{ include "redis.acl.username" (dict "value" .Values.auth.acl.defaultUsername "default" "default" "label" "auth.acl.defaultUsername") }}
*/}}
{{- define "redis.acl.username" -}}
{{- $u := default .default .value -}}
{{- if not (regexMatch "^[A-Za-z0-9._-]+$" $u) -}}
{{- fail (printf "%s must match ^[A-Za-z0-9._-]+$ (got %q)" .label $u) -}}
{{- end -}}
{{- $u -}}
{{- end -}}

{{/*
Return the ACL username for the 'default' Redis user
*/}}
{{- define "redis.auth.acl.defaultUsername" -}}
{{- include "redis.acl.username" (dict "value" .Values.auth.acl.defaultUsername "default" "default" "label" "auth.acl.defaultUsername") -}}
{{- end -}}

{{/*
Return the ACL username Sentinel uses to authenticate to the monitored Redis instances
*/}}
{{- define "redis.auth.acl.sentinelUsername" -}}
{{- include "redis.acl.username" (dict "value" .Values.auth.acl.sentinelUsername "default" "sentinel" "label" "auth.acl.sentinelUsername") -}}
{{- end -}}

{{/*
Return the ACL username for the 'default' Sentinel user
*/}}
{{- define "redis.sentinel.acl.defaultUsername" -}}
{{- include "redis.acl.username" (dict "value" .Values.sentinel.acl.defaultUsername "default" "default" "label" "sentinel.acl.defaultUsername") -}}
{{- end -}}

{{/*
Shell script block to check if ACL file exists, fails if not
Usage: {{ include "redis.auth.acl.checkFile" . }}
*/}}
{{- define "redis.auth.acl.checkFile" -}}
{{- $aclPath := include "redis.auth.acl.path" . -}}
if [ ! -f '{{ $aclPath }}' ]; then
  echo "ERROR: ACL file '{{ $aclPath }}' not found"
  exit 1
fi
{{ end }}

{{/*
Shell command to extract password for a user from an ACL file
Usage: {{ include "redis.acl.awkCommand" (dict "user" "default" "aclPath" $aclPath) }}
*/}}
{{- define "redis.acl.awkCommand" -}}
awk '$1=="user" && $2=="{{ .user }}" { for (i=3; i<=NF; i++) if ($i ~ /^>/) { print substr($i,2); break } }' '{{ .aclPath }}'
{{- end -}}

{{/*
Shell command to extract password for a user from ACL file
Usage: {{ include "redis.auth.acl.awkCommand" (dict "user" "default" "context" $) }}
*/}}
{{- define "redis.auth.acl.awkCommand" -}}
{{- include "redis.acl.awkCommand" (dict "user" .user "aclPath" (include "redis.auth.acl.path" .context)) -}}
{{- end -}}

{{/*
Shell command to extract password for a user from the Sentinel ACL file
Usage: {{ include "redis.sentinel.acl.awkCommand" (dict "user" "default" "context" $) }}
*/}}
{{- define "redis.sentinel.acl.awkCommand" -}}
{{- include "redis.acl.awkCommand" (dict "user" .user "aclPath" (include "redis.sentinel.acl.path" .context)) -}}
{{- end -}}

{{/*
Script block to setup ACL passwords in shell scripts
Usage: {{ include "redis.auth.acl.setupScript" (dict "type" "init|sentinel|metrics|job|prestop|probe" "context" $) }}
*/}}
{{- define "redis.auth.acl.setupScript" -}}
{{- $aclPath := include "redis.auth.acl.path" .context -}}
{{- $defaultUser := include "redis.auth.acl.defaultUsername" .context -}}
{{- $sentinelUser := include "redis.auth.acl.sentinelUsername" .context -}}
{{- $sentinelAclUser := include "redis.sentinel.acl.defaultUsername" .context -}}
{{- if and (eq .type "sentinel-probe") .context.Values.sentinel.acl.enabled }}
export REDISCLI_AUTH=$({{ include "redis.sentinel.acl.awkCommand" (dict "user" $sentinelAclUser "context" .context) }})
if [ -z "$REDISCLI_AUTH" ]; then
  echo "ERROR: Sentinel ACL is enabled but no password found for 'user {{ $sentinelAclUser }}' in '{{ include "redis.sentinel.acl.path" .context }}'"
  exit 1
fi
export REDIS_PASSWORD="$REDISCLI_AUTH"
{{- else if and (eq .type "master-discovery") .context.Values.sentinel.acl.enabled }}
ACL_PASSWORD=$({{ include "redis.sentinel.acl.awkCommand" (dict "user" $sentinelAclUser "context" .context) }})
if [ -z "$ACL_PASSWORD" ]; then
  echo "ERROR: Sentinel ACL is enabled but no password found for 'user {{ $sentinelAclUser }}' in '{{ include "redis.sentinel.acl.path" .context }}'"
  exit 1
fi
REDIS_PASSWORD="$ACL_PASSWORD"
{{- else if .context.Values.auth.acl.enabled }}
{{ include "redis.auth.acl.checkFile" .context }}
{{- if eq .type "init" -}}
echo "aclfile {{ $aclPath }}" >> /tmp/redis.conf
REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$REDIS_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
  exit 1
fi
export REDISCLI_AUTH="$REDIS_PASSWORD"
REDIS_SENTINEL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $sentinelUser "context" .context) }})
if [ -z "$REDIS_SENTINEL_PASSWORD" ]; then
  REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"
  REDIS_SENTINEL_USERNAME="{{ $defaultUser }}"
else
  REDIS_SENTINEL_USERNAME="{{ $sentinelUser }}"
fi
export REDIS_SENTINEL_USERNAME
{{- else if eq .type "sentinel" -}}
REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$REDIS_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
  exit 1
fi
export REDISCLI_AUTH="$REDIS_PASSWORD"
REDIS_SENTINEL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $sentinelUser "context" .context) }})
if [ -z "$REDIS_SENTINEL_PASSWORD" ]; then
  REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"
  REDIS_SENTINEL_USERNAME="{{ $defaultUser }}"
else
  REDIS_SENTINEL_USERNAME="{{ $sentinelUser }}"
fi
export REDIS_SENTINEL_USERNAME
{{- else if eq .type "metrics" -}}
ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$ACL_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
  exit 1
fi
export REDIS_PASSWORD="$ACL_PASSWORD"
export REDIS_USER="{{ $defaultUser }}"
{{- else if eq .type "job" -}}
ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$ACL_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
  exit 1
fi
export REDIS_PASSWORD="$ACL_PASSWORD"
export REDISCLI_AUTH="$ACL_PASSWORD"
{{- else if eq .type "prestop" -}}
ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$ACL_PASSWORD" ]; then
    echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
    exit 1
fi
export REDISCLI_AUTH="$ACL_PASSWORD"
export REDIS_PASSWORD="$ACL_PASSWORD"
SENTINEL_ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $sentinelUser "context" .context) }})
if [ -n "$SENTINEL_ACL_PASSWORD" ]; then
    export REDIS_SENTINEL_PASSWORD="$SENTINEL_ACL_PASSWORD"
else
    export REDIS_SENTINEL_PASSWORD="$REDIS_PASSWORD"
fi
{{- else if eq .type "probe" -}}
export REDISCLI_AUTH=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$REDISCLI_AUTH" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' in '{{ $aclPath }}'"
  exit 1
fi
{{- else if eq .type "sentinel-probe" -}}
export REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $sentinelUser "context" .context) }})
[ -z "$REDIS_PASSWORD" ] && export REDIS_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$REDIS_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' or 'user {{ $sentinelUser }}' in '{{ $aclPath }}'"
  exit 1
fi
export REDISCLI_AUTH="$REDIS_PASSWORD"
{{- else if eq .type "master-discovery" -}}
ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $sentinelUser "context" .context) }})
[ -z "$ACL_PASSWORD" ] && ACL_PASSWORD=$({{ include "redis.auth.acl.awkCommand" (dict "user" $defaultUser "context" .context) }})
if [ -z "$ACL_PASSWORD" ]; then
  echo "ERROR: ACL is enabled but no password found for 'user {{ $defaultUser }}' or 'user {{ $sentinelUser }}' in '{{ $aclPath }}'"
  exit 1
fi
REDIS_PASSWORD="$ACL_PASSWORD"
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate TLS certificate arguments for redis-cli probes
When client certificates are available, use them for client authentication
Otherwise fall back to server certificates (for backwards compatibility)
Usage: {{ include "redis.tls.probeArgs" . }}
*/}}
{{- define "redis.tls.probeArgs" -}}
{{- if .Values.tls.enabled -}}
{{- if .Values.tls.client.existingSecret -}}
--tls --cert /etc/redis/tls-client/{{ .Values.tls.client.certFilename }} --key /etc/redis/tls-client/{{ .Values.tls.client.certKeyFilename }} --cacert /etc/redis/tls/{{ .Values.tls.certCAFilename }}
{{- else -}}
--tls --cert /etc/redis/tls/{{ .Values.tls.certFilename }} --key /etc/redis/tls/{{ .Values.tls.certKeyFilename }} --cacert /etc/redis/tls/{{ .Values.tls.certCAFilename }}
{{- end -}}
{{- end -}}
{{- end -}}
