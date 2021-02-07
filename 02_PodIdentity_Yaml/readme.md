# Pod Identity YAML Manifest

This folder contains the yaml file taken from Pod Identity OSS [site](https://azure.github.io/aad-pod-identity/docs/getting-started/installation/)
It is used to install the last available version of pod identity with the appropriatemodification for the solution to work on AKS with kubenet.
Future version may modify the osurce of the container image to centralize it on a dedicated rexel registry.

## Installation steps

Refer to Pod identity documentation for additional details.
The installation is done in 2 steps: 

- The Pod Identity infrastructure
- The Pod Identity Exceptions

## Specific config for kubenet installation

For pod identity to be able to work, we need to add a specific arg in the container: 

```yaml

      containers:
      - name: nmi
        image: "mcr.microsoft.com/oss/azure/aad-pod-identity/nmi:v1.7.1"
        imagePullPolicy: Always
        args:
          - "--node=$(NODE_NAME)"
          - "--http-probe-port=8085"
          - "--allow-network-plugin-kubenet=true"

```