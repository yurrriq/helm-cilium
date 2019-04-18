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
* operator support config file
* operator:
  ```
Run the cilium-operator

Usage:
  cilium-operator [flags]

TODO:
      --api-server-port uint16               Port on which the operator should serve API requests (default 9234)
      --cilium-endpoint-gc                   Enable CiliumEndpoint garbage collector (default true)
      --identity-gc-interval duration        GC interval for security identities (default 10m0s)
      --synchronize-k8s-services             Synchronize Kubernetes services to kvstore (default true)
      --unmanaged-pod-watcher-interval int   Interval to check for unmanaged kube-dns pods (0 to disable) (default 15)
      # disable-endpoint-crd: false    # If you want to disable endpoint CRD generation, enable this

      --cluster-id int                       Unique identifier of the cluster
      --cluster-name string                  Name of the cluster (default "default")
      --kvstore string                       Key-value store type
      --kvstore-opt map                      Key-value store options (default map[])
      -D, --debug                            Enable debugging mode


Flags:
      --api-server-port uint16               Port on which the operator should serve API requests (default 9234)
      --cilium-endpoint-gc                   Enable CiliumEndpoint garbage collector (default true)
      --cluster-id int                       Unique identifier of the cluster
      --cluster-name string                  Name of the cluster (default "default")
  -D, --debug                                Enable debugging mode
  -h, --help                                 help for cilium-operator
      --identity-gc-interval duration        GC interval for security identities (default 10m0s)
      --k8s-api-server string                Kubernetes api address server (for https use --k8s-kubeconfig-path instead)
      --k8s-kubeconfig-path string           Absolute path of the kubernetes kubeconfig file
      --kvstore string                       Key-value store type
      --kvstore-opt map                      Key-value store options (default map[])
      --synchronize-k8s-services             Synchronize Kubernetes services to kvstore (default true)
      --unmanaged-pod-watcher-interval int   Interval to check for unmanaged kube-dns pods (0 to disable) (default 15)
      --version                              Print version information
  ```
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
