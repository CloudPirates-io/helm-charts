{{/*
Expand the name of the chart.
*/}}
{{- define "nginx.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "nginx.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "nginx.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "nginx.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "nginx.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Return the proper Nginx image name
*/}}
{{- define "nginx.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "nginx.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
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
    {{- include "cloudpirates.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the custom NGINX server config configmap.
*/}}
{{- define "nginx.serverConfigConfigmapName" -}}
{{- if .Values.existingServerConfigConfigmap -}}
    {{- printf "%s" (tpl .Values.existingServerConfigConfigmap $) -}}
{{- else -}}
    {{- include "cloudpirates.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the custom NGINX stream server config configmap.
*/}}
{{- define "nginx.streamServerConfigConfigmapName" -}}
{{- if .Values.existingStreamServerConfigConfigmap -}}
    {{- printf "%s" (tpl .Values.existingStreamServerConfigConfigmap $) -}}
{{- else -}}
    {{- include "cloudpirates.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Nginx metrics image name
*/}}
{{- define "nginx.metrics.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.metrics.image "global" .Values.global) -}}
{{- end }}

{{/*
Return true if a static site should be loaded from a ConfigMap
*/}}
{{- define "nginx.useStaticSite" -}}
{{- if or .Values.cloneStaticSiteFromGit.enabled .Values.staticSiteConfigmap -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the static site volume
*/}}
{{- define "nginx.staticSiteVolume" -}}
{{- if .Values.cloneStaticSiteFromGit.enabled }}
emptyDir: {}
{{- else if .Values.staticSiteConfigmap }}
configMap:
  name: {{ .Values.staticSiteConfigmap }}
{{- end }}
{{- end -}}
