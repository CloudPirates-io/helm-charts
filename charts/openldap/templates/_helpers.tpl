{{/*
Expand the name of the chart.
*/}}
{{- define "openldap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "openldap.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "openldap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openldap.labels" -}}
helm.sh/chart: {{ include "openldap.chart" . }}
{{ include "openldap.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openldap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openldap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openldap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openldap.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper OpenLDAP image name
*/}}
{{- define "openldap.image" -}}
{{- $registry := .Values.global.imageRegistry | default .Values.image.registry -}}
{{- $repository := .Values.image.repository -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- if $registry }}
{{- printf "%s/%s:%s" $registry $repository $tag -}}
{{- else }}
{{- printf "%s:%s" $repository $tag -}}
{{- end }}
{{- end }}

{{/*
Return the proper base DN
*/}}
{{- define "openldap.baseDN" -}}
{{- if .Values.config.baseDN }}
{{- .Values.config.baseDN }}
{{- else }}
{{- $parts := splitList "." .Values.config.domain }}
{{- $dcParts := list }}
{{- range $parts }}
{{- $dcParts = append $dcParts (printf "dc=%s" .) }}
{{- end }}
{{- join "," $dcParts }}
{{- end }}
{{- end }}

{{/*
Return the admin password secret name
*/}}
{{- define "openldap.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- include "openldap.fullname" . }}
{{- end }}
{{- end }}
