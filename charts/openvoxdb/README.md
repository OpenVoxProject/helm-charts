# openvoxdb

Standalone OpenVox DB (PuppetDB)

## Usage

From the repository root, download the pinned PostgreSQL dependency once:

```sh
helm dependency build charts/openvoxdb
```

If you don't have an existing puppet/openvox server ensure to set the following flag to false
```sh
helm install openvoxdb charts/openvoxdb --set puppetServer.enabled=false
```

If you have an existing puppet/openvox then make sure you configure its hostname in an values_override file or as an argument.

```sh
helm install openvoxdb charts/openvoxdb \
  --set puppetServer.hostname=server.example.com
```

Enrollment is enabled by default and requires a server hostname and certificate
signing policy. The chart deploys OpenVoxDB and PostgreSQL. HTTP uses port 8080;
HTTPS uses port 8081 when certificates are configured.

## Configuration

Bundled PostgreSQL uses HelmForge 2.0.5 with the official PostgreSQL 17.11 image.
Passwords are generated when empty. A separate query account is provisioned
before OpenVoxDB starts. Both components use persistent storage by default.

Additional HelmForge options can be set under `postgresql.*`.

Optional metrics overrides include `extraEnv`, `extraEnvSecret`, and ServiceMonitor
`namespace`, `additionalLabels`, `scrapeTimeout`, `relabelings`, and `metricRelabelings`.

| Value | Default | Purpose |
| --- | --- | --- |
| `puppetServer.enabled` | `true` | Enable server enrollment |
| `puppetServer.hostname` | `""` | Existing OpenVox Server address |
| `postgresql.enabled` | `true` | Deploy bundled PostgreSQL |
| `postgresql.image.tag` | `17.11-bookworm` | Pinned PostgreSQL image |
| `postgresql.auth.database` | `puppetdb` | Application database |
| `postgresql.auth.username` | `puppetdb` | Application writer |
| `postgresql.auth.postgresPassword` | `""` | Administrator password, generated when empty |
| `postgresql.auth.password` | `""` | Writer password, generated when empty |
| `postgresql.auth.existingSecret` | `""` | Existing database password Secret |
| `postgresql.standalone.resourcesPreset` | `none` | PostgreSQL resource preset |
| `postgresql.standalone.persistence.size` | `10Gi` | PostgreSQL storage |
| `readDatabase.enabled` | `true` | Provision a separate query account |
| `persistence.size` | `10Gi` | OpenVoxDB storage |
| `persistence.existingClaim` | `""` | Reuse OpenVoxDB storage |
| `service.type` | `ClusterIP` | ClusterIP, NodePort, or LoadBalancer |
| `service.httpPort` | `8080` | HTTP service port |
| `service.port` | `8081` | HTTPS service port |
| `metrics.enabled` | `false` | Enable the exporter |
| `networkPolicy.enabled` | `false` | Enable traffic restrictions |

See [values.yaml](values.yaml) for chart defaults,
[HelmForge documentation](https://helmforge.dev/docs/charts/postgresql)
for inherited PostgreSQL options.

## Validation

Standalone startup and facts submission/query have passed runtime testing.
See [TESTING.md](TESTING.md) for local tests and the API smoke test.
