{{/* vim: set filetype=mustache: */}}
{{/*
Return the appropriate apiVersion for Apps APIs.
*/}}
{{- define "apps.apiVersion" -}}
{{- if semverCompare "<= 1.8-0" .Capabilities.KubeVersion.GitVersion -}}
apps/v1beta2
{{- else -}}
apps/v1
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for RBAC APIs.
*/}}
{{- define "rbac.apiVersion" -}}
{{- if semverCompare "<= 1.8-0" .Capabilities.KubeVersion.GitVersion -}}
rbac.authorization.k8s.io/v1beta1
{{- else -}}
rbac.authorization.k8s.io/v1
{{- end -}}
{{- end -}}
