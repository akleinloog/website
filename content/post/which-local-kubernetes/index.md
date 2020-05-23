---
title: 'Which Kubernetes to use on my development PC?'
subtitle: 'Kubernetes on my machine, a great idea, but which one?'
summary: What is the best way to run local Kubernetes clusters on my developer machine? Taking a look at Docker vs Kind vs Minikube vs K3d.
authors:
- admin
tags:
- Kubernetes
- Minikube
- Kind
- K3s
- Docker
date: "2020-05-22T00:00:00Z"
lastmod: "2020-05-22T00:00:00Z"
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

[Kubernetes](https://kubernetes.io) is the state-of-the-art when it comes to container orchestration.  
It was built upon years of experience with production workloads at Google, combined with best-of-breed ideas and practices from the community.
It is available Open Source and vendor neutral and runs basically everywhere.

Today, I see Kubernetes as the Operating System of the Cloud Native world.  
It provides the base environment for my containerized applications, and as such, it is important to me to have it running locally on my development PC.

To this end, several decent options are available. Which to choose when?

### My Requirements

As always, choosing a solution works best if you understand your needs.
Since this is for my local development environment, my must haves are:
* Runs on my laptop
* Easy to install, configure and automate
* Wide support of Kubernetes versions and features
* Cross Platform, available for Mac, Windows and Linux

In addition, I would like to use the same solution on a single machine personal development server.
Using different solutions is an option.

### The Alternatives

So far, I have identified the following potential solutions:

[Docker Desktop](https://www.docker.com/blog/kubernetes-is-now-available-in-docker-desktop-stable-channel/) ships with a bundled Kubernetes offering.
The Kubernetes version it supports is tightly coupled with the Docker version. The current version (2.2.0.5) supports Kubernetes version 1.15.5.
I have not found a programmatic way to create and destroy a new Kubernetes cluster. 
It can only be done using the Docker desktop app preferences.

[Kind](https://kind.sigs.k8s.io) - Kubernetes IN Docker - is a tool for running local Kubernetes clusters using Docker containers as nodes.
It is an [Open Source](https://github.com/kubernetes-sigs/kind) project managed by the Kubernetes Community and was primarily designed for testing Kubernetes itself.
Kind supports multi-node (including HA) clusters and is optimized for CI pipelines. 

[Minikube](https://minikube.sigs.k8s.io/docs/) sets up a local single node Kubernetes cluster using a VM.
It is another [Open Source](https://github.com/kubernetes/minikube) project managed by the Kubernetes Community and was designed to make it simple to run Kubernetes locally, for day-to-day development workflows and learning purposes.
Minikube supports multiple container runtimes and advanced features such as Load Balancer, filesystem mounts, and Feature Gates.

[K3d](https://k3d.io) is a lightweight wrapper to run [k3s](https://k3s.io) (Rancher Lab’s minified Kubernetes distribution) in docker.
By removing dispensable features (legacy, alpha, non-default, in-tree plugins) and using lightweight components (e.g. sqlite3 instead of etcd3) Rancher Labs created an ultra small Kubernetes distribution built for IoT and Edge computing. It supports ARMv7 and ARM64 architectures, making it possible to run a Kubernetes cluster on a set of Raspberry Pis.

Other potential alternatives like [Microk8s](https://microk8s.io), [Kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/), [Kubespray](https://kubespray.io) and [Kops](https://kops.sigs.k8s.io) where discarded, either because they are not Cross Platform or are geared towards production environments.
  

### How do they compare?

The following table lists the alternatives along with some of their characteristics:
* Nodes: The number of cluster nodes supported
* CLI: Command Line Interface for installation and configuration
* Multiple: Supports multiple clusters on a single machine
* Versions: Support for different Kubernetes versions
* Features: Support for Kubernetes features
* Resources: Resource usage when compare to each other
* Pauseable: Cluster can be stopped and restarted


|           | Nodes | CLI   | Multiple | Versions | Features | Resources | Pauseable |
|---------- | ----- | ----- | -------- | -------- | -------- | --------- | --------- | 
| Minikube  |  1    |  Yes  | Yes      | High     | Highest  | High      | Yes       |
| Kind      |  n    |  Yes  | Yes      | High     | High     | Medium    | No        |
| K3d       |  n    |  No   | Yes      | Low      | Medium   | Low       | No        |
| Docker    |  1    |  No   | No       | Single   | High     | Medium    | No        |


### Conclusion

This exercise provided me with some interesting insights.

I discard the Docker Desktop version, mainly because it only supports a single Kubernetes version and I have not found a way to programmatically create, configure and destroy the cluster.

[k3s](https://k3s.io) has gotten my attention. Especially the idea of running a Kubernetes cluster on a set of Raspberry PIs definitely made it on my wish list.

For my development environment, I am tending towards using something that is managed by the Kubernetes Community. 
They have done an awesome job with Kubernetes, and I expect less hassle using either Kind or Minikube.

For now, I'll get started with Minikube, as it promises the best support for my development workflows.
I will detail my setup and learnings in a follow up post.
At a later state, I may also add Kind to the mix to experiment with certain failure scenarios.

And when the time comes to develop solutions targeting IoT and Edge computing I can use K3d to test on my local environment.

Check [here](https://github.com/cncf/k8s-conformance) for a list of certified Kubernetes offerings and [here](https://docs.google.com/spreadsheets/d/1LxSqBzjOxfGx3cmtZ4EbB_BGCxT_wlxW_xgHVVa23es/edit#gid=0) for the details on which Kubernetes versions are supported.

If you feel like I have missed something, or do not agree with my conclusions, please leave a note!

