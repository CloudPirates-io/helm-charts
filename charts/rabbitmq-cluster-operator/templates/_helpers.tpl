{{/*
Return the proper RabbitMQ Cluster Operator fullname
Note: We use the regular common function as the chart name already contains the
the rabbitmq-cluster-operator name.
*/}}
{{- define "rmqco.clusterOperator.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end -}}

{{/*
Common labels for rmq-cluster-operator
*/}}
{{- define "rmqco.labels" -}}
  {{- $versionLabel := dict "app.kubernetes.io/version" (default "latest" .Values.clusterOperator.image.tag) -}}
  {{- $staticLabels := dict
        "app.kubernetes.io/component" "rabbitmq-operator"
        "app.kubernetes.io/part-of" "rabbitmq"
    -}}

  {{- include "cloudpirates.tplvalues.merge" (dict
        "values" (list
            (include "cloudpirates.labels" . | fromYaml)
            $versionLabel
            $staticLabels
        )
        "context" .
    )
  }}
{{- end }}

{{/*
Common labels for rmq-messaging-topology-operator
*/}}
{{- define "rmqmto.labels" -}}
  {{- $versionLabel := dict "app.kubernetes.io/version" (default "latest" .Values.msgTopologyOperator.image.tag) -}}
  {{- $staticLabels := dict
        "app.kubernetes.io/component" "messaging-topology-operator"
        "app.kubernetes.io/part-of" "rabbitmq"
    -}}

  {{- include "cloudpirates.tplvalues.merge" (dict
        "values" (list
            (include "cloudpirates.labels" . | fromYaml)
            $versionLabel
            $staticLabels
        )
        "context" .
    )
  }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rmqco.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}


{{/*
Return the proper RabbitMQ Messaging Topology Operator fullname
NOTE: Not using the common function to avoid generating too long names
*/}}
{{- define "rmqco.msgTopologyOperator.fullname" -}}
{{- if .Values.msgTopologyOperator.fullnameOverride -}}
    {{- printf "%s" .Values.msgTopologyOperator.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else if .Values.fullnameOverride -}}
    {{- printf "%s-%s" .Values.fullnameOverride "messaging-topology-operator" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "rabbitmq-messaging-topology-operator" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper RabbitMQ Messaging Topology Operator fullname adding the installation's namespace.
*/}}
{{- define "rmqco.msgTopologyOperator.fullname.namespace" -}}
{{- printf "%s-%s" (include "rmqco.msgTopologyOperator.fullname" .) (include "cloudpirates.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper RabbitMQ Messaging Topology Operator fullname
NOTE: Not using the common function to avoid generating too long names
*/}}
{{- define "rmqco.msgTopologyOperator.webhook.fullname" -}}
{{- if .Values.msgTopologyOperator.fullnameOverride -}}
    {{- printf "%s-%s" .Values.msgTopologyOperator.fullnameOverride "webhook" | trunc 63 | trimSuffix "-" -}}
{{- else if .Values.fullnameOverride -}}
    {{- printf "%s-%s" .Values.fullnameOverride "messaging-topology-operator-webhook" | trunc 63 | trimSuffix "-" -}}
{{- else -}}
    {{- printf "%s-%s" .Release.Name "rabbitmq-messaging-topology-operator-webhook" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper RabbitMQ Messaging Topology Operator fullname adding the installation's namespace.
*/}}
{{- define "rmqco.msgTopologyOperator.webhook.fullname.namespace" -}}
{{- printf "%s-%s" (include "rmqco.msgTopologyOperator.webhook.fullname" .) (include "cloudpirates.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the proper RabbitMQ Messaging Topology Operator fullname
*/}}
{{- define "rmqco.msgTopologyOperator.webhook.secretName" -}}
{{- if .Values.msgTopologyOperator.existingWebhookCertSecret -}}
    {{- .Values.msgTopologyOperator.existingWebhookCertSecret -}}
{{- else }}
    {{- include "rmqco.msgTopologyOperator.webhook.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper RabbitMQ Default User Credential updater image name
*/}}
{{- define "rmqco.defaultCredentialUpdater.image" -}}
{{ include "cloudpirates.image" (dict "image" .Values.credentialUpdaterImage "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper RabbitMQ Cluster Operator image name
*/}}
{{- define "rmqco.clusterOperator.image" -}}
{{ include "cloudpirates.image" (dict "image" .Values.clusterOperator.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper RabbitMQ Cluster Operator image name
*/}}
{{- define "rmqco.msgTopologyOperator.image" -}}
{{ include "cloudpirates.image" (dict "image" .Values.msgTopologyOperator.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper RabbitMQ image name
*/}}
{{- define "rmqco.rabbitmq.image" -}}
{{- include "cloudpirates.image" ( dict "image" .Values.rabbitmqImage "global" .Values.global ) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "rmqco.imagePullSecrets" -}}
{{- include "cloudpirates.imagePullSecrets" . -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names as a comma separated string
*/}}
{{- define "rmqco.imagePullSecrets.string" -}}
{{- $pullSecrets := list }}
{{- if .Values.global }}
  {{- range .Values.global.imagePullSecrets -}}
    {{- $pullSecrets = append $pullSecrets . -}}
  {{- end -}}
{{- end -}}
{{- range (list .Values.clusterOperator.image .Values.rabbitmqImage) -}}
  {{- range .pullSecrets -}}
    {{- $pullSecrets = append $pullSecrets . -}}
  {{- end -}}
{{- end -}}
{{- if (not (empty $pullSecrets)) }}
  {{- printf "%s" (join "," $pullSecrets) -}}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use (Cluster Operator)
*/}}
{{- define "rmqco.clusterOperator.serviceAccountName" -}}
{{- if .Values.clusterOperator.serviceAccount.create -}}
    {{ default (printf "%s" (include "rmqco.clusterOperator.fullname" .)) .Values.clusterOperator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.clusterOperator.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use (Messaging Topology Operator)
*/}}
{{- define "rmqco.msgTopologyOperator.serviceAccountName" -}}
{{- if .Values.msgTopologyOperator.serviceAccount.create -}}
    {{ default (printf "%s" (include "rmqco.msgTopologyOperator.fullname" .)) .Values.msgTopologyOperator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.msgTopologyOperator.serviceAccount.name }}
{{- end -}}
{{- end -}}
