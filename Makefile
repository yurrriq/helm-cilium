include lib.mk

HELM_DIR := cilium
CILIUM_VERSION := 1.5.0
KUBE_VERSIONS := 1.11 1.12 1.13 1.14
CILIUM_REPO := ../upstream/cilium

.PHONY: examples repo-refresh

examples:
	mkdir generated
	for kube in $(KUBE_VERSIONS); do
		echo Generating example deployment for $${kube}...
	    mkdir -p generated/k8s-$${kube}/
		$(helm) template \
		  --namespace=kube-system \
		  --kube-version=$$kube \
		  --name cilium \
		  -f cilium/examples/cilium.yml \
		  --output-dir generated/k8s-$${kube}/ \
		  cilium/
	done
	echo Generating example deployment for minikube...
	mkdir -p generated/minikube/
	$(helm) template \
	  --namespace=kube-system \
	  --kube-version=$$kube \
	  --name cilium \
	  -f cilium/examples/minikube.yml \
	  --output-dir generated/minikube/ \
	  cilium/


repo-refresh: branch := v$(basename $(CILIUM_VERSION))
repo-refresh:
	set -x
	(
	cd $(CILIUM_REPO)/examples/kubernetes
	if [ `git rev-parse --abbrev-ref HEAD` != $(branch) ]; then
	  git checkout $(branch)
	fi
	git pull
	)


ifdef UPDATE
versions: repo-refresh
endif
versions: init_version = $(shell make -npC $(CILIUM_REPO)/examples/kubernetes | sed -E '/^CILIUM_INIT_VERSION/!d;s|[^"]*"([^"]+)".*|\1|g')
versions: etcd_operator_version = $(shell make -npC $(CILIUM_REPO)/examples/kubernetes | sed -E '/^CILIUM_ETCD_OPERATOR_VERSION/!d;s|[^"]*"([^"]+)".*|\1|g')
versions:
	echo "init_version: $(init_version) etcd_operator_version:$(etcd_operator_version)"

	[ -z "$$UPDATE" ] && exit 0
	sed -i 's/appVersion: .*/appVersion: $(CILIUM_VERSION)/' $(HELM_DIR)/Chart.yaml
	sed -i -E \
	  -e '/^operator:/,/ tag:.*/s| tag:.*| tag: v$(CILIUM_VERSION)|g' \
	  -e '/^agent:/,/ labels:.*/{/ image:/,/ tag:/s| tag:.*| tag: v$(CILIUM_VERSION)|g;}' \
	  -e '/^agent:/,/ labels:.*/{/ init_image:/,/ tag:/s| tag:.*| tag: $(init_version)|g}' \
	  -e '/^etcd:/,/ labels:.*/{/ operator:/,/ tag:/s| tag:.*| tag: $(etcd_operator_version)|g}' \
	cilium/values.yaml


clean:
	rm -rf generated/
