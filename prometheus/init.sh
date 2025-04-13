  #!/bin/bash

git clone https://github.com/prometheus-operator/kube-prometheus.git

kubectl create ns monitoring

kubectl apply -f manifests/setup

kubectl apply -f manifests

