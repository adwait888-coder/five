#!/usr/bin/env bash
set -euo pipefail

docker build -t spring-petclinic:latest .

MINIKUBE_CMD=$(which minikube || echo "/usr/local/bin/minikube")
"$MINIKUBE_CMD" image load spring-petclinic:latest

kubectl apply -f db.yml
kubectl apply -f petclinic.yml

kubectl rollout status deployment/demo-db --timeout=120s
kubectl rollout status deployment/petclinic --timeout=120s