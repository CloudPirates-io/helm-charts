{{/*
Expand the name of the chart.
*/}}
{{- define "common.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.fullname" -}}
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
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
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
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "common.annotations" -}}
{{- with .Values.commonAnnotations }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Return the proper image name with registry and tag (tag includes digest if present)
*/}}
{{- define "common.image" -}}
{{- $registryName := .image.registry -}}
{{- $repositoryName := .image.repository -}}
{{- $tag := .image.tag | toString -}}
{{- if .global }}
    {{- if .global.imageRegistry }}
        {{- $registryName = .global.imageRegistry -}}
    {{- end -}}
{{- end -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end }}

{{/*
Return the proper image pull policy
*/}}
{{- define "common.imagePullPolicy" -}}
{{- .image.imagePullPolicy | default .image.pullPolicy | default "Always" -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "common.imagePullSecrets" -}}
{{- $pullSecrets := list }}

{{- if .global }}
    {{- range .global.imagePullSecrets -}}
        {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
{{- end -}}

{{- if and .image .image.pullSecrets }}
    {{- range .image.pullSecrets -}}
        {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
{{- end -}}

{{- if .Values.imagePullSecrets }}
    {{- range .Values.imagePullSecrets -}}
        {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
{{- end -}}

{{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
{{- range $pullSecrets }}
{{- if kindIs "map" . }}
  - name: {{ .name }}
{{- else }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Validate required fields
*/}}
{{- define "common.validateRequired" -}}
{{- $context := index . 0 -}}
{{- $field := index . 1 -}}
{{- $message := index . 2 -}}
{{- if not $field -}}
{{- fail $message -}}
{{- end -}}
{{- end -}}

{{/*
Return a soft nodeAffinity definition
*/}}
{{- define "common.affinities.nodes.soft" -}}
{{- $key := index . 0 -}}
{{- $values := index . 1 -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - preference:
      matchExpressions:
        - key: {{ $key }}
          operator: In
          values:
            {{- range $values }}
            - {{ . | quote }}
            {{- end }}
    weight: 1
{{- end -}}

{{/*
Return a hard nodeAffinity definition
*/}}
{{- define "common.affinities.nodes.hard" -}}
{{- $key := index . 0 -}}
{{- $values := index . 1 -}}
requiredDuringSchedulingIgnoredDuringExecution:
  nodeSelectorTerms:
    - matchExpressions:
        - key: {{ $key }}
          operator: In
          values:
            {{- range $values }}
            - {{ . | quote }}
            {{- end }}
{{- end -}}

{{/*
Return a soft podAffinity/podAntiAffinity definition
*/}}
{{- define "common.affinities.pods.soft" -}}
{{- $component := index . 0 -}}
{{- $context := index . 1 -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      labelSelector:
        matchLabels: {{- (include "common.selectorLabels" $context) | nindent 10 }}
          {{- if $component }}
          app.kubernetes.io/component: {{ $component }}
          {{- end }}
      topologyKey: kubernetes.io/hostname
    weight: 1
{{- end -}}

{{/*
Return a hard podAffinity/podAntiAffinity definition
*/}}
{{- define "common.affinities.pods.hard" -}}
{{- $component := index . 0 -}}
{{- $context := index . 1 -}}
requiredDuringSchedulingIgnoredDuringExecution:
  - labelSelector:
      matchLabels: {{- (include "common.selectorLabels" $context) | nindent 8 }}
        {{- if $component }}
        app.kubernetes.io/component: {{ $component }}
        {{- end }}
    topologyKey: kubernetes.io/hostname
{{- end -}}

{{/*
Render a value that contains template perhaps
*/}}
{{- define "common.tplvalues.render" -}}
  {{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
  {{- if contains "{{" (toString $value) }}
    {{- tpl $value .context }}
  {{- else }}
    {{- $value }}
  {{- end }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names evaluating values as templates
{{ include "common.images.renderPullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "context" $) }}
*/}}
{{- define "common.images.renderPullSecrets" -}}
  {{- $pullSecrets := list }}
  {{- $context := .context }}

  {{- range (($context.Values.global).imagePullSecrets) -}}
    {{- if kindIs "map" . -}}
      {{- $pullSecrets = append $pullSecrets (include "common.tplvalues.render" (dict "value" .name "context" $context)) -}}
    {{- else -}}
      {{- $pullSecrets = append $pullSecrets (include "common.tplvalues.render" (dict "value" . "context" $context)) -}}
    {{- end -}}
  {{- end -}}

  {{- range .images -}}
    {{- range .pullSecrets -}}
      {{- if kindIs "map" . -}}
        {{- $pullSecrets = append $pullSecrets (include "common.tplvalues.render" (dict "value" .name "context" $context)) -}}
      {{- else -}}
        {{- $pullSecrets = append $pullSecrets (include "common.tplvalues.render" (dict "value" . "context" $context)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if (not (empty $pullSecrets)) -}}
imagePullSecrets:
    {{- range $pullSecrets | uniq }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Detect if the target platform is OpenShift (via .Values.targetPlatform or API group).
Usage: {{ include "common.isOpenshift" . }}
*/}}
{{- define "common.isOpenshift" -}}
{{- if or (eq (lower (default "" .Values.targetPlatform)) "openshift") (.Capabilities.APIVersions.Has "route.openshift.io") -}}
true
{{- else -}}
false
{{- end -}}
{{- end }}

{{/*
Render podSecurityContext, omitting runAsUser, runAsGroup, fsGroup, and seLinuxOptions if OpenShift is detected.
Usage: {{ include "common.renderPodSecurityContext" . }}
*/}}
{{- define "common.renderPodSecurityContext" -}}
{{- $isOpenshift := include "common.isOpenshift" . | trim }}
{{- if eq $isOpenshift "true" }}
{{- omit .Values.podSecurityContext "runAsUser" "runAsGroup" "fsGroup" "seLinuxOptions" | toYaml | nindent 8 }}
{{- else }}
{{- toYaml .Values.podSecurityContext | nindent 8 }}
{{- end }}
{{- end }}

{{/*
Render containerSecurityContext, omitting runAsUser, runAsGroup, and seLinuxOptions if OpenShift is detected.
Usage: {{ include "common.renderContainerSecurityContext" . }}
*/}}
{{- define "common.renderContainerSecurityContext" -}}
{{- $isOpenshift := include "common.isOpenshift" . | trim }}
{{- if eq $isOpenshift "true" }}
{{- omit .Values.containerSecurityContext "runAsUser" "runAsGroup" "seLinuxOptions" | toYaml | nindent 12 }}
{{- else }}
{{- toYaml .Values.containerSecurityContext | nindent 12 }}
{{- end }}
{{- end }}
