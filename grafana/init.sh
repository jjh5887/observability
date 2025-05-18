#!/bin/bash

kubectl create ns grafana || true

helm repo add grafana https://grafana.github.io/helm-charts

helm repo update

helm install --values values.yaml grafana grafana/grafana --namespace grafana

# kubectl port-forward -n grafana svc/grafana 3000:80