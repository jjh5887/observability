#!/bin/bash
kubectl create ns loki || true

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm upgrade --install --values values.yaml loki grafana/loki --namespace loki