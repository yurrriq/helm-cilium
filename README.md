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
* toggle ipsec
* full config configurabilituy
* custom env, labels, annotations, affinity


### Namespacing

Although namespace is parsed correctly, 
cilium agent runs with a `priorityClass` of `system-node-critical`.
This is currently only allowed in `kube-system`, 
although that <should> change in the future 
(not sure though, the story in PR's/issues is a bit messy)


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
