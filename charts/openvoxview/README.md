# openvoxview

OpenVox View - Web UI for PuppetDB / OpenVox DB

## Usage

```bash
helm install openvoxview oci://ghcr.io/openvoxproject/charts/openvoxview \
  --version 0.1.0 \
  --set puppetdb.url=https://puppetdb:8081 \
  --set puppetdb.tlsSecretName=my-puppetdb-tls \
  --set puppetdb.caSecretName=my-puppetdb-ca
```

## TLS Configuration

OpenVox View needs client certificates to communicate with PuppetDB / OpenVox DB.
Provide them via existing Kubernetes secrets:

- `puppetdb.tlsSecretName` - Secret containing `cert.pem` and `key.pem`
- `puppetdb.caSecretName` - Secret containing `ca.pem`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for pod assignment |
| extraEnv | object | `{}` | Additional environment variables as key-value pairs |
| extraEnvSecret | string | `""` | Name of an existing secret to use as additional environment variables |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"ghcr.io/voxpupuli/openvoxview","tag":"v1.4.0"}` | Container image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"ghcr.io/voxpupuli/openvoxview"` | Image repository |
| image.tag | string | `"v1.4.0"` | Image tag |
| imagePullSecrets | list | `[]` | Image pull secrets for private registries |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[],"tls":[]}` | Ingress configuration |
| ingress.annotations | object | `{}` | Ingress annotations |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.hosts | list | `[]` | Ingress hosts |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| podAnnotations | object | `{}` | Additional pod annotations |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod security context |
| port | int | `5000` | Container port for OpenVox View |
| puppetdb | object | `{"caSecretName":"","tlsSecretName":"","url":"https://puppetdb:8081"}` | PuppetDB / OpenVox DB connection settings |
| puppetdb.caSecretName | string | `""` | Existing secret name containing the CA certificate (ca.pem) |
| puppetdb.tlsSecretName | string | `""` | Existing TLS secret name containing cert.pem and key.pem for client certificate authentication |
| puppetdb.url | string | `"https://puppetdb:8081"` | PuppetDB URL |
| replicaCount | int | `1` | Number of replicas |
| resources | object | `{}` | Container resource requests and limits |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"runAsNonRoot":true}` | Container security context |
| service | object | `{"annotations":{},"labels":{},"port":5000,"type":"ClusterIP"}` | Service configuration |
| service.annotations | object | `{}` | Service annotations |
| service.labels | object | `{}` | Service labels |
| service.port | int | `5000` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| tolerations | list | `[]` | Tolerations for pod assignment |
