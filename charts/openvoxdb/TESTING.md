# Testing OpenVoxDB

## Local chart checks

From the repository root, with Helm and the helm-unittest plugin installed:

```sh
helm dependency build charts/openvoxdb
helm lint charts/openvoxdb
helm unittest charts/openvoxdb
```

Dependency build is needed when dependencies are missing or the lock file changes.

Like openvoxview, a k8s cluster is not required to run the tests.