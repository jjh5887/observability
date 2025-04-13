  #!/bin/bash

git clone https://github.com/prometheus-operator/kube-prometheus.git

kubectl apply -f manifests/setup

kubectl apply -f manifests

