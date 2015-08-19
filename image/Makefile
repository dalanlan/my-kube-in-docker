all:
	 # curl -O https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/hyperkube
	 # curl -O https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl
	 sed -e "s/VERSION/${VERSION}/g;s/REPO/${REPO}/g" master-multi-template.json > master-multi.json
	 #sed -e "s/{{ pillar\['dns_replicas'\] }}/${DNS_REPLICAS}/g;s/{{ pillar\['dns_domain'\] }}/${DNS_DOMAIN}/g;s/kube_server_url/${KUBE_SERVER}/g;" skydns-rc.yaml.template > skydns-rc.yaml
    
	 docker build -t ${REPO}/hyperkube:${VERSION} .

	
.PHONY: all
