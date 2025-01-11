#!/bin/bash
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=cirrus.thehussains.org \
  --set replicas=1 \
  --set bootstrapPassword=Chibears2025!!

  echo "Done and done!  Now DO YOUR LONGHORN CHECK"
