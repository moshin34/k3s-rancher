
#!/bin/bash
# Get the IP address using hostname
host_ip=$(hostname -I | awk '{print $1}')
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.31.4+k3s1 sh -s - server --cluster-init
echo  "K3S is now installed.   Now you'll need to copy the KubeConifig to your local workstation."
echo  "From the workstation use: scp root@$host_ip:/etc/rancher/k3s/k3s.yaml ~/.kube/config"
echo "then press any key to continue, once this is complete."
read
