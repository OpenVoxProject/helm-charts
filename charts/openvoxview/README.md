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
| extraContainers | list | `[]` | Additional sidecar containers |
| extraEnv | object | `{}` | Additional environment variables as key-value pairs |
| extraEnvSecret | string | `""` | Name of an existing secret to use as additional environment variables |
| extraVolumes | list | `[]` | Additional volumes |
| fullnameOverride | string | `""` | Override the fully qualified app name |
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
| livenessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":10,"periodSeconds":30}` | Liveness probe configuration |
| nameOverride | string | `""` | Override the chart name |
| nodeSelector | object | `{}` | Node selector for pod assignment |
| podAnnotations | object | `{}` | Additional pod annotations |
| podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | Pod disruption budget configuration |
| podDisruptionBudget.enabled | bool | `false` | Enable PDB |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods |
| podLabels | object | `{}` | Additional pod labels |
| podSecurityContext | object | `{}` | Pod security context |
| port | int | `5000` | Container port for OpenVox View |
| priorityClassName | string | `""` | Priority class name |
| puppetdb | object | `{"caSecretName":"","tlsSecretName":"","url":"https://puppetdb:8081"}` | PuppetDB / OpenVox DB connection settings |
| puppetdb.caSecretName | string | `""` | Existing secret name containing the CA certificate (ca.pem) |
| puppetdb.tlsSecretName | string | `""` | Existing TLS secret name containing cert.pem and key.pem for client certificate authentication |
| puppetdb.url | string | `"https://puppetdb:8081"` | PuppetDB URL |
| readinessProbe | object | `{"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":5,"periodSeconds":10}` | Readiness probe configuration |
| replicaCount | int | `1` | Number of replicas |
| resources | object | `{}` | Container resource requests and limits |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"runAsNonRoot":true}` | Container security context |
| service | object | `{"annotations":{},"labels":{},"port":5000,"type":"ClusterIP"}` | Service configuration |
| service.annotations | object | `{}` | Service annotations |
| service.labels | object | `{}` | Service labels |
| service.port | int | `5000` | Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount | object | `{"annotations":{},"create":false,"name":""}` | Service account configuration |
| serviceAccount.annotations | object | `{}` | Service account annotations |
| serviceAccount.create | bool | `false` | Create a service account |
| serviceAccount.name | string | `""` | Service account name (generated if empty and create is true) |
| startupProbe | object | `{"failureThreshold":12,"httpGet":{"path":"/","port":"http"},"initialDelaySeconds":5,"periodSeconds":5}` | Startup probe configuration |
| terminationGracePeriodSeconds | int | `30` | Termination grace period in seconds |
| tolerations | list | `[]` | Tolerations for pod assignment |
| topologySpreadConstraints | list | `[]` | Topology spread constraints for pod assignment |
| updateStrategy | object | `{"type":"RollingUpdate"}` | Deployment update strategy |
