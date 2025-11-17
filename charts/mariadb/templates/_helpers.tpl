{{/*
Expand the name of the chart.
*/}}
{{- define "mariadb.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mariadb.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mariadb.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mariadb.labels" -}}
{{- include "cloudpirates.labels" . -}}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mariadb.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Return the proper MariaDB image name
*/}}
{{- define "mariadb.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "mariadb.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}
{{/*
Get the secret name for MariaDB root password
*/}}
{{- define "mariadb.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- include "cloudpirates.tplvalues.render" (dict "value" .Values.auth.existingSecret "context" .) }}
{{- else }}
{{- include "mariadb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Validate values of MariaDB - Authentication
*/}}
{{- define "mariadb.validateValues.auth" -}}
{{/* No validation needed - empty rootPassword will trigger auto-generation */}}
{{- end }}

{{/*
Return the MariaDB ConfigMap Name
*/}}
{{- define "mariadb.configMapName" -}}
{{- if .Values.config.existingConfigMap }}
{{- printf "%s" (tpl .Values.config.existingConfigMap $) -}}
{{- else }}
{{- include "mariadb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Get the secret name for Galera SST authentication
*/}}
{{- define "mariadb.galeraSecretName" -}}
{{- if .Values.galera.sst.existingSecret }}
{{- .Values.galera.sst.existingSecret }}
{{- else }}
{{- printf "%s-galera" (include "mariadb.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Generate Galera cluster address list
*/}}
{{- define "mariadb.galeraClusterAddress" -}}
{{- $fullname := include "mariadb.fullname" . -}}
{{- $replicaCount := int .Values.galera.replicaCount -}}
{{- $namespace := .Release.Namespace -}}
{{- $addresses := list -}}
{{- range $i := until $replicaCount -}}
{{- $addresses = append $addresses (printf "%s-%d.%s.%s.svc.cluster.local:4567" $fullname $i $fullname $namespace) -}}
{{- end -}}
{{- join "," $addresses -}}
{{- end }}

{{/*
Generate Galera cluster name with release context
*/}}
{{- define "mariadb.galeraClusterName" -}}
{{- printf "%s-%s" .Release.Name .Values.galera.name -}}
{{- end }}

{{/*
Generate Galera node name with pod name
*/}}
{{- define "mariadb.galeraNodeName" -}}
{{- printf "%s-%s" (include "mariadb.fullname" .) "REPLICA_NUM" -}}
{{- end }}

{{/*
Generate Galera node address
*/}}
{{- define "mariadb.galeraNodeAddress" -}}
{{- printf "%s-%s.%s.%s.svc.cluster.local" (include "mariadb.fullname" .) "REPLICA_NUM" (include "mariadb.fullname" .) .Release.Namespace -}}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mariadb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mariadb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
