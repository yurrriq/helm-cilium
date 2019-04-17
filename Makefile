include lib.mk

HELM_DIR := cilium
KUBE_VERSIONS := 1.8 1.9 1.10 1.11 1.12 1.13 1.14

.PHONY: examples

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

clean:
	rm -rf generated/
