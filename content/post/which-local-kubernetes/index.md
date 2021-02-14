---
title: 'Kubernetes on my machine. Great idea, but which one?'
subtitle: 'Which Kubernetes distribution will I use on my development PC?'
summary: What is the best way to run local Kubernetes clusters on my dev machine? A comparison of Docker vs Kind vs Minikube vs K3d vs MicroK8s.
authors:
- admin
tags:
- Kubernetes
- MicroK8s
- Minikube
- Kind
- K3s
- Docker
date: "2020-05-22T00:00:00Z"
featured: true
draft: false

image:
  placement: 2
  caption: ""
  focal_point: ""
  preview_only: false

projects: []
---

[Kubernetes](https://kubernetes.io) is the state-of-the-art when it comes to container orchestration.  
Built upon years of experience with production workloads at Google, it combines best-of-breed ideas and community practices.
Kubernetes is a classroom example of a successful open source project, drives vendor neutrality and runs basically everywhere.

Today, I see Kubernetes as the operating system of the Cloud Native world.
It is the base environment for my containerized applications, so I need to have it up and running locally on my development notebook.

Luckily there are several decent options. All I need to do is choose one.

### My Requirements

As always, choosing a solution works best if you understand your needs.
Since this is for my local development environment, my must haves are:
* Lightweight, tuns on my laptop
* Easy to install, configure and automate
* Wide support of Kubernetes versions and features
* Cross Platform, available for Mac, Windows and Linux

In addition, I would like to use the same solution on a development server to create a one node cluster.
Ideally, I should be able to use it with some Raspberry Pis to create a small cluster as well.
These are nice to haves though, using a different distribution for each purpose is an option too.

### The Alternatives

So far, I have identified the following solutions as promising:

[Docker Desktop](https://www.docker.com/blog/kubernetes-is-now-available-in-docker-desktop-stable-channel/) ships with a bundled Kubernetes offering.
The Kubernetes version it supports is tightly coupled with the Docker version. The current version (2.4.0.0) ships with Kubernetes version 1.18.8.
Since it comes with docker I don't need to install anything. At the same time, I did not find an easy programmatic way to create and destroy a new Kubernetes cluster.

[Kind](https://kind.sigs.k8s.io) - Kubernetes IN Docker - is a tool for running local Kubernetes clusters using Docker containers as nodes.
It is an [open source](https://github.com/kubernetes-sigs/kind) project managed by the Kubernetes Community and was primarily designed for testing Kubernetes itself.
Kind supports multi-node (including HA) clusters and is optimized for CI pipelines. 

[Minikube](https://minikube.sigs.k8s.io/docs/) sets up a local single node Kubernetes cluster using a VM.
It is another [open source](https://github.com/kubernetes/minikube) project managed by the Kubernetes Community and was designed to make it simple to run Kubernetes locally, for day-to-day development workflows and learning purposes.
Minikube supports multiple container runtimes and advanced features such as load balancer, filesystem mounts, and feature gates.

[K3d](https://k3d.io) is a lightweight wrapper to run [k3s](https://k3s.io), Rancher Lab’s minified Kubernetes distribution, in docker.
By removing dispensable features (legacy, alpha, non-default, in-tree plugins) and using lightweight components (e.g. sqlite3 instead of etcd3) Rancher Labs created an ultra small Kubernetes distribution built for IoT and Edge computing. It supports ARMv7 and ARM64 architectures, making it possible to run a Kubernetes cluster on a set of Raspberry Pis.

Last but not least, [MicroK8s](https://microk8s.io) is a production-grade Kubernetes distribution maintained by Canonical.
MicroK8s runs in an immutable container, comes with a range of sensible defaults to ease installation and configuration.
Networking, storage and standard services are supported out of the box and can be customized as needed.
It supports both ARM and Intel architectures, as well as single node and multi node deployments. 

Of course there are other potential alternatives like [Kubeadm](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/), [Kubespray](https://kubespray.io),  [Kops](https://kops.sigs.k8s.io) and more. I discarded these because they are not cross platform, require too much manual configuration or are rather geared towards production environments.

If you feel there is an alternative missing here, please leave a comment.
  

### How do they compare?

The following table lists the alternatives along with some of their characteristics:
* Nodes: The number of cluster nodes supported
* CLI: Supports automated installation and configuration
* Multiple: Supports multiple clusters on a single machine
* Versions: Support for different Kubernetes versions
* Features: Support for Kubernetes features
* Resources: Resource usage when compare to each other
* Pauseable: Cluster can be stopped and restarted


|           | Nodes | CLI   | Multiple | Versions | Features | Resources | Pauseable |
|---------- | ----- | ----- | -------- | -------- | -------- | --------- | --------- | 
| MicroK8s  |  n    |  Yes  | Yes      | Medium   | Highest  | Low       | Yes       |
| Minikube  |  1    |  Yes  | Yes      | High     | Highest  | High      | Yes       |
| Kind      |  n    |  Yes  | Yes      | High     | High     | Medium    | No        |
| K3d       |  n    |  No   | Yes      | Low      | Medium   | Low       | No        |
| Docker    |  1    |  No   | No       | Single   | High     | Medium    | Yes       |


### Conclusion

This exercise provided me with some interesting insights.

I won't be using the Docker Desktop version, mainly because it only supports a single Kubernetes version and I haven't found a way to programmatically create, configure and destroy the cluster.

Running a Kubernetes cluster on a set of Raspberry Pis is definitely something I want to spend some time on.
With two options to try out I can't wait to get started. I'll add a post as soon as I get to it.

Both Kind and Minikube are interesting options managed by the Kubernetes community.
They have done an awesome job with Kubernetes, so I expect these to be hassle free alternatives.
At first sight, Kind seems to be promising for automated tests in your CI/CD pipeline and Minikube seems to be the most feature rich for your desktop.

I took a deeper look at Minikube, see this [post](/post/minikube-kubernetes) for the details.
In addition, check this [post](/post/microk8s-kubernetes) to see how to quickly setup a MicroK8s cluster.

[Here](https://docs.google.com/spreadsheets/d/1LxSqBzjOxfGx3cmtZ4EbB_BGCxT_wlxW_xgHVVa23es/edit#gid=0) is an updated list of certified Kubernetes offerings and the versions they support, and [here](https://github.com/cncf/k8s-conformance) is more info on conformance.

If you see things differently, or feel like I missed something, please leave a comment!

