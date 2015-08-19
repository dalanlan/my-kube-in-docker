#!/bin/bash

set -ex

export MASTER_IP=10.10.103.100
export CLUSTER_NAME=100-server
export USER=100-emma
export CONTEXT_NAME=100-context
#now we have v1.0.1 available
export VERSION=v1.0.3-dir

#strogly recomand to be MASTER_IP:5000
export REPO=dalanlan

#Seems that we should run as root
sudo ./make-ca-cert.sh ${MASTER_IP} IP:${MASTER_IP},IP:192.168.3.0,IP:127.0.0.1,DNS:kubernetes,DNS:kubernetes.default,DNS:kubernetes.default.svc,DNS:kubernetes.default.svc.cluster.local
#sudo rm -f ~/.kube/config

#curl -O https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl
#sudo cp kubectl /bin/
sudo kubectl config set-cluster ${CLUSTER_NAME} --certificate-authority=/srv/kubernetes/ca.crt --embed-certs=true --server=https://${MASTER_IP}:6443
sudo kubectl config set-credentials ${USER} --client-certificate=/srv/kubernetes/kubecfg.crt --client-key=/srv/kubernetes/kubecfg.key --embed-certs=true
sudo kubectl config set-context ${CONTEXT_NAME} --cluster=${CLUSTER_NAME} --user=${USER}
sudo kubectl config use-context ${CONTEXT_NAME} 
sudo cp $HOME/.kube/config /srv/kubernetes
sudo cp -R /srv/kubernetes .
sudo chmod 777 -R kubernetes/

# Distribute certs & keys to all of the nodes
# sudo scp -r /srv/kubernetes <username>:<master_ip>:/srv/



#make hyperkube binary && docker build
make
sudo docker save ${REPO}/hyperkube:${VERSION} > hyperkube-${VERSION}.tar
# sudo cp hyper.tar ../tarpackage
# scp hyperkube image to the master node 
