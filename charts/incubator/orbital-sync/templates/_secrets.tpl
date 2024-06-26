{{/* Define the secrets */}}
{{- define "orbital.secrets" -}}
{{- $secretName := (printf "%s-orbital-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) }}
{{- $orbitalprevious := lookup "v1" "Secret" .Release.Namespace $secretName }}
enabled: true
data:
  PRIMARY_HOST_BASE_URL: {{ .Values.orbital.primary_host_base_url | b64enc }}
  PRIMARY_HOST_PASSWORD: {{ .Values.orbital.primary_host_password | b64enc }}
  {{- with .Values.orbital.honeybadger_api_key }}
  HONEYBADGER_API_KEY: {{ . | b64enc }}
  {{- end }}

{{ $idx := 1 }}
{{- range .Values.orbital.secondary_hosts }}
  SECONDARY_HOST_{{$idx}}_BASE_URL: {{ .host | b64enc }}
  SECONDARY_HOST_{{$idx}}_PASSWORD: {{ .password | b64enc }}
  {{ $idx = add1 $idx }}
{{- end }}
{{- end -}}
