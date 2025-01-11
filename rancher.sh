#!/bin/bash

read -p "Enter the IP of the K3S Master: " master_ip
echo "Copying the k3s.yaml from $master_ip to ~/.kube/config"

scp root@$master_ip:/etc/rancher/k3s/k3s.yaml ~/.kube/config



brew install kubectl
brew install helm


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
  --set hostname=stratus \
  --set replicas=1 \
  --set bootstrapPassword=Welcome25!

  echo "Done and done!  Now the longhorn check"

curl -sSfL https://raw.githubusercontent.com/longhorn/longhorn/v1.7.2/scripts/environment_check.sh | bash

echo "Resolve this issues BEFORE installing longhorn!!!"



