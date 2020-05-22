---
title: HTTP Logger
summary: A simple HTTP Logger that logs all requests, written in Go.
tags:
- Go
- Docker
date: "2020-05-22T00:00:00Z"

# Optional external URL for project (replaces project detail page).
external_link: ""

image:
  caption: ""
  focal_point: Smart

links:
#- icon: twitter
#  icon_pack: fab
#  name: Follow
#  url: https://twitter.com/georgecushen

url_code: "https://github.com/akleinloog/http-logger"
url_pdf: ""
url_slides: ""
url_video: ""

slides: ""
---

This goal of this project is to create a simple HTTP Logger in Go, that logs all incoming HTTP requests in a structured way.

## The What

A Simple HTTP Logger that can be configured to run on any port.

My main requirements:
* Log HTTP GET, POST, PUT and other methods to stdout
* Always return 200 OK as response
* Structured logging in JSON format
* Log Host, URL, Method, IP addresses, request body and more
* Containerized, lightweight, easily usable in different environments

Additional nice to haves:
* Enforce SSL with redirect and correct certificates
* Easy configuration (flags, environment settings, config files)
* Easy way to access request body


## The Why

The HTTP Logger can be used to gain some insights into HTTP traffic, for example, when you want to test if a webhook is properly sending messages, and what the content of these messages is.  

In addition, it is a perfectly small Microservice, ideally suited to learn some Go development practices that could be suited for other Microservices too.

## The How

The HTTP Logger will be implemented using Go, a language that I am not yet familiar with, but really want to learn.
And for me, the best way to learn after some basic tutorials is to put things into practice.

In order to learn a bit more about Go, I will pay attention to:
* Structured Logging (stdout in JSON)
* Flexible Configuration (Support for Flags, Environment, Config file, etx)
* Proper CLI support

## The Results

I just started this project, so there are no results to share just yet.
I will detail the progress in a series of blog posts and update this section when the HTTP Logger is available.

In the end, my solution will be publicly available on GitHub and on Docker, for you to use freely, to learn from, and hopefully, to provide some feedback on!