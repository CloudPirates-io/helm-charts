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
Return the admin URL for Ghost
*/}}
{{- define "ghost.admin_url" -}}
{{- if .Values.config.admin.url }}
{{- .Values.config.admin.url }}
{{- else }}
{{- printf "https://%s" (index .Values.ingress.hosts 1).host }}
{{- end }}
{{- end }}