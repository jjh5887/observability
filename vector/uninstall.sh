#!/bin/bash

helm uninstall -n vector vector

kubectl delete ns vector