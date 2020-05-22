---
title: 'Rapid API - Getting Started'
subtitle: 'Rapid API prototyping with strapi'
summary: Getting started with rapid API prototyping using strapi.
authors:
- admin
tags:
- API
- Prototyping
- strapi
date: "2020-05-18T00:00:00Z"
lastmod: "2020-05-18T00:00:00Z"
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
projects: ["rapid-api"]
---

The goal of the [Rapid API project](/rapid-api) is to create a containerized starting point that can be used to quickly implement a prototype of an API, customize it as needed, and easily add initial content.

## Preparation

To get started, create a new GitHub repository, initialized it with a README and a license, and clone it to your local machine.

## Docker

Add a _docker-compose.yaml_ file with the following content:

```R
version: '3.7'
services:
  dev-api:
    container_name: dev-api
    build: ./docker/dev
    volumes:
      - ./src:/app
    ports:
      - '8080:8080'
```

In addition, create a _src_ folder that will contain your API's source code. As you can see, it is mapped to the _app_ folder inside the my-api container.

Then add a _docker_ folder with a _dev_ folder (we'll be adding more later). There, create a _Dockerfile_ with the following content:
```R
FROM node:13.14.0-alpine3.11

RUN apk update 
RUN apk upgrade

WORKDIR /app
VOLUME /app

EXPOSE 1337

COPY entrypoint.sh /usr/local/bin/

RUN chmod 755 "/usr/local/bin/entrypoint.sh"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
```

As you can see, we are using the latest Node JS 13 version. At the time of writing, Node JS 14 has already been released, but not all of our dependencies are available yet.

## Entrypoint

Next to the _Dockerfile_ in the _dev_ folder, add an _entrypoint.sh_ file with the following content:
```R
#!/bin/sh

# exit when any command fails
set -e

if [ -f package.json ]; then

    echo "Starting existing strapi instance"

    if [ -d node_modules ]; then

        echo "Using existing dependencies"

    else 

        echo "Installing dependencies"

        npm install

    fi

    npm run strapi develop --watch-admin

else 

    echo "Initializing new strapi instance"

    npx create-strapi-app . --quickstart --no-run

    echo "Installing dependencies"

    npm install

    echo "Initializing Open API"

    npm run strapi install documentation

    echo "Initializing GraphQL"

    npm run strapi install graphql

    echo "Starting strapi"

    npm run strapi develop --watch-admin
fi
```

As you can see, this script behaves differently depending on the scenario.

On the first run, no strapi project has been initialized and therefore, no _package.json_ exists.
The script will then initialize the strapi project and install its dependencies and the documentation and GraphQL plugins.
Once all installations are finished, the strapi project is started in development mode, with hot reload enabled.

On subsequent runs, the script checks if the _node_modules_ are present, and if not, it installs the dependencies. This is necessary in case you clone the repository to a different location later on. After that, the strapi project is started in the same way as in the first run.

if you ever want to recreate your strapi project from scratch, just delete and recreate the _src_ folder.

## First run

Startup the container for the first time.
```bash
docker-compose up
```

It will take a while before we are ready for the next steps. The base image needs to be downloaded, updates are installed, the strapi project is initialized and the documentation and GraphQL plugins are installed.

Once 

## Customizations


## Result

Check out my final [repository](https://github.com/akleinloog/rapid-api).