include lib.mk

HELM_DIR := cilium
KUBE_VERSIONS := 1.8 1.9 1.10 1.11 1.12 1.13

.PHONY: examples

examples:
	mkdir examples
	for kube in $(KUBE_VERSIONS); do
		echo Generating example deployment for $${kube}...
	    mkdir -p examples/k8s-$${kube}/
		$(helm) template \
		  --namespace=kube-system \
		  --kube-version=$$kube \
		  --name cilium \
		  -f cilium/examples/cilium.yml \
		  --output-dir examples/k8s-$${kube}/ \
		  cilium/
	done
	echo Generating example deployment for minikube...
	mkdir -p examples/minikube/
	$(helm) template \
	  --namespace=kube-system \
	  --kube-version=$$kube \
	  --name cilium \
	  -f cilium/examples/minikube.yml \
	  --output-dir examples/minikube/ \
	  cilium/
