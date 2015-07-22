##HOW to deploy
1 build hyperkube
cd image 
./release.sh
2 install docker && k8s
./master.sh
scp /srv/kubernetes to all of the nodes 
./deploydns.sh or go run deploy_addone.go

##Basic Idea
https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/docker-multinode/master.md 

>Attention 
not all of the versioned docker support this. Do Figure Out the correct version.


##To make sure dns is working
See also [here](https://github.com/GoogleCloudPlatform/kubernetes/tree/master/cluster/addons/dns#how-do-i-test-if-it-is-working).

```
###ENV
1 docker version: 1.7.1 (DONE!)
2 k8s version:v1.0.0
3 changed image: hyperkube(make it locally & unique),kube2sky(also). This is about repo.
4 



##How to debug why apiserver/controller-manager/scheduler does not work -- parm focus.

/hyperkube apiserver --etcd-servers=http://127.0.0.1:4001 --cluster-name=kubernetes --service-cluster-ip-range=192.168.3.0/24 --client-ca-file=/srv/kubernetes/ca.crt --tls-cert-file=/srv/kubernetes/server.cert --tls-private-key-file=/srv/kubernetes/server.key --admission_control=NamespaceLifecycle,NamespaceAutoProvision,LimitRanger,ServiceAccount,ResourceQuota

/hyperkube controller-manager --master=https://127.0.0.1:6443 --root-ca-file=/srv/kubernetes/ca.crt --service-account-private-key-file=/srv/kubernetes/server.key --kubeconfig=/srv/kubernetes/config

/hyperkube scheduler --master=https://127.0.0.1:6443 --kubeconfig=/srv/kubernetes/config


##How to tear down a k8s cluster?
1 delete all of the binaries in /opt/bin
2 delete /var/lib/kubelet and so on
3 rm docker (also recommend)


## TODO
1 Figure out what eth0/eth1 stuff

2 etcd 4001

3 why deploying dns still needs kubeconfig? Should it be default?
Because we do not have default secrets(token) locally.

4 Figure out admission-control stuff
- admission controller (part of apiserver, set parm into)
See also https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/admin/admission-controllers.md
"--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"
(SecurityContextDeny does not harm for now, but do use `NamespaceExists` instead of `NamespaceAutoProvision`)
Soooo to figure out how to new a namespace

5 Figure out secret/service account stuff

sol: See also https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/admin/service-accounts-admin.md#service-account-admission-controller
The host machine does not have token and ca.crt, which locates in the container of kubelet. Hence it's not able to start it directly. What about volumes?
You cannot use -v /var/lib/kubelet:/var/lib/kubelet. For the machine would tear it down automatically. Hence kubeconfig is the comfortable way.

https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/user-guide/secrets.md
Another example.https://github.com/GoogleCloudPlatform/kubernetes/tree/master/docs/user-guide/secrets
> WE can create a secret manually.
> Once the secret is created, you can create pods that automatically use it via a Service Account,or modify your pod specification to use the secret.


6 How to make namespaces seperate? We could always use a `--all-namespaces- param.

7 the clean.sh seems to have some issues.

DOCKER_OPTS="$DOCKER_OPTS -H tcp://127.0.0.1:4243 -H unix:///var/run/docker.sock --registry-mirror=http://c935e4a0.m.daocloud.io --insecure-registry 10.10.103.215:5000 --insecure-registry 121.40.171.96:5000"
Do we need this? Not really, we could delete it as far as i could see.
-H tcp://127.0.0.1:4243 is used for the Docker API to connect to docker daemon from another machine. 
-H unix:///var/run/docker is default.

8 Cadvisor issue (warning on kubelet)

9 To close 8080 of apiserver forcely.
Seems do not have to bother. 'Cause we have
```
emma@emma-OptiPlex-3010:~/86-server$ kubectl get nodes
NAME        LABELS                             STATUS
127.0.0.1   kubernetes.io/hostname=127.0.0.1   Ready
emma@emma-OptiPlex-3010:~/86-server$ kubectl -s 10.10.103.86:8080 get nodes
error: couldn't read version from server: Get http://10.10.103.86:8080/api: dial tcp 10.10.103.86:8080: connection refused
```
Then who could reach that?

10 How to figure out the pod id 
kubectl get pod/<pod-name> -o yaml
kubectl describe <pod-id> 

11 gorouter will not working in this case, should temporily shutdown. 
##[scratch.md](https://github.com/GoogleCloudPlatform/kubernetes/blob/master/docs/getting-started-guides/scratch.md)


12 curl a kubectl binary for configuration (kubectl config)
<no need to>

13 manage images in a sorted way

14 deploy Cadvisor

15 Need to cover all of the details of kube2sky
<build a new image every time>
