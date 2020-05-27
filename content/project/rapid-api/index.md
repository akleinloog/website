---
title: Rapid API
summary: Rapid API prototyping of RESTful and GraphQL based APIs.
tags:
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

In order to properly allocate responsibilities and design the interactions between these Microservice, I often find it useful to create some working prototypes of the Microservices I depend on.

Being able to do so quickly, while having a rich feature set at the same time, enables me to follow the **show me** approach to software architecture, which I find far more interesting and effective, and therefore more valuable, than the more common diagrams-based **tell me** approach.

## The How

The [strapi](https://strapi.io/) project was initially created to boot**strap** **API**s. Even though it is now advertised as a Headless CMS, from what I have seen, it could be a very good fit for what I need.

Based on strapi, I will create a docker image that is pre-configured and ready to use. In the process, I will tailor the image to my needs and in addition, set up an automated build that pushes new versions of that image to [docker hub](https://hub.docker.com).
This is something that I did not do before, so a good opportunity to learn.

## The Results

See [this post](/post/rapid-api-prototype) for a detailed description of the process and how to use it. 

The resulting container to get you going with rapid API prototyping is available on docker hub rapidand can be started as follows:

```r
docker run -p 8080:8080 akleinloog/rapid-api
```

The code is available in this [GitHub repository](https://github.com/akleinloog/rapid-api).

Use it freely, learn from it, and ideally, provide some feedback!