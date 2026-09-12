#!/bin/bash
set -e

echo "Adding Helm repositories..."

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/

helm repo update

echo "Creating monitoring namespace..."

kubectl create namespace monitoring \
  --dry-run=client \
  -o yaml | kubectl apply -f -

echo "Installing kube-prometheus-stack..."

helm upgrade --install monitoring \
  prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f monitoring/values.yaml

echo "Installing Metrics Server..."

helm upgrade --install metrics-server \
  metrics-server/metrics-server \
  -n kube-system

echo "Monitoring installation complete."
