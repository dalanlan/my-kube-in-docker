all:
	 #curl -O https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/hyperkube
	 sed -e "s/VERSION/${VERSION}/g" master-multi-template.json > master-multi.json  
	 docker build -t ${REPO}/hyperkube:${VERSION} .

	
.PHONY: all
