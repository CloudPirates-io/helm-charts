{{/*
Expand the name of the chart.
*/}}
{{- define "kafka.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "kafka.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafka.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "kafka.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Return the proper Kafka image name
*/}}
{{- define "kafka.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper kafka-exporter (metrics) image name
*/}}
{{- define "kafka.metrics.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.metrics.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "kafka.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image .Values.metrics.image) "context" .) }}
{{- end -}}

{{/*
Metrics (kafka-exporter) labels. Reuses the common labels but overrides the name to
"<name>-metrics" and adds the metrics component, so the exporter pods are NOT selected
by the broker (client/headless) Services, which select on the plain "<name>".
*/}}
{{- define "kafka.metrics.labels" -}}
{{- $base := include "kafka.labels" . | fromYaml -}}
{{- $_ := set $base "app.kubernetes.io/name" (printf "%s-metrics" (include "kafka.name" .)) -}}
{{- $_ := set $base "app.kubernetes.io/component" "metrics" -}}
{{- $base | toYaml -}}
{{- end -}}

{{/*
Metrics (kafka-exporter) selector labels.
*/}}
{{- define "kafka.metrics.selectorLabels" -}}
{{- $base := include "kafka.selectorLabels" . | fromYaml -}}
{{- $_ := set $base "app.kubernetes.io/name" (printf "%s-metrics" (include "kafka.name" .)) -}}
{{- $base | toYaml -}}
{{- end -}}

{{/*
Build the static KRaft controller quorum voters string in the form:
  0@<fullname>-0.<fullname>-headless.<namespace>.svc.cluster.local:<controllerPort>,1@...
nodeIdOffset (default 0) shifts the node IDs to match nodeIdOffset used at runtime.
*/}}
{{- define "kafka.quorumVoters" -}}
{{- $name := include "kafka.fullname" . -}}
{{- $namespace := include "cloudpirates.namespace" . -}}
{{- $domain := .Values.clusterDomain | default "cluster.local" -}}
{{- $port := int .Values.service.ports.controller -}}
{{- $offset := int (default 0 .Values.nodeIdOffset) -}}
{{- $voters := list -}}
{{- range $idx := until (int .Values.replicaCount) -}}
{{- $voters = append $voters (printf "%d@%s-%d.%s-headless.%s.svc.%s:%d" (add $idx $offset) $name $idx $name $namespace $domain $port) -}}
{{- end -}}
{{- join "," $voters -}}
{{- end -}}

{{/*
Resolve the effective StorageClass: persistence.storageClass, then global.defaultStorageClass.
Returns an empty string when none is set (cluster default).
*/}}
{{- define "kafka.storageClass" -}}
{{- .Values.persistence.storageClass | default (.Values.global).defaultStorageClass -}}
{{- end -}}
