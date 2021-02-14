---
title: 'MicroK8s - Kubernetes for developers'
subtitle: 'Set up a local Kubernetes installation using MicroK8s'
summary: Autonomous, production-grade Kubernetes on your local dev machine.
authors:
- admin
tags:
- Kubernetes
- MicroK8s
- Multipass
date: "2021-02-13T00:00:00Z"
featured: true
draft: false

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

First things first, as always, I want my MacBook up to date.
At the time of writing, it runs macOS Big Sur version 11.2.1 and Xcode version 12.0.1.
Time to update the rest:
```bash
brew update
brew upgrade
brew upgrade --cask
```
In addition, make sure there are no issues. If there are, resolve them first:
```bash
brew doctor
```
Should give the following output when all is ready:
```bash
Your system is ready to brew.
```
Should you run into any issues, I recommend to fix these first. Google is your friend...

If you are running windows, [chocolatey](https://chocolatey.org/) is a decent alternative to brew.

### Install Multipass

[Multipass](https://multipass.run) makes it easy to work with Ubuntu VMs on a Mac or Windows workstation.
Install it using:
```bash
brew install --cask multipass
```
After a little while, the installation completes:
```plaintext
🍺  multipass was successfully installed!
```
For more info on Multipass, check the [docs](https://multipass.run/docs).

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