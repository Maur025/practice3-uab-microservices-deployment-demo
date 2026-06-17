#!/bin/bash
set -e

shopt -s expand_aliases
alias kubectl="minikube kubectl --"

echo "Deploying application to production environment..."

kubectl rollout restart deployment company-deployment
kubectl rollout restart deployment inventory-deployment
kubectl rollout restart deployment payment-deployment
kubectl rollout restart deployment people-deployment
kubectl rollout restart deployment purchase-deployment
kubectl rollout restart deployment sale-deployment
kubectl rollout restart deployment gateway-deployment

kubectl rollout status deployment gateway-deployment

echo "All pods have been updated successfully."