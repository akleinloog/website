---
title: 'Minikube - Kubernetes for developers'
subtitle: 'Set up a local Kubernetes installation using Minikube'
summary: Have Kubernetes up and running on your local dev machine.
authors:
- admin
tags:
- Kubernetes
- Minikube
date: "2020-05-30T00:00:00Z"
lastmod: "2020-05-30T00:00:00Z"
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

As described [here](/post/which-local-kubernetes), I decided to use [minikube](https://minikube.sigs.k8s.io/docs/) to run a Kubernetes cluster on my dev machine.
These are the details and some learnings along the way.

### Preparation

As usual, before starting any experiments, I want my MacBook up to date, so I make sure that I have the latest updates installed.
At the time of writing, these are macOS Catalina version 10.15.5 and Xcode version 11.5.
Then I make sure that brew and any installed packages are up to date as well:
```
brew update
brew upgrade
brew cask upgrade
```
In addition, make sure there are no issues. If there are, resolve them first:
```
brew doctor
```
Should give the following output when all is ready:
```
Your system is ready to brew.
```
Should you run into any issues, google is your friend...

If you are running windows, [chocolatey](https://chocolatey.org/) is a decent alternative to brew.

If not already installed, make sure you have [Docker Desktop](https://hub.docker.com/editions/community/docker-ce-desktop-mac) up and running.
This should also come with [Hyperkit](https://github.com/moby/hyperkit), a lightweight hypervisor for macOS.
You can find other alternatives [here](https://minikube.sigs.k8s.io/docs/drivers/).

### Installation

Install minikube and [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/):
```
brew install minikube
brew install kubectl
```

### First Cluster

Create a cluster:
```
minikube start
```
Gives an output similar to:
```
😄  minikube v1.11.0 on Darwin 10.15.5
✨  Using the hyperkit driver based on user configuration
🆕  Kubernetes 1.18.3 is now available. If you would like to upgrade, specify: --kubernetes-version=v1.18.3
👍  Starting control plane node minikube in cluster minikube
🔥  Creating hyperkit VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
🐳  Preparing Kubernetes v1.14.7 on Docker 19.03.8 ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"

❗  /usr/local/bin/kubectl is version 1.18.3, which may be incompatible with Kubernetes 1.14.7.
💡  You can also use 'minikube kubectl -- get pods' to invoke a matching version
```
This tells us that the default Kubernetes version that was used is **1.14.7**, and that the cluster has **2** CPUs, **2 GB** of memory and **20 GB** of disk spaces at its disposable.
It also tells us that the latest available version of Kubernetes is **1.18.3**.
Since this is my dev machine, I want to use the latest Kubernetes version, and I want to assign more resources.
Remove the cluster:
```
minikube delete
```
Gives an output similar to:
```
🔥  Deleting "minikube" in hyperkit ...
💀  Removed all traces of the "minikube" cluster.
```

Create a new cluster as follows:
```
minikube start --kubernetes-version=v1.18.3 --cpus=4 --memory='8g' --disk-size='80000mb'
```
Gives an output similar to:
```
😄  minikube v1.11.0 on Darwin 10.15.5
✨  Using the hyperkit driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🔥  Creating hyperkit VM (CPUs=4, Memory=8192MB, Disk=80000MB) ...
🐳  Preparing Kubernetes v1.18.3 on Docker 19.03.8 ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"
```

That is more like it. A local Kubernetes cluster up and running, and everything is up to date.
If you want, you can open the kubernetes dashboard using:
```
minikube dashboard
```
The dashboard will be installed and opened in a browser tab.

### Pause and resume

One very useful feature of minikube is that you can pause and resume your cluster.
If you don't need it for now, pause the cluster using:
```
minikube stop
```
Gives an output similar to:
```
✋  Stopping "minikube" in hyperkit ...
🛑  Node "minikube" stopped.
```
At a later point, you can resume it using:
```
minikube start --kubernetes-version=v1.18.3
```
Gives an output similar to:
```
😄  minikube v1.11.0 on Darwin 10.15.5
✨  Using the hyperkit driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🔄  Restarting existing hyperkit VM for "minikube" ...
🐳  Preparing Kubernetes v1.18.3 on Docker 19.03.8 ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"
```
Notice that you do need to provide the Kubernetes version if you specified one different from the default.
This command can also be used to upgrade the Kubernetes version if a newer one becomes available.

### Multiple Clusters

Another very useful feature of minikube is the ability to run multiple clusters.
You can run them at the same time to do multi-cluster experiments, or pause / resume them when switching between projects.
Let's first delete the previously created cluster:
```
minikube delete
```
Then create our first cluster:
```
minikube start -p cluster1 --kubernetes-version=v1.18.3
```
And then a second one:
```
minikube start -p cluster2 --kubernetes-version=v1.18.3
```

You can see the clusters using:
```
kubectl config get-contexts
```
Gives an output similar to:
```
CURRENT   NAME       CLUSTER    AUTHINFO   NAMESPACE
          cluster1   cluster1   cluster1
*         cluster2   cluster2   cluster2
```
The * marks the currently selected context. You can also see that using:
```
% kubectl config current-context
cluster2
```
You can switch between clusters by selecting their context:
```
% kubectl config use-context cluster1
Switched to context "cluster1".
```

Stop one of the clusters if you don't need it for now:
```
% minikube stop -p cluster2
✋  Stopping "cluster2" in hyperkit ...
🛑  Node "cluster2" stopped.
```

Resume it when you need it again:
```
% minikube start -p cluster2 --kubernetes-version=v1.18.3
😄  [cluster2] minikube v1.11.0 on Darwin 10.15.5
✨  Using the hyperkit driver based on existing profile
👍  Starting control plane node cluster2 in cluster cluster2
🔄  Restarting existing hyperkit VM for "cluster2" ...
🐳  Preparing Kubernetes v1.18.3 on Docker 19.03.8 ...
🔎  Verifying Kubernetes components...
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "cluster2"
```

And delete it when you don't need it anymore:
```
% minikube delete -p cluster2
🔥  Deleting "cluster2" in hyperkit ...
💀  Removed all traces of the "cluster2" cluster.
```

### Next Steps...

Get more familiar with Kubernetes, follow some basic tutorials to deploy your first app [here](https://kubernetes.io/docs/tutorials/) and find some more [here](https://katacoda.com/courses/kubernetes). Again, google is your friend, there is plenty of content out there.

As for me, my next step will be to install [Istio](https://istio.io/) and make sure that my cluster can also be reached from other machines in my network.
I'll present the details in a following post...