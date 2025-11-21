{{/*
Expand the name of the chart.
*/}}
{{- define "keycloak.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "keycloak.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "keycloak.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "keycloak.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "keycloak.annotations" -}}
{{- with .Values.commonAnnotations }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "keycloak.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper Keycloak image name
*/}}
{{- define "keycloak.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return Keycloak admin credentials secret name
*/}}
{{- define "keycloak.secretName" -}}
{{- if .Values.keycloak.existingSecret -}}
    {{- include "cloudpirates.tplvalues.render" (dict "value" .Values.keycloak.existingSecret "context" .) -}}
{{- else -}}
    {{- include "keycloak.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return Keycloak admin password key
*/}}
{{- define "keycloak.adminPasswordKey" -}}
{{- if .Values.keycloak.existingSecret -}}
    {{- .Values.keycloak.secretKeys.adminPasswordKey -}}
{{- else -}}
admin-password
{{- end -}}
{{- end }}

{{/*
Return database credentials secret name
*/}}
{{- define "keycloak.databaseSecretName" -}}
{{- if .Values.database.existingSecret -}}
    {{- .Values.database.existingSecret -}}
{{- else -}}
    {{- printf "%s-db" (include "keycloak.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return database password key
*/}}
{{- define "keycloak.databasePasswordKey" -}}
{{- if .Values.database.existingSecret -}}
    {{- .Values.database.secretKeys.passwordKey -}}
{{- else -}}
db-password
{{- end -}}
{{- end }}

{{/*
Return database username key
*/}}
{{- define "keycloak.databaseUsernameKey" -}}
{{- if .Values.database.existingSecret -}}
    {{- .Values.database.secretKeys.usernameKey -}}
{{- else -}}
db-username
{{- end -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "keycloak.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "keycloak.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "keycloak.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the Keycloak hostname
*/}}
{{- define "keycloak.hostname" -}}
{{- if .Values.keycloak.hostname -}}
{{- tpl (.Values.keycloak.hostname | toString) $ -}}
{{- else if .Values.ingress.enabled -}}
{{- (index .Values.ingress.hosts 0).host -}}
{{- else -}}
{{- printf "%s.%s.svc.cluster.local" (include "keycloak.fullname" .) .Release.Namespace -}}
{{- end -}}
{{- end }}

{{/*
Return the Keycloak admin hostname
*/}}
{{- define "keycloak.hostnameAdmin" -}}
{{- if .Values.keycloak.hostnameAdmin -}}
{{- tpl (.Values.keycloak.hostnameAdmin | toString) $ -}}
{{- else -}}
{{- include "keycloak.hostname" . -}}
{{- end -}}
{{- end }}

{{/*
Return the Keycloak backchannel hostname
*/}}
{{- define "keycloak.hostnameBackchannel" -}}
{{- if .Values.keycloak.hostnameBackchannel -}}
{{- .Values.keycloak.hostnameBackchannel -}}
{{- else -}}
{{- printf "%s.%s.svc.cluster.local" (include "keycloak.fullname" .) .Release.Namespace -}}
{{- end -}}
{{- end }}

{{/*
Return the database JDBC URL
*/}}
{{- define "keycloak.databaseUrl" -}}
{{- if eq .Values.database.type "h2-file" -}}
{{- printf "jdbc:h2:file:/opt/keycloak/data/keycloak;DB_CLOSE_ON_EXIT=FALSE" -}}
{{- else if eq .Values.database.type "h2-mem" -}}
{{- printf "jdbc:h2:mem:keycloak" -}}
{{- else if eq .Values.database.type "postgres" -}}
{{- if .Values.postgres.enabled -}}
{{- printf "jdbc:postgresql://%s-postgres:%s/%s%s" .Release.Name "5432" (default "keycloak" .Values.postgres.auth.database) (ternary (printf "?%s" .Values.database.jdbcParams) "" (ne .Values.database.jdbcParams "")) -}}
{{- else -}}
{{- printf "jdbc:postgresql://%s:%s/%s%s" .Values.database.host (default "5432" (.Values.database.port | toString)) .Values.database.name (ternary (printf "?%s" .Values.database.jdbcParams) "" (ne .Values.database.jdbcParams "")) -}}
{{- end -}}
{{- else if or (eq .Values.database.type "mysql") (eq .Values.database.type "mariadb") -}}
{{- if .Values.mariadb.enabled -}}
{{- printf "jdbc:%s://%s-mariadb:%s/%s%s" .Values.database.type .Release.Name "3306" (default "keycloak" .Values.mariadb.auth.database) (ternary (printf "?%s" .Values.database.jdbcParams) "" (ne .Values.database.jdbcParams "")) -}}
{{- else -}}
{{- printf "jdbc:%s://%s:%s/%s%s" .Values.database.type .Values.database.host (default "3306" (.Values.database.port | toString)) .Values.database.name (ternary (printf "?%s" .Values.database.jdbcParams) "" (ne .Values.database.jdbcParams "")) -}}
{{- end -}}
{{- else if eq .Values.database.type "mssql" -}}
{{- printf "jdbc:sqlserver://%s:%s;databaseName=%s;%s" .Values.database.host (default "1433" (.Values.database.port | toString)) .Values.database.name (ternary (printf "%s" .Values.database.jdbcParams) "" (ne .Values.database.jdbcParams "")) -}}
{{- end -}}
{{- end }}

{{/*
Return the url to use for probes
*/}}
{{- define "keycloak.probeUrl" -}}
{{- if or (eq .Values.keycloak.httpRelativePath "") (eq .Values.keycloak.httpRelativePath "/") -}}
{{- printf "/realms/master" -}}
{{- else -}}
{{- printf "%s/realms/master" .Values.keycloak.httpRelativePath -}}
{{- end -}}
{{- end }}

{{/*
Return TLS certificate secret name
*/}}
{{- define "keycloak.tlsSecretName" -}}
{{- if .Values.tls.certManager.enabled -}}
    {{- .Values.tls.certManager.secretName | default (printf "%s-tls" (include "keycloak.fullname" .)) -}}
{{- else if .Values.tls.existingSecret -}}
    {{- .Values.tls.existingSecret -}}
{{- else -}}
    {{- printf "%s-tls" (include "keycloak.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return TLS truststore secret name
*/}}
{{- define "keycloak.truststoreSecretName" -}}
{{- if .Values.tls.truststoreExistingSecret -}}
    {{- .Values.tls.truststoreExistingSecret -}}
{{- else -}}
    {{- printf "%s-truststore" (include "keycloak.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return metrics service name
*/}}
{{- define "keycloak.metrics.fullname" -}}
{{- printf "%s-metrics" (include "keycloak.fullname" .) -}}
{{- end -}}

{{/*
Return ServiceMonitor labels
*/}}
{{- define "keycloak.metrics.serviceMonitor.labels" -}}
{{- include "keycloak.labels" . }}
{{- with .Values.metrics.serviceMonitor.additionalLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}
