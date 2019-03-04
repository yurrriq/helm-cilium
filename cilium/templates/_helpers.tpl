{{/* vim: set filetype=mustache: */}}
{{- /*
creates a standard metadata header.
It creates a 'metadata:' section with name and labels.
*/ -}}
{{ define "cilium.metadata" -}}
metadata:
  labels:
    app: {{ template "cilium.name" . }}
    chart: {{ .Chart.Name }}-{{ .Chart.Version }}
    heritage: {{ .Release.Service }}
    release: {{ .Release.Name }}
  name: {{ template "cilium.fullname" . }}
{{- end -}}
