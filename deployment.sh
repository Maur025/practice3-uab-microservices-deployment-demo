#!/bin/bash
set -e

shopt -s expand_aliases
alias kubectl="minikube kubectl --"

echo "Deploying application to production environment..."

kubectl delete configmap mariadb-init-script --ignore-not-found

kubectl create configmap mariadb-init-script --from-file=sistema_supermercado.sql

cd mariadb/

kubectl apply -f mariadb-infrastructure.yaml
kubectl apply -f mariadb-deployment.yaml
kubectl apply -f mariadb-service.yaml

echo "Waiting 10 seconds for MariaDB to be ready..."
sleep 10

cd ..

cd people/

kubectl apply -f people-deployment.yaml
kubectl apply -f people-service.yaml

cd ..

cd gateway/

kubectl apply -f gateway-deployment.yaml
kubectl apply -f gateway-service.yaml

echo "Deployment completed successfully!"