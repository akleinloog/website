---
title: 'Setting up this Blog - Part 1'
subtitle: 'Get it up and running...'
summary: How to set up a simple blog using Hugo and GitHub Pages.
authors:
- admin
tags:
- Academic
- Hugo
date: "2020-05-06T00:00:00Z"
featured: false
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
projects: ["personal-blog"]
---

Welcome to the first in a series of posts that detail how I set up of this blog. It covers the basic steps needed to get started.

I use [Hugo](https://gohugo.io) as a static site generator and [Visual Studio Code](https://code.visualstudio.com) as editor. The resulting website is hosted using [GitHub Pages](https://pages.github.com/). A nice combination of open source tools with a free hosting provider that poses no restrictions in terms of traffic, size, etc.
Sounds like a perfect match to me.

Familiarity with git and the command line are assumed. I use a Mac, some of the commands may need to be translated to your environment.

## Getting started

Following this [Hugo tutorial](https://gohugo.io/hosting-and-deployment/hosting-on-github/), I created two repositories on GitHub. 
One named _website_ for the [sources](https://github.com/akleinloog/website), and another one for the [generated website](https://github.com/akleinloog/akleinloog.github.io).

{{% callout note %}}
The name of the repository for the generated website has to be specific in order for it to be picked up by GitHub Pages.
In my case: **akleinloog.github.io**
{{% /callout %}}

I decided to dedicate both repositories to the public domain and therefore used the [UNLICENSE](https://choosealicense.com/licenses/unlicense/).
Feel free to use anything you find there as you see fit.

The next step is to clone the repository used for the source:
```bash
git clone git@github.com:<username here>/website.git
```
And open the project in Visual Studio Code:
```bash
cd website
code .
```

Add the following .gitignore file and optionally, save the code workspace:
```r
# MacOS Files
.DS_Store

# Hugo Working Folders
resources/
```

Install Hugo if not already installed:
```bash
brew install hugo
```

And initialize your repository for Hugo:
```bash
hugo new site . --force
```

## Select a theme

A good overview of available themes can be found [here](https://jamstackthemes.dev).
Select Hugo and order the themes by Stars gives you an overview of the most used themes.

I decided to try [Academic](https://wowchemy.com), a feature rich, open source theme developed by George Cushen and made available under the [MIT](https://choosealicense.com/licenses/mit/) license. Thanks George!

The Academic theme can be added using go modules.
Add a go.mod file with the following content:
```yaml
module github.com/wowchemy/starter-academic

go 1.15

require (
	github.com/wowchemy/wowchemy-hugo-modules/netlify-cms-academic v0.0.0-20210205224825-50d3d41e9e1a // indirect
	github.com/wowchemy/wowchemy-hugo-modules/wowchemy v0.0.0-20210205224825-50d3d41e9e1a
)
```
And a go.sum file with the following content:
```yaml
github.com/wowchemy/wowchemy-hugo-modules/netlify-cms-academic v0.0.0-20210205224825-50d3d41e9e1a h1:+YPB8FgVKzFGcT21RVBU345fARNYm6xOE/HXmr2D5J0=
github.com/wowchemy/wowchemy-hugo-modules/netlify-cms-academic v0.0.0-20210205224825-50d3d41e9e1a/go.mod h1:TU3QDPUdBSQnvDP5QVCwjAkBIdVMS/bKFA8jr3eI5AY=
github.com/wowchemy/wowchemy-hugo-modules/wowchemy v0.0.0-20210205224825-50d3d41e9e1a h1:BxOQUKnIoXDmsexnifhDJlw/xnCxojOYt2vpv2u9IfA=
github.com/wowchemy/wowchemy-hugo-modules/wowchemy v0.0.0-20210205224825-50d3d41e9e1a/go.mod h1:H22qfH9qj3FWwsk7+bAZpmT24yRGNQURah2/IRwjbn8=
```

Familiarize yourself with Academic, and [customize](https://wowchemy.com/docs/getting-started/customization/) it as you see fit.
A good way to do that, is to clone the [Academic Kickstart](https://github.com/wowchemy/starter-academic) project in a separate directory.
It provides a good demonstration of what the theme has to offer and can be helpful for troubleshooting.

## Add some content

First add the configuration files. You can copy the ones from the Academic Kickstart project to get started. Read through them and adjust as you see fit.

Also copy the _page_sharer.toml_ file in the _data_ folder to your local project.

Playing around with Academic's many widgets using the Kickstart project should give you a fair idea on what other content you want to add.
You can also have a look at my [sources repository](https://github.com/akleinloog/website) to see what I did for this blog.

## Try it out locally

Experiment with the configuration options and the structure. Run the site in development mode using:
```bash
hugo server
``` 
The site will be available at _http://localhost:1313_.
Whenever you save your changes, Hugo will react and automatically refresh the website, providing a very pleasant live-editing experience.


## Get ready to publish

Add the repository for the generated website as a git submodule:
```bash
git submodule add -b main git@github.com:<username here>/<username here>.github.io.git public
```

Doing so ensures that the HTML and JavaScript generated by Hugo will be placed in that repository.

First, we'll do a manual run. Generate your website:
```bash
hugo --gc
```

Test the generated output using the [serve package](https://www.npmjs.com/package/serve):
```bash
cd public 
npx serve
```

## Automate it

Add a file called deploy.sh to the sources repository's main folder. Ensure it is executable:
```bash
chmod +x deploy.sh
```

Add the following content to that file:
```bash
#!/bin/sh

set -e

echo "Cleaning Publish Folder"

rm -rf ./public/*

echo "Running Hugo Build"

env HUGO_ENV="production" hugo --gc --minify

cd public

echo "Adding changes to git"

git add .

msg="regenerating site content $(date)"

git commit -m "$msg"

echo "Pushing to main"

git push origin main

cd ..

echo "Deployment Finished"
```

This script uses Hugo to generate your website and commit the changes to the generated website repository.
By pushing these changes to GitHub, the script effectively deploys your website to production. Give it a try:
```
./deploy.sh
```

Navigate to your GitHub Pages URL to see the result!

## Add a custom domain name

Using a custom domain name for your GitHub pages is relatively straight forward.
First register a domain name and then configure the [DNS settings](https://kb.pressable.com/article/dns-record-types-explained/).

Create the following A records for your domain to point it to GitHub's servers:
```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```
Then add a CNAME record for www that points to the your GitHub site.

Then go to the GitHub repository settings of your generated site.
In the GitHub Pages section, enter the domain you've registered in the custom domain field, with the **www.** prefix, and save it.
This will trigger a check-in that adds a CNAME file with the domain that you have specified.

Keep in mind that may take some time for DNS changes to take effect, and for the SSL certificates to be generated.
Once completed, check the 'Enforce HTTPS' checkbox and the setup is completed. 

Your domain name will be forwarded to your **www.** and so will your GitHub pages and HTTPS will be automatically enforces, with valid a certificate for your URL, free of charge! 

See the GitHub Pages docs for [more information](https://help.github.com/en/github/working-with-github-pages/managing-a-custom-domain-for-your-github-pages-site) and [troubleshooting tips](https://help.github.com/en/github/working-with-github-pages/troubleshooting-custom-domains-and-github-pages).

## Update the source repository

The last thing to do, before making other modifications to your site, is to secure the CNAME file in your source repository so that it does not get deleted when the website is regenerated. First pull the changes:
```bash
cd public

git pull --all
```
This will update the local module and add the CNAME file. Now copy that file from the _public_ folder to the _static_ folder so it will be re-added when the site is regenerated. Commit and push your changes and you are good to go!


## Next Steps

I hope you may have learned something from this, as I did. In [Part 2](/post/my-blog-pt2) I will add support for Google Analytics, comments and a simple contact page.
