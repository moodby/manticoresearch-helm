{{/*
Expand the name of the chart.
*/}}
{{- define "manticoresearch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "manticoresearch.fullname" -}}
{{- if .Values.fullNameOverride }}
{{- .Values.fullNameOverride | trunc 63 | trimSuffix "-" }}
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
{{- define "manticoresearch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "manticoresearch.labels" -}}
helm.sh/chart: {{ include "manticoresearch.chart" . }}
{{ include "manticoresearch.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "manticoresearch.componentLabels" -}}
app.kubernetes.io/component: {{ first . }}
{{ include "manticoresearch.labels" (index . 1) }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "manticoresearch.selectorLabels" -}}
app.kubernetes.io/name: {{ include "manticoresearch.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "manticoresearch.componentSelectorLabels" -}}
app.kubernetes.io/component: {{ first . }}
{{ include "manticoresearch.selectorLabels" (index . 1) }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "manticoresearch.serviceAccountName" -}}
{{- default (include "manticoresearch.fullname" .) .Values.serviceAccount.name }}
{{- end }}
