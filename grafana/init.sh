#!/bin/bash

kubectl create ns grafana || true

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm upgrade --install --values values.yaml grafana grafana/grafana --namespace grafana

echo "[INFO] Waiting for Grafana pod to be ready..."
kubectl wait --namespace grafana \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/name=grafana \
  --timeout=180s

if [ $? -ne 0 ]; then
  echo "[ERROR] Timed out waiting for Grafana pod to be ready."
  exit 1
fi

kubectl port-forward -n grafana svc/grafana 3000:80