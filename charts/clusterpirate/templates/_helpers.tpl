{{/*
Expand the name of the chart.
*/}}
{{- define "clusterpirate.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "clusterpirate.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "clusterpirate.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "clusterpirate.annotations" -}}
{{- include "cloudpirates.annotations" . }}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "clusterpirate.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "clusterpirate.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
common.matchLabels (legacy compatibility)
*/}}
{{- define "clusterpirate.matchLabels"}}
app: {{ template "clusterpirate.name" . }}
release: {{ .Release.Name }}
{{- end}}

{{- define "clusterpirate.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{- default (include "clusterpirate.fullname" .) (print .Values.serviceAccount.name) -}}
    {{- else -}}
        {{- default "default" (print .Values.serviceAccount.name) -}}
    {{- end -}}
{{- end -}}

{{/*
Return the proper ClusterPirate image name
*/}}
{{- define "clusterpirate.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}