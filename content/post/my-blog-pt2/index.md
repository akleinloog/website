---
title: 'Setting up this Blog - Part 2'
subtitle: 'Enabling Google Analytics'
summary: How to add Google Analytics and google Google Search Console .
authors:
- admin
tags:
- Academic
- Hugo
date: "2020-05-09T00:00:00Z"
lastmod: "2020-05-09T00:00:00Z"
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

This is the second part in a series of posts detailing the set up of my personal blog. 
It details how to enable google analytics, commenting and a simple contact page.
See [part 1](/post/my-blog-pt1) for the basic setup.

## Enable Google Analytics

[Google Analytics](https://marketingplatform.google.com/about/analytics/) can provide you with some interesting insights on your site's visitors and the way they use your site. Enabling it on my personal blog provides a nice opportunity to learn a bit more about the possibilities it offers to site owners.

Lucky for me, it is a straight forward exercise. After signing up for google analytics and creating an account for your website, all you need to do is open your _params.toml_ in _/config/_default_ and add the account id:
```r
############################
## Marketing
############################
[marketing]
  google_analytics = "UA-***"
#  google_tag_manager = ""
``` 

I signed up for [Google Tag Manager](https://marketingplatform.google.com/about/tag-manager/) as well, and tried to activate it, but no luck so far. In order to get Google Analytics to work I had to comment out the _google_tag_manager_ entry. If I decide to take another look at this and get it to work, I'll detail it in a follow up post.

The next step is to configure the base URL of your site, in _config.toml_ in _/config/_default_:
```r 
# The URL of your site.
baseurl = "https://<username here>.github.io/"
``` 

The last change is an improvement to the deploy script we created in the previous post.
In _deploy.sh_ replace the following:
```bash
echo "Running Hugo Build"

hugo -t academic
``` 
with:
```bash
echo "Running Hugo Build"

env HUGO_ENV="production" hugo --gc --minify -t academic -b https://<username here>.github.io
``` 

Doing so will activate the Google Analytics scripts when the site is running in production. In addition, it also [instructs Hugo](https://gohugo.io/commands/hugo/) to run some cleanup tasks after the build and to minify the output, something I didn't pay attention to in my previous post. 

## Enable Google Search Console

Another thing I decided to add is [Google Search Console](https://search.google.com/search-console/about), another free-to-use service offered by Google that helps you monitor, maintain, and troubleshoot your site's presence in Google Search results. 

After using the 'URL prefix' method, my site ownership was automatically verified based on the Google Analytics account. I added an additional verification method by going to _Settings->Ownership Verification_, and selecting _HTML File_. Download the file, add it to your _/static_ folder and redeploy the site:
```bash
./deploy.sh
``` 

Of course I realize that, as is the case with most 'free service' offerings, I am being part of the product here. Google will use all information they get in ways the see fit. Since what I am doing here is 'out in the open' and dedicated to public domain, I figured it would make a good opportunity to learn more about these Google services, and I appreciate the information (or at least some of it) being shared with me as well.

## Next Step

The next step is to enable visitors to comment on posts with Discuss. I'll post part 3 when it is up and running...