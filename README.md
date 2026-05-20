# OpenVox Helm Charts

Helm Charts for deploying [OpenVox](https://github.com/OpenVoxProject) components on Kubernetes.

This repository provides modular, independently installable charts for each component of the OpenVox stack. Instead of a single monolithic chart, each component can be installed, upgraded, and scaled on its own. See [docs/chart-standards.md](docs/chart-standards.md) for the conventions all charts follow.

## Charts

| Chart | Description | Status |
|-------|-------------|--------|
| [openvox-server](charts/openvox-server/) | OpenVox Server (Masters + Compilers + CA) | Planned |
| [openvox-db](charts/openvox-db/) | OpenVox DB (PuppetDB) | Planned |
| [openvox-r10k](charts/openvox-r10k/) | R10K standalone deployment for code sync | Planned |
| [openvox-postgresql](charts/openvox-postgresql/) | PostgreSQL via CloudNativePG | Planned |
| [openvoxview](charts/openvoxview/) | OpenVox View - Web UI for OpenVox DB | Available |
| [puppetboard](charts/puppetboard/) | Puppetboard - Web UI for PuppetDB | Planned |

## Usage

Charts are published as OCI artifacts to `ghcr.io/openvoxproject/charts`.

### OpenVox View

```bash
helm install openvoxview oci://ghcr.io/openvoxproject/charts/openvoxview \
  --version 0.1.0 \
  --set puppetdb.url=https://puppetdb:8081 \
  --set puppetdb.tlsSecretName=my-puppetdb-tls \
  --set puppetdb.caSecretName=my-puppetdb-ca
```

### Pull a chart locally

```bash
helm pull oci://ghcr.io/openvoxproject/charts/openvoxview --version 0.1.0
```

## Contributing

All charts follow the conventions in [docs/chart-standards.md](docs/chart-standards.md).

```bash
# Lint
helm lint charts/<chart-name>

# Run unit tests
helm plugin install https://github.com/helm-unittest/helm-unittest.git
helm unittest charts/<chart-name>

# Regenerate docs
helm-docs --chart-search-root charts
```

## License

This project is licensed under the [AGPL-3.0 License](LICENSE).
