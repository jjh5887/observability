  #!/bin/bash

  helm repo add grafana https://grafana.github.io/helm-charts

  helm repo update

  helm install --values values.yaml loki grafana/loki