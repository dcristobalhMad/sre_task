{{/*
Expand the name of the chart.
*/}}
{{- define "pokemon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pokemon.fullname" -}}
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
{{- define "pokemon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pokemon.labels" -}}
helm.sh/chart: {{ include "pokemon.chart" . }}
{{ include "pokemon.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pokemon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pokemon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pokemon.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pokemon.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "pokemon.pre-install" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: db-migration
spec:
  template:
    spec:
      containers:
        - name: mysql-client
          image: mysql:latest
          command: ["/bin/sh", "-c"]
          args:
            - |
              set -o pipefail
              MYSQL_HOST="${DB_HOST}"
              MYSQL_PORT="${MYSQL_PORT:-3306}"
              MYSQL_USER="${DB_USER}"
              MYSQL_PASSWORD="${DB_PASSWORD}"
              DATABASE_NAME="${DB_NAME}"

              mysql -h $MYSQL_HOST -P $MYSQL_PORT -u $MYSQL_USER -p$MYSQL_PASSWORD <<EOF
              CREATE DATABASE IF NOT EXISTS minipokedex;

              USE minipokedex;

              CREATE TABLE IF NOT EXISTS pokemon (
                                  \`id\` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                                  \`name\` VARCHAR(14) NOT NULL,
                                  \`type\` VARCHAR(14) NOT NULL,
                                  PRIMARY KEY (\`id\`)
              );

              USE minipokedex;

              INSERT INTO pokemon (\`name\`, \`type\`) VALUES
                                                    ('bulbasaur', 'planta'),
                                                    ('charmander', 'fuego'),
                                                    ('squirtle', 'agua');
              EOF
          envFrom:
            - secretRef:
                name: db-variables
      restartPolicy: Never
{{- end -}}