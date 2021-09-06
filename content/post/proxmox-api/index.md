---
title: 'Talos - Kubernetes as it should be'
subtitle: 'The right OS for your Kubernetes nodes'
summary: Immutable, atomic, minimal, secure.
authors:
- admin
tags:
- Kubernetes
- Talos
- Proxmox
date: "2021-09-03T00:00:00Z"
featured: true
draft: true

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Placement options: 1 = Full column width, 2 = Out-set, 3 = Screen-width
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

Following my initial post on [local Kubernetes options](/post/which-local-kubernetes) and a deep dive on [Minikube](/post/minikube-kubernetes) it is time to take [MicroK8s](https://microk8s.io) for a spin.
I have been looking forward to this for a while, so let's get started.

### Preparation

First, download and install talosctl on my Mac:
```bash
curl https://github.com/talos-systems/talos/releases/latest/download/talosctl-darwin-amd64 -L -o talosctl
cp talosctl /usr/local/bin
chmod +x /usr/local/bin/talosctl
```

Test if talosctl is working properly by creating a local cluster:
```bash
talosctl cluster create
```

This should give an output similar to:
```bash
validating CIDR and reserving IPs
generating PKI and tokens
downloading ghcr.io/talos-systems/talos:v0.12.0
creating network talos-default
creating master nodes
creating worker nodes
waiting for API
bootstrapping cluster
waiting for etcd to be healthy: OK
waiting for apid to be ready: OK
waiting for kubelet to be healthy: OK
waiting for all nodes to finish boot sequence: OK
waiting for all k8s nodes to report: OK
waiting for all k8s nodes to report ready: OK
waiting for all control plane components to be ready: OK
waiting for kube-proxy to report ready: OK
waiting for coredns to report ready: OK
waiting for all k8s nodes to report schedulable: OK

merging kubeconfig into "/Users/<me>/.kube/config"
PROVISIONER       docker
NAME              talos-default
NETWORK NAME      talos-default
NETWORK CIDR      10.5.0.0/24
NETWORK GATEWAY   10.5.0.1
NETWORK MTU       1500

NODES:

NAME                      TYPE           IP         CPU    RAM      DISK
/talos-default-master-1   controlplane   10.5.0.2   2.00   2.1 GB   -
/talos-default-worker-1   worker         10.5.0.3   2.00   2.1 GB   -
```

Talos created a 2-node cluster using docker containers as nodes:
```bash
docker ps -a
```
returns:
```bash
CONTAINER ID   IMAGE                                 NAMES
3dbe890dc8ae   ghcr.io/talos-systems/talos:v0.12.0   talos-default-worker-1
b6443453b675   ghcr.io/talos-systems/talos:v0.12.0   talos-default-master-1
```

The cluster can be deleted using
```bash
talosctl cluster destroy
```

### Install using Proxmox

Let's create a 3-node cluster using Proxmox VMs as nodes following [these](https://www.talos.dev/docs/v0.12/virtualized-platforms/proxmox/) instructions.
I'll use the Proxmox cluster I created [before](/post/proxmox) and create one node on each host.



### Create an Ubuntu VM

TIme to create an Ubuntu VM to install MicroK8s on. Let's give it some resources as well.

```bash
multipass launch --name k8s-master --cpus 4 --mem 16G --disk 50G
```
After a little while, a new VM is created:
```plaintext
Launched: k8s-master
```

Open a shell into our new VM
```bash
multipass shell k8s-master
```

And make sure it is up to date:
```bash
sudo su
apt update
apt upgrade
```

### Install MicroK8s

Time to install MicroK8s:
```bash
sudo snap install microk8s --classic --channel=1.19/stable
```
And make sure the networking runs smoothly:
```bash
sudo iptables -P FORWARD ACCEPT
```

MicroK8s creates a group to enable seamless usage of commands which require admin privilege. Add your user to this group: 
```bash
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
```
Re-enter the session so the group update takes place:
```bash
su - $USER
```
Make sure that the cluster was created successfully:
```bash
microk8s status --wait-ready
```
Create an alias for kubectl:
```bash
alias kubectl='microk8s kubectl'
```

For more info on MicroK8s, check the [docs](https://microk8s.io/docs).


### First deployment

Deploy a simple application:
```bash
kubectl create deployment hello --image=akleinloog/hello:v1
```
Verify that the pod is up and running:
```bash
kubectl get pods
```
And expose it:
```bash
kubectl expose deployment hello --port=80 --type=NodePort
```
See at which port it is available:
```bash
kubectl get services
```
This should give a response similar to:
```bash
NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP   10.152.183.1    <none>        443/TCP        15m
hello        NodePort    10.152.183.70   <none>        80:31984/TCP   3s
```
Which tells us that the hello app is exposes at port 31984, so we can test it using:
```bash
curl localhost:31984
```

Which should give output similar to:
```bash
Go Hello 1 from hello-656897b96f-dvwc7 on GET ./
```

On your host machine, list the multipass VMs:
```bash
multipass list
```

Which should give output similar to:
```bash
k8s-master              Running           192.168.64.52    Ubuntu 20.04 LTS
                                          10.1.235.192
```

Which tells us that we can access the app running in our Kubernetes instance using:
```bash
curl 192.168.64.52:31984
```
Or by simply pointing our browser to http://192.168.64.52:31984

### Next Steps...

To get more familiar with Kubernetes, follow some basic tutorials [here](https://kubernetes.io/docs/tutorials/) and find some more [here](https://katacoda.com/courses/kubernetes). Again, google is your friend, there is plenty of content out there.

In addition, you can install some readily available [MicroKs add ons](https://microk8s.io/docs/addons) like [Istio](https://istio.io/) or [Knative](https://knative.dev/) and play around with those. Last but not least, extend your single node cluster with [additional nodes](https://microk8s.io/docs/clustering)!

As for me, my next step will be to setup a [Rancher](https://rancher.com/) instance and create a managed local cluster.