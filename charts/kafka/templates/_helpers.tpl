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

{{/*
Return true (as a non-empty string) when SASL is enabled on at least one listener.
*/}}
{{- define "kafka.auth.enabled" -}}
{{- if or .Values.auth.client.enabled .Values.auth.interBroker.enabled .Values.auth.controller.enabled -}}
true
{{- end -}}
{{- end -}}

{{/*
Name of the Secret holding the SASL passwords: the user-provided existingSecret, or the chart-managed one.
*/}}
{{- define "kafka.secretName" -}}
{{- .Values.auth.existingSecret | default (include "kafka.fullname" .) -}}
{{- end -}}

{{/*
Return true (as a non-empty string) when TLS is enabled.
*/}}
{{- define "kafka.tls.enabled" -}}
{{- if .Values.tls.enabled -}}
true
{{- end -}}
{{- end -}}

{{/*
Name of the Secret holding the TLS PEM material.
- existing-secret: the user-provided Secret
- self-signed / cert-manager: a chart-managed "<fullname>-tls" Secret
*/}}
{{- define "kafka.tlsSecretName" -}}
{{- if eq .Values.tls.source "existing-secret" -}}
{{- required "tls.existingSecret is required when tls.source=existing-secret" .Values.tls.existingSecret -}}
{{- else -}}
{{- printf "%s-tls" (include "kafka.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Resolve a listener's security protocol from the auth + tls flags.
Usage: include "kafka.listenerProtocol" (dict "auth" <bool> "tls" <truthy>)
*/}}
{{- define "kafka.listenerProtocol" -}}
{{- if and .tls .auth -}}SASL_SSL
{{- else if .tls -}}SSL
{{- else if .auth -}}SASL_PLAINTEXT
{{- else -}}PLAINTEXT
{{- end -}}
{{- end -}}

{{/*
Subject Alternative Names for the generated/self-signed server certificate.
Covers the per-pod headless FQDNs (wildcard), the client Service FQDN, and short forms.
*/}}
{{- define "kafka.tls.altNames" -}}
{{- $name := include "kafka.fullname" . -}}
{{- $namespace := include "cloudpirates.namespace" . -}}
{{- $domain := .Values.clusterDomain | default "cluster.local" -}}
{{- $names := list -}}
{{- $names = append $names (printf "*.%s-headless.%s.svc.%s" $name $namespace $domain) -}}
{{- $names = append $names (printf "%s-headless.%s.svc.%s" $name $namespace $domain) -}}
{{- $names = append $names (printf "%s.%s.svc.%s" $name $namespace $domain) -}}
{{- $names = append $names (printf "%s.%s.svc" $name $namespace) -}}
{{- $names = append $names $name -}}
{{- $names = append $names "localhost" -}}
{{- $names | toYaml -}}
{{- end -}}
