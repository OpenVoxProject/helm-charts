{{/*
Expand the name of the chart.
*/}}
{{- define "openvoxdb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL writable service name, using the subchart's naming rules.
*/}}
{{- define "openvoxdb.postgresqlFullname" -}}
{{- include "postgresql.primaryServiceName" .Subcharts.postgresql -}}
{{- end }}

{{/*
PostgreSQL hostname used by OpenVoxDB.
*/}}
{{- define "openvoxdb.postgresqlHostname" -}}
{{- if hasKey .Values.postgresql "internal" -}}
{{- fail "postgresql.internal was removed in chart 0.2.0; migrate to HelmForge postgresql.enabled/auth/standalone values as documented in README.md" -}}
{{- end -}}
{{- if .Values.postgresql.enabled -}}
{{- include "openvoxdb.postgresqlFullname" . -}}
{{- else -}}
{{- required "postgresql.external.hostname is required when postgresql.enabled is false" .Values.postgresql.external.hostname -}}
{{- end -}}
{{- end }}

{{/*
PostgreSQL credential Secret name.
*/}}
{{- define "openvoxdb.postgresqlSecretName" -}}
{{- if .Values.postgresql.enabled -}}
{{- include "postgresql.secretName" .Subcharts.postgresql -}}
{{- else -}}
{{- required "postgresql.shared.existingSecret is required when postgresql.enabled is false" .Values.postgresql.shared.existingSecret -}}
{{- end -}}
{{- end }}

{{/*
PostgreSQL connection settings for bundled and external deployments.
*/}}
{{- define "openvoxdb.postgresqlPort" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Subcharts.postgresql.Values.service.port -}}
{{- else -}}
{{- .Values.postgresql.shared.port -}}
{{- end -}}
{{- end }}

{{- define "openvoxdb.postgresqlDatabase" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.auth.database -}}
{{- else -}}
{{- .Values.postgresql.shared.database -}}
{{- end -}}
{{- end }}

{{- define "openvoxdb.postgresqlPasswordKey" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Subcharts.postgresql.Values.auth.existingSecretUserPasswordKey -}}
{{- else -}}
{{- .Values.postgresql.shared.passwordKey -}}
{{- end -}}
{{- end }}

{{/*
Managed read-only account for bundled PostgreSQL.
*/}}
{{- define "openvoxdb.readDatabaseEnabled" -}}
{{- if and .Values.postgresql.enabled .Values.readDatabase.enabled -}}
{{- if or (not .Values.readDatabase.username) (eq .Values.readDatabase.username .Values.postgresql.auth.username) (eq .Values.readDatabase.username "postgres") -}}
{{- fail "readDatabase.username must be a separate nonempty account from postgres and postgresql.auth.username" -}}
{{- end -}}
{{- if hasKey .Values.customConfig "read-database.conf" -}}
{{- fail "customConfig.read-database.conf conflicts with managed readDatabase configuration; disable readDatabase.enabled to supply your own" -}}
{{- end -}}
true
{{- end -}}
{{- end }}

{{- define "openvoxdb.readDatabaseSecretName" -}}
{{- default (printf "%s-read-database" (include "openvoxdb.fullname" . | trunc 49 | trimSuffix "-")) .Values.readDatabase.existingSecret -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "openvoxdb.fullname" -}}
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
Common labels
*/}}
{{- define "openvoxdb.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "openvoxdb.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openvoxdb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openvoxdb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "openvoxdb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openvoxdb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
