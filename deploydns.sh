#!/bin/bash

kubectl --namespace=kube-system create -f skydns-rc.yaml
kubectl --namespace=kube-system create -f skydns-svc.yaml
kubectl --namespace=kube-system get rc
kubectl --namespace=kube-system get se

kubectl create -f busybox.yaml 
sleep 100
kubectl get pods --all-namespaces
kubectl exec busybox -- nslookup kubernetes

#kubectl --namespace=kube-system get pods
