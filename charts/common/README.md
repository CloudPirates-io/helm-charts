# Common Helm Chart

### Example config for OpenShift Clusters
The `_helpers.tpl` detects for `route.openshift.io/v1` to determine the target platform.
If the target platform is Openshift, following fields are beeing removed if you use `{{ include "common.renderContainerSecurityContext" . }}` or `{{ include "common.renderPodSecurityContext" . }}` in the Chart to render the SecurityContext.
```yaml
fsGroup:
runAsUser:
runAsGroup:
seLinuxOptions:
```

Example usage:
```yaml
apiVersion: apps/v1
kind: StatefulSet
spec:
  template:
    spec:
      securityContext: {{ include "common.renderPodSecurityContext" . | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext: {{ include "common.renderContainerSecurityContext" . | nindent 12 }}
```
