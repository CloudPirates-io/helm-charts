{{/*
Expand the name of the chart.
*/}}
{{- define "rustfs.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rustfs.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rustfs.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rustfs.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "rustfs.annotations" -}}
{{- with .Values.commonAnnotations }}
{{- toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rustfs.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper RustFS image name
*/}}
{{- define "rustfs.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "rustfs.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Return RustFS credentials secret name
*/}}
{{- define "rustfs.secretName" -}}
{{- if .Values.auth.existingSecret -}}
    {{- .Values.auth.existingSecret -}}
{{- else -}}
    {{- include "rustfs.fullname" . -}}
{{- end -}}
{{- end }}

{{/*
Return RustFS access key
*/}}
{{- define "rustfs.accessKeyKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- printf "%s" .Values.auth.existingSecretAccessKeyKey -}}
{{- else -}}
access-key
{{- end -}}
{{- end }}

{{/*
Return RustFS secret key
*/}}
{{- define "rustfs.secretKeyKey" -}}
{{- if .Values.auth.existingSecret -}}
    {{- printf "%s" .Values.auth.existingSecretSecretKeyKey -}}
{{- else -}}
secret-key
{{- end -}}
{{- end }}

{{/*
Returns RustFS serviceAccount name
*/}}
{{- define "rustfs.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{ default (include "rustfs.fullname" .) .Values.serviceAccount.name }}
    {{- else -}}
        {{ default "default" .Values.serviceAccount.name }}
    {{- end -}}
{{- end -}}

{{/*
Return RustFS data PVC name
*/}}
{{- define "rustfs.dataPvcName" -}}
{{- if .Values.dataPersistence.existingClaim -}}
    {{- .Values.dataPersistence.existingClaim -}}
{{- else -}}
    {{- printf "%s-data" (include "rustfs.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return RustFS logs PVC name
*/}}
{{- define "rustfs.logsPvcName" -}}
{{- if .Values.logsPersistence.existingClaim -}}
    {{- .Values.logsPersistence.existingClaim -}}
{{- else -}}
    {{- printf "%s-logs" (include "rustfs.fullname" .) -}}
{{- end -}}
{{- end }}

{{/*
Return RustFS TLS PVC name
*/}}
{{- define "rustfs.tlsPvcName" -}}
{{- if .Values.tlsPersistence.existingClaim -}}
    {{- .Values.tlsPersistence.existingClaim -}}
{{- else -}}
    {{- printf "%s-tls" (include "rustfs.fullname" .) -}}
{{- end -}}
{{- end }}