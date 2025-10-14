{{/*
Expand the name of the chart.
*/}}
{{- define "zookeeper.name" -}}
{{- include "cloudpirates.name" . -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "zookeeper.fullname" -}}
{{- include "cloudpirates.fullname" . -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zookeeper.chart" -}}
{{- include "cloudpirates.chart" . -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zookeeper.labels" -}}
{{- include "cloudpirates.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zookeeper.selectorLabels" -}}
{{- include "cloudpirates.selectorLabels" . -}}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "zookeeper.annotations" -}}
{{- include "cloudpirates.annotations" . -}}
{{- end }}

{{/*
Return the proper ZooKeeper image name
*/}}
{{- define "zookeeper.image" -}}
{{- include "cloudpirates.image" (dict "image" .Values.image "global" .Values.global) -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "zookeeper.imagePullSecrets" -}}
{{ include "cloudpirates.images.renderPullSecrets" (dict "images" (list .Values.image) "context" .) }}
{{- end -}}

{{/*
Create a server list array based on fullname, namespace, # of servers
in a format like:
- server.1=zkhost1:port:port
- server.2=zkhost2:port:port
*/}}
{{- define "zookeeper.servers" -}}
{{- $namespace := .Release.Namespace }}
{{- $name := include "zookeeper.fullname" . -}}
{{- $peersPort := .Values.service.ports.quorum -}}
{{- $leaderElectionPort := .Values.service.ports.leaderElection -}}
{{- range $idx, $v := until (int .Values.replicaCount) }}
server.{{ $idx }}={{ printf "%s-%d.%s-headless.%s.svc.cluster.local:%d:%d" $name $idx $name $namespace (int $peersPort) (int $leaderElectionPort) }}
{{- end }}
{{- end -}}
