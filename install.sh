
#!/bin/bash

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.31.4+k3s1 sh -s - server --cluster-init


# Get the IP address using hostname
host_ip=$(hostname -I | awk '{print $1}')


echo "K3S is now installed.   Now you'll need to copy the KubeConifig to your local workstation."
echo "use: scp root@$host_ip:/etc/rancher/k3s/k3s.yaml ~/.kube/config"
echo "After copying the Kubeconfig, Please press any key to continue..."
read -n 1 -s -r

echo "Thank you. Now we can install Rancher"


helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
echo "Rancher Repo Added"
kubectl create namespace cattle-system
echo "name space added"
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.crds.yaml
echo "Cert Manager Chart Installed"

helm repo add jetstack https://charts.jetstack.io
echo "Jetstack Repo Added"

helm repo update
echo "Helm repo updated"


helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace
echo "Cert Manager Installed"
echo "Rancher Install Has Begun"

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=cirrus.thehussains.org \
  --set replicas=1 \
  --set bootstrapPassword=Chibears2025!!

echo "Rancher Installed"
