# Cilium Helm Chart

## Prerequisites Details

* BPF filesystem mounted & kicking ass


## Features

* toggle operator
* toggle etcd-operator
* toggle prometheus
* toggle rbac
* toggle psp
* runtime (docker, container-d or crio)
* full config and env configurabilituy
* toggle ipsec


## Values & settings

See values.yml


## TLDR;

```sh
kube=1.13
helm template \
  --namespace=kube-system \
  --kube-version=$kube \
  --name cilium \
  -f cilium/examples/cilium.yml \
  --output-dir examples/k8s-${kube}/ \
  cilium/
```

```sh
helm install --upgrade \
  --namespace=kube-system \
  --name cilium \
  -f cilium/examples/cilium.yml \
  cilium/
```
