# Chart Standards

Standards and conventions for all Helm charts in this repository.

## General

- All charts use `apiVersion: v2`
- All charts include a `.helmignore` file
- All charts include helm-unittest tests in `tests/`
- All charts include a `README.md.gotmpl` for helm-docs generation
- Values follow a flat, consistent naming convention across charts

## Required for all charts

Every chart must support the following values:

| Value | Type | Description |
|-------|------|-------------|
| `image.repository` | string | Container image repository |
| `image.tag` | string | Container image tag |
| `image.pullPolicy` | string | Image pull policy |
| `imagePullSecrets` | list | Image pull secrets for private registries |
| `nameOverride` | string | Override the chart name |
| `fullnameOverride` | string | Override the fully qualified app name |
| `podAnnotations` | object | Additional pod annotations |
| `podLabels` | object | Additional pod labels |
| `extraEnv` | object | Additional environment variables as key-value pairs |
| `extraEnvSecret` | string | Existing secret to use as environment variables |

## Required for workload charts

Charts that create Pods (Deployment, StatefulSet, DaemonSet) must additionally support:

### Scheduling

| Value | Type | Description |
|-------|------|-------------|
| `nodeSelector` | object | Node selector for pod assignment |
| `tolerations` | list | Tolerations for pod assignment |
| `affinity` | object | Affinity and anti-affinity rules |
| `topologySpreadConstraints` | list | Topology spread constraints |
| `priorityClassName` | string | Priority class name |

### Security

| Value | Type | Description |
|-------|------|-------------|
| `securityContext` | object | Container security context |
| `podSecurityContext` | object | Pod security context |

### Resources and scaling

| Value | Type | Description |
|-------|------|-------------|
| `replicaCount` | int | Number of replicas |
| `resources` | object | Container resource requests and limits |
| `updateStrategy` | object | Deployment/StatefulSet update strategy |
| `terminationGracePeriodSeconds` | int | Termination grace period |

### Availability

| Value | Type | Description |
|-------|------|-------------|
| `podDisruptionBudget.enabled` | bool | Enable PDB |
| `podDisruptionBudget.minAvailable` | int/string | Minimum available pods |
| `podDisruptionBudget.maxUnavailable` | int/string | Maximum unavailable pods |

### Service account

| Value | Type | Description |
|-------|------|-------------|
| `serviceAccount.create` | bool | Create a service account |
| `serviceAccount.name` | string | Service account name (generated if empty) |
| `serviceAccount.annotations` | object | Service account annotations |

### Networking

| Value | Type | Description |
|-------|------|-------------|
| `service.type` | string | Service type |
| `service.port` | int | Service port |
| `service.annotations` | object | Service annotations |
| `service.labels` | object | Service labels |

### Probes

| Value | Type | Description |
|-------|------|-------------|
| `livenessProbe` | object | Liveness probe configuration |
| `readinessProbe` | object | Readiness probe configuration |
| `startupProbe` | object | Startup probe configuration |

### Extensibility

| Value | Type | Description |
|-------|------|-------------|
| `extraVolumes` | list | Additional volumes |
| `extraVolumeMounts` | list | Additional volume mounts |
| `extraContainers` | list | Additional sidecar containers |
| `extraInitContainers` | list | Additional init containers |

## Optional

These values are chart-specific and only required where they make sense:

| Value | Type | When to use |
|-------|------|-------------|
| `ingress.*` | object | Charts exposing HTTP endpoints |
| `networkPolicy.*` | object | Charts that need network isolation |
| `autoscaling.*` | object | Charts that support HPA |
| `persistence.*` | object | Charts that need persistent storage |

## Labels

All resources must include the following standard labels:

```yaml
helm.sh/chart: {{ chart }}-{{ version }}
app.kubernetes.io/name: {{ name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
```

Pod selector labels (immutable after creation):

```yaml
app.kubernetes.io/name: {{ name }}
app.kubernetes.io/instance: {{ .Release.Name }}
```

## Security defaults

All charts must ship with secure defaults:

- `runAsNonRoot: true`
- `allowPrivilegeEscalation: false`
- `capabilities.drop: [ALL]`
- Read-only root filesystem where possible
