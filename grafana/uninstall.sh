#!/bin/bash

helm uninstall -n grafana grafana

kubectl delete ns grafana