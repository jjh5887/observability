#!/bin/bash
kubectl create ns vector || true

helm repo add vector https://helm.vector.dev

helm repo update

helm install vector vector/vector \
  --namespace vector \
  --values values.yaml

