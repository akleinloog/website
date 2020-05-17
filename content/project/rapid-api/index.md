---
title: Rapid API
summary: Rapid API prototyping of RESTful and GraphQL based APIs.
tags:
- Open Source
- API
- REST
- GraphQL
- Prototyping
- strapi
date: "2020-05-16T00:00:00Z"

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

url_code: "https://github.com/akleinloog/rapid-api"
url_pdf: ""
url_slides: ""
url_video: ""

slides: ""
---

This goal of this project is to come up with an approach for rapid prototyping of APIs that support both REST and GraphQL.

## The What

A containerized starting point that can be used to quickly implement a prototype of an API, customize it as needed, and easily add initial content.

My main requirements:
* Support for RESTful APIs
* Support for GraphQL APIs
* Easily modify the API and add initial content
* Free of costs (no licence fees)

Additional nice to haves:
* Support for Webhooks
* Support for Authentication
* Support for Open API documentation


## The Why

Every now and then I find myself in a situation where I need to quickly create a prototype of an API.
This often happens when exploring a design for a new Microservice, especially when that Microservice depends on other services.

In order to properly allocate responsibilities and design the interactions between these Microservice, I often find it useful to create some working prototypes of the dependent Microservices.

Being able to do so quickly, while having a rich feature set at the same time, enables me to apply a **show me** approach to software architecture, which I find far more interesting and effective, and therefore more valuable, than the more common diagrams-based **tell me** approach.

## The How

The [strapi](https://strapi.io/) project was initially created to boot**strap** **API**s. Even though it is now advertised as a Headless CMS, from what I have seen, it could be a very good fit for what I need.

Based on strapi, I will create a docker image that is pre-configured and ready to use. In the process, I will tailor the image to my needs and in addition, set up an automated build that pushes new versions of that image to [docker hub](https://hub.docker.com).
This is something that I never did, so a good opportunity to learn.

## The Results

I just started this project, so there are no results to share just yet.
I will detail the progress in a series of blog posts and update this section when the results are available.

In the end, my solution will be publicly available on GitHub and on Docker, for you to use freely, to learn from, and hopefully, to provide some feedback on!