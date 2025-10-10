{{/*
Expand the name of the chart.
*/}}
{{- define "nginx.name" -}}
{{- include "common.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nginx.fullname" -}}
{{- include "common.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx.chart" -}}
{{- include "common.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx.labels" -}}
{{- include "common.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
{{- include "common.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "nginx.annotations" -}}
{{- include "common.annotations" . -}}
{{- end }}

{{/*
Return the proper Nginx image name
*/}}
{{- define "nginx.image" -}}
{{- include "common.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "nginx.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "nginx.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "nginx.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Return the custom NGINX config configmap.
*/}}
{{- define "nginx.configConfigmapName" -}}
{{- if .Values.existingConfigConfigmap -}}
    {{- printf "%s" (tpl .Values.existingConfigConfigmap $) -}}
{{- else -}}
    {{- include "common.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the custom NGINX server config configmap.
*/}}
{{- define "nginx.serverConfigConfigmapName" -}}
{{- if .Values.existingServerConfigConfigmap -}}
    {{- printf "%s" (tpl .Values.existingServerConfigConfigmap $) -}}
{{- else -}}
    {{- include "common.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the custom NGINX stream server config configmap.
*/}}
{{- define "nginx.streamServerConfigConfigmapName" -}}
{{- if .Values.existingStreamServerConfigConfigmap -}}
    {{- printf "%s" (tpl .Values.existingStreamServerConfigConfigmap $) -}}
{{- else -}}
    {{- include "common.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Nginx metrics image name
*/}}
{{- define "nginx.metrics.image" -}}
{{- include "common.image" (dict "image" .Values.metrics.image "global" .Values.global) -}}
{{- end }}
