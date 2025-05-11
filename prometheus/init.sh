  #!/bin/bash

REPO_URL=""
DIR_NAME="kube-prometheus"

if [ -d "$DIR_NAME/.git" ]; then
    echo "'$DIR_NAME' 디렉토리가 이미 존재합니다. 최신 내용을 가져옵니다..."
    cd "$DIR_NAME" && git pull
else
    echo "'$DIR_NAME' 디렉토리가 존재하지 않습니다. 클론을 수행합니다..."
    git clone "$REPO_URL" "$DIR_NAME"
    cd "$DIR_NAME"
fi

kubectl create ns monitoring

kubectl create -f manifests/setup

kubectl create -f manifests

kubectl get crd -n monitoring

helm repo add kedacore https://kedacore.github.io/charts

helm repo update

helm install keda kedacore/keda --namespace keda --create-namespace

kubectl -n monitoring port-forward svc/prometheus-k8s 9090