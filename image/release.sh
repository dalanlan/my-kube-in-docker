#!/bin/bash

set -ex

export MASTER_IP=10.10.102.97
export CLUSTER_NAME=97-server
export USER=97-emma
export CONTEXT_NAME=97-context
export VERSION=v1.0.0
export REPO=dalanlan

# #Seems that we should run as root
# sudo ./make-ca-cert.sh ${MASTER_IP} IP:${MASTER_IP},IP:192.168.3.0,IP:127.0.0.1,DNS:kubernetes,DNS:kubernetes.default,DNS:kubernetes.default.svc,DNS:kubernetes.default.svc.cluster.local
# #sudo rm -f ~/.kube/config
# sudo kubectl config set-cluster ${CLUSTER_NAME} --certificate-authority=/srv/kubernetes/ca.crt --embed-certs=true --server=https://${MASTER_IP}:6443
# sudo kubectl config set-credentials ${USER} --client-certificate=/srv/kubernetes/kubecfg.crt --client-key=/srv/kubernetes/kubecfg.key --embed-certs=true
# sudo kubectl config set-context ${CONTEXT_NAME} --cluster=${CLUSTER_NAME} --user=${USER}
# sudo kubectl config use-context ${CONTEXT_NAME} 
# sudo cp $HOME/.kube/config /srv/kubernetes
# sudo cp -R /srv/kubernetes .
# sudo chmod 666 -R kubernetes/




#make hyperkube binary && docker build
make
sudo docker save ${REPO}/hyperkube:${VERSION} > hyper.tar
sudo cp hyper.tar ../tarpackage
