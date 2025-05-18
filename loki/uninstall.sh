#!/bin/bash

helm uninstall -n loki loki

kubectl delete ns loki