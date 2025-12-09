{{/*
Reuses the value from an existing secret, otherwise sets its value to a default value.

Usage:
{{ include "cloudpirates.secrets.lookup" (dict "secret" "secret-name" "key" "keyName" "defaultValue" .Values.myValue "context" $) }}

Params:
  - secret - String - Required - Name of the 'Secret' resource where the password is stored.
  - key - String - Required - Name of the key in the secret.
  - defaultValue - String - Required - The path to the validating value in the values.yaml, e.g: "mysql.password". Will pick first parameter with a defined value.
  - context - Context - Required - Parent context.

*/}}
{{- define "cloudpirates.secrets.lookup" -}}
{{- $value := "" -}}
{{- $secretData := (lookup "v1" "Secret" (include "cloudpirates.namespace" .context) .secret).data -}}
{{- if and $secretData (hasKey $secretData .key) -}}
  {{- $value = index $secretData .key -}}
{{- else if .defaultValue -}}
  {{- $value = .defaultValue | toString | b64enc -}}
{{- end -}}
{{- if $value -}}
{{- printf "%s" $value -}}
{{- end -}}
{{- end -}}
