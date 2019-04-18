# Cilium Helm Chart

## Prerequisites Details

* BPF filesystem mounted & kicking ass

## TODO
* properly deal with runtime paths 
  * (? are multiple paths even supported?)
  * /var/run/one.sock -> /var/run/mydocker.sock, /var/run/two.sock -> /var/run/yourdocker.sock?
* consul?
  ```yaml
  kvstore: consul
  kvstore-opt:    
    consul.address  # Addresses of consul cluster
    consul.tlsconfig  # Path to consul tls configuration file
  ```
  ```yaml
  cafile: '/var/lib/cilium/consul-ca.pem'
  keyfile: '/var/lib/cilium/client-key.pem'
  certfile: '/var/lib/cilium/client.pem'
  #insecureskipverify: true
  ```
* node-init
* pre-flight
* post-test
* replace cilium-etcd-operator w/Helm etcd operator dep
* sidecar stuffs


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
