{{/*
Expand the name of the chart.
*/}}
{{- define "etcd.name" -}}
{{- include "common.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "etcd.fullname" -}}
{{- include "common.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "etcd.chart" -}}
{{- include "common.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "etcd.labels" -}}
{{- include "common.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "etcd.selectorLabels" -}}
{{- include "common.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "etcd.annotations" -}}
{{- include "common.annotations" . -}}
{{- end }}

{{/*
Return the proper etcd image name
*/}}
{{- define "etcd.image" -}}
{{- include "common.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "etcd.imagePullSecrets" -}}
{{ include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "etcd.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "etcd.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Validate etcd values
*/}}
{{- define "etcd.validateValues" -}}
{{- $replicaCount := int .Values.replicaCount }}
{{- if and (gt $replicaCount 1) (eq (mod $replicaCount 2) 0) }}
{{- fail (printf "etcd: Invalid replica count. etcd requires an odd number of replicas for quorum (e.g., 1, 3, 5, 7). Current value: %d" $replicaCount) }}
{{- end }}
{{- end }}

{{/*
Generate etcd initial cluster string
*/}}
{{- define "etcd.initialCluster" -}}
{{- $namespace := .Release.Namespace }}
{{- $name := include "etcd.fullname" . -}}
{{- $peerPort := .Values.service.peerPort -}}
{{- $replicaCount := int .Values.replicaCount }}
{{- $protocol := "http" }}
{{- if .Values.auth.peer.enabled }}
{{- $protocol = "https" }}
{{- end }}
{{- range $i := until $replicaCount }}
{{- if $i }},{{ end -}}{{ $name }}-{{ $i }}={{ $protocol }}://{{ $name }}-{{ $i }}.{{ $name }}-headless.{{ $namespace }}.svc.cluster.local:{{ $peerPort }}
{{- end }}
{{- end }}
