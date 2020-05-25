---
title: 'Go Docker'
subtitle: 'How to containerize a Go service'
summary: How to containerize a Go service.
authors:
- admin
tags:
- Go
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

The [HTTP Logger](/project/http-logger) needs to be containerized so it can be easily distributed and used in different environments.

This post details how this can be done for a Go service, using the HTTP Logger as an example.

### Dockerfile

In order to produce a clean image, we use a [multi-stage](https://docs.docker.com/develop/develop-images/multistage-build/) Dockerfile.

The complete Dockerfile:
```R
# Build Stage
FROM golang:1.14.3-alpine3.11 AS builder
RUN apk add git
WORKDIR /go/src/http-logger
ADD ./ .
RUN CGO_ENABLED=0 go build -o httplog.exe

# Deploy Stage
FROM scratch
LABEL maintainer="arnoud@kleinloog.ch"
COPY --from=builder /go/src/http-logger/httplog.exe .
EXPOSE 80
CMD ["./httplog.exe",  "serve"]
```

### .env


### .dockerignore



### docker-compose.yaml




Beginners Guide:
https://stackify.com/docker-build-a-beginners-guide-to-building-docker-images/

