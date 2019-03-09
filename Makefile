include lib.mk

HELM_DIR := cilium

.PHONY: examples

examples:
	mkdir examples
	for kube in 1.8 1.9 1.10 1.11 1.12 1.13; do
		echo Generating example deployment for $${kube}...
	    mkdir -p examples/k8s-$${kube}/
		$(helm) template \
		  --namespace=kube-system \
		  --kube-version=$$kube \
		  --name cilium \
		  --set fullNameOverride=cilium \
		  --output-dir examples/k8s-$${kube}/ \
		  cilium/
	done
