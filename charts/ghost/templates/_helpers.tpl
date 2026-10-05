{{/*
Expand the name of the chart.
*/}}
{{- define "ghost.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "ghost.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ghost.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ghost.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ghost.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "ghost.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Return the proper Ghost image name
*/}}
{{- define "ghost.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper MariaDB init container image name
*/}}
{{- define "ghost.initContainers.waitForMariadb.image" -}}
{{- $config := .Values.initContainers.waitForMariadb -}}
{{- if $config.image -}}
{{- $config.image -}}
{{- else -}}
{{- include "cloudpirates.image" (dict "image" $config "global" .Values.global) -}}
{{- end -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "ghost.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "ghost.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ghost.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return "https" if the given host is covered by an ingress.tls entry, "http" otherwise.
*/}}
{{- define "ghost.hostScheme" -}}
{{- $host := .host -}}
{{- $tls := .tls -}}
{{- $scheme := "http" -}}
{{- range $tls }}
{{- if has $host .hosts }}
{{- $scheme = "https" }}
{{- end }}
{{- end }}
{{- $scheme }}
{{- end }}

{{/*
Return the public site URL for Ghost
*/}}
{{- define "ghost.url" -}}
{{- if .Values.config.url }}
{{- .Values.config.url }}
{{- else if .Values.ingress.enabled }}
{{- $host := (first .Values.ingress.hosts).host }}
{{- $scheme := include "ghost.hostScheme" (dict "host" $host "tls" .Values.ingress.tls) }}
{{- printf "%s://%s" $scheme $host }}
{{- else -}}
{{- /* Loopback, not the Service DNS name: Ghost self-fetches this URL during its own startup
(e.g. the ActivityPub webhook init), before its readiness probe has passed and before the
Service has any Ready endpoints to route to - going through the Service here would deadlock. */ -}}
{{- printf "http://127.0.0.1:%v" .Values.config.server.port }}
{{- end }}
{{- end }}

{{/*
Return the admin URL for Ghost
*/}}
{{- define "ghost.admin_url" -}}
{{- if .Values.config.admin.url }}
{{- .Values.config.admin.url }}
{{- else if ge (len .Values.ingress.hosts) 2 }}
{{- $host := (index .Values.ingress.hosts 1).host }}
{{- $scheme := include "ghost.hostScheme" (dict "host" $host "tls" .Values.ingress.tls) }}
{{- printf "%s://%s" $scheme $host }}
{{- else }}
{{- fail "ERROR: Either config.admin.url must be set, or at least 2 ingress hosts must be configured. Please set config.admin.url or add a second ingress host for the admin interface." }}
{{- end }}
{{- end }}