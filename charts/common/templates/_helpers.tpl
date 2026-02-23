{{/*
Expand the name of the chart.
*/}}
{{- define "cloudpirates.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudpirates.fullname" -}}
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
Return the namespace to use for resources.
Defaults to .Release.Namespace but can be overridden via .Values.namespaceOverride.
Useful for multi-namespace deployments in combined charts.
*/}}
{{- define "cloudpirates.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a fully qualified app name adding the installation's namespace.
*/}}
{{- define "cloudpirates.fullname.namespace" -}}
{{- printf "%s-%s" (include "cloudpirates.fullname" .) (include "cloudpirates.namespace" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloudpirates.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
Uses merge to avoid duplicate keys when commonLabels overrides standard labels.
commonLabels takes highest precedence.
*/}}
{{- define "cloudpirates.labels" -}}
{{- $default := dict
    "helm.sh/chart" (include "cloudpirates.chart" .)
    "app.kubernetes.io/managed-by" .Release.Service -}}
{{- with .Chart.AppVersion -}}
  {{- $_ := set $default "app.kubernetes.io/version" . -}}
{{- end -}}
{{- $selectorLabels := include "cloudpirates.selectorLabels" . | fromYaml -}}
{{- $commonLabels := .Values.commonLabels | default dict -}}
{{- merge $commonLabels $selectorLabels $default | toYaml }}
{{- end }}

{{/*
Selector labels
Picks app.kubernetes.io/name and app.kubernetes.io/instance from commonLabels
so name overrides flow into selectors.
Arbitrary commonLabels are NOT added to selectors — only name and instance.
*/}}
{{- define "cloudpirates.selectorLabels" -}}
{{- $default := dict "app.kubernetes.io/name" (include "cloudpirates.name" .) "app.kubernetes.io/instance" .Release.Name -}}
{{- $override := dict -}}
{{- with .Values.commonLabels -}}
  {{- $override = pick . "app.kubernetes.io/name" "app.kubernetes.io/instance" -}}
{{- end -}}
{{- merge $override $default | toYaml }}
{{- end }}

{{/*
Common annotations
*/}}
{{- define "cloudpirates.annotations" -}}
{{- with .Values.commonAnnotations }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Return the proper image name with registry and tag (tag includes digest if present)
*/}}
{{- define "cloudpirates.image" -}}
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
{{- define "cloudpirates.imagePullPolicy" -}}
{{- .image.imagePullPolicy | default .image.pullPolicy | default "Always" -}}
{{- end }}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "cloudpirates.imagePullSecrets" -}}
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
{{- define "cloudpirates.validateRequired" -}}
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
{{- define "cloudpirates.affinities.nodes.soft" -}}
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
{{- define "cloudpirates.affinities.nodes.hard" -}}
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
{{- define "cloudpirates.affinities.pods.soft" -}}
{{- $component := index . 0 -}}
{{- $context := index . 1 -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
      labelSelector:
        matchLabels: {{- (include "cloudpirates.selectorLabels" $context) | nindent 10 }}
          {{- if $component }}
          app.kubernetes.io/component: {{ $component }}
          {{- end }}
      topologyKey: kubernetes.io/hostname
    weight: 1
{{- end -}}

{{/*
Return a hard podAffinity/podAntiAffinity definition
*/}}
{{- define "cloudpirates.affinities.pods.hard" -}}
{{- $component := index . 0 -}}
{{- $context := index . 1 -}}
requiredDuringSchedulingIgnoredDuringExecution:
  - labelSelector:
      matchLabels: {{- (include "cloudpirates.selectorLabels" $context) | nindent 8 }}
        {{- if $component }}
        app.kubernetes.io/component: {{ $component }}
        {{- end }}
    topologyKey: kubernetes.io/hostname
{{- end -}}

{{/*
Render a value that contains template perhaps
*/}}
{{- define "cloudpirates.tplvalues.render" -}}
  {{- $value := typeIs "string" .value | ternary .value (.value | toYaml) }}
  {{- if contains "{{" (toString $value) }}
    {{- tpl $value .context }}
  {{- else }}
    {{- $value }}
  {{- end }}
{{- end -}}

{{/*
Merge a list of values that contains template after rendering them.
Merge precedence is consistent with http://masterminds.github.io/sprig/dicts.html#merge-mustmerge
Usage:
{{ include "cloudpirates.tplvalues.merge" ( dict "values" (list .Values.path.to.the.Value1 .Values.path.to.the.Value2) "context" $ ) }}
*/}}
{{- define "cloudpirates.tplvalues.merge" -}}
{{- $dst := dict -}}
{{- range .values -}}
{{- $dst = include "cloudpirates.tplvalues.render" (dict "value" . "context" $.context "scope" $.scope) | fromYaml | merge $dst -}}
{{- end -}}
{{ $dst | toYaml }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names evaluating values as templates
{{ include "cloudpirates.images.renderPullSecrets" ( dict "images" (list .Values.path.to.the.image1, .Values.path.to.the.image2) "context" $) }}
*/}}
{{- define "cloudpirates.images.renderPullSecrets" -}}
  {{- $pullSecrets := list }}
  {{- $context := .context }}

  {{- range (($context.Values.global).imagePullSecrets) -}}
    {{- if kindIs "map" . -}}
      {{- $pullSecrets = append $pullSecrets (include "cloudpirates.tplvalues.render" (dict "value" .name "context" $context)) -}}
    {{- else -}}
      {{- $pullSecrets = append $pullSecrets (include "cloudpirates.tplvalues.render" (dict "value" . "context" $context)) -}}
    {{- end -}}
  {{- end -}}

  {{- range .images -}}
    {{- range .pullSecrets -}}
      {{- if kindIs "map" . -}}
        {{- $pullSecrets = append $pullSecrets (include "cloudpirates.tplvalues.render" (dict "value" .name "context" $context)) -}}
      {{- else -}}
        {{- $pullSecrets = append $pullSecrets (include "cloudpirates.tplvalues.render" (dict "value" . "context" $context)) -}}
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
Usage: {{ include "cloudpirates.isOpenshift" . }}
*/}}
{{- define "cloudpirates.isOpenshift" -}}
{{- if or (eq (lower (default "" .Values.targetPlatform)) "openshift") (.Capabilities.APIVersions.Has "route.openshift.io/v1") -}}
true
{{- else -}}
false
{{- end -}}
{{- end }}

{{/*
Render podSecurityContext, omitting runAsUser, runAsGroup, fsGroup, and seLinuxOptions if OpenShift is detected.
Usage: {{ include "cloudpirates.renderPodSecurityContext" . }}
*/}}
{{- define "cloudpirates.renderPodSecurityContext" -}}
{{- $isOpenshift := include "cloudpirates.isOpenshift" . | trim }}
{{- if eq $isOpenshift "true" }}
{{- omit .Values.podSecurityContext "runAsUser" "runAsGroup" "fsGroup" "seLinuxOptions" | toYaml }}
{{- else }}
{{- toYaml .Values.podSecurityContext }}
{{- end }}
{{- end }}

{{/*
Render containerSecurityContext, omitting runAsUser, runAsGroup, and seLinuxOptions if OpenShift is detected.
Usage: {{ include "cloudpirates.renderContainerSecurityContext" . }}
*/}}
{{- define "cloudpirates.renderContainerSecurityContext" -}}
{{- $isOpenshift := include "cloudpirates.isOpenshift" . | trim }}
{{- if eq $isOpenshift "true" }}
{{- omit .Values.containerSecurityContext "runAsUser" "runAsGroup" "seLinuxOptions" | toYaml }}
{{- else }}
{{- toYaml .Values.containerSecurityContext }}
{{- end }}
{{- end }}
