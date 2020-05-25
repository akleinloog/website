---
title: 'Building a docker image'
subtitle: 'How to build a docker image'
summary: How to build a docker images, manually, scripted and automated.
authors:
- admin
tags:
- Docker
date: "2020-05-23T00:00:00Z"
lastmod: "2020-05-23T00:00:00Z"
featured: false
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
projects: ["http-logger"]
---

The [HTTP Logger](/project/http-logger) is containerized so it can be easily distributed and used in different environments.
For this purpose, a Dockerfile was added.
(TODO)

This post details how to build the docker image using that Dockerfile, and how to publish it on docker hub, using the HTTP Logger as an example.

### Local Build

The Dockerfile is located in the _docker_ folder.

To build the image from the repository root:
```
docker build --force-rm -f ./docker/Dockerfile -t akleinloog/http-logger:latest -t akleinloog/http-logger:0.1.0 .
```

```
docker push akleinloog/http-logger:0.1.0

docker push akleinloog/http-logger:latest
```



https://docs.docker.com/engine/reference/commandline/build/