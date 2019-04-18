# TODO
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
* cilium-agent can't load KVSTORE_OPT as map
* operator cant load KVSTORE as env
