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

The next step is to configure the base URL of your site, in _config.toml_ in _/config/_default_. If you used a custom domain:
```r 
# The URL of your site.
baseurl = "https://www.yourdomain.com/"
``` 
Otherwise, use your GitHub Pages URL:
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

Of course I realize that, as is the case with most 'free service' offerings, I am being part of the product here. Google will use all information they get in ways they see fit. Since what I am doing here is 'out in the open' and dedicated to the public domain, I figured it would make a good opportunity to learn more about these Google services, and I appreciate that the collected information (or at least some of it) is shared with me as well.

## Commenting with Disqus

Enabling others to comment on your site turns it into an interactive site and is relatively easy to do.
First go to https://disqus.com and sign up. I selected the basic, free package. Then open _params.toml_ in your _config/_default_ directory and fill in the comments section to enable commenting:
```r
############################
## Comments
############################
[comments]
...
  engine = 1

...
  [comments.disqus]
    shortname = "<shortname>" # Paste the shortname from your Disqus dashboard
``` 

When you run the site locally, the commenting section won't be enabled, but you should see a warning like
_"Disqus comments not available by default when the website is previewed locally."_ at the bottom of your posts.

Deploy your website to production and see how it works!

## Contact Page

Adding a simple contact page can be done with Academic's [contact widget](https://sourcethemes.com/academic/docs/page-builder/#contact).

For this side, I decided to add it to the bottom of the about page, and in addition, add a top-level menu and a link from my profile.

To add a top level menu, open _config/_default/menus.toml_ and add:
```r 
[[main]]
  name = "Contact"
  url = "about/#contact"
  weight = 50
``` 

In _config/_default/params.toml_, make sure that an email address is configured.


To add a link from your profile, open _authors/admin/_index.md_ and add this to the social section:
```r
- icon: envelope
  icon_pack: fas
  link: 'about/#contact'
``` 

To add the contact form itself, in the _content/about/_ folder, add contact.md with the following content:

```r
+++
# Contact widget.
widget = "contact"
headless = true
active = true
weight = 50

title = "Contact"
subtitle = ""

# Automatically link email and phone?
autolink = true

# Email form provider
#   0: Disable email form
#   1: Netlify (requires that the site is hosted by Netlify)
#   2: formspree.io
email_form = 2
+++
``` 

This sets up your site to use [Formspree](https://formspree.io/) to email you the request.
After deploying to production, simply fill in the form once and you will receive an email to complete your registration.
Their free plan gives you a limited amount of monthly submissions.

The contact widget can be further customized by providing additional information in your _params.toml_, see the [docs](https://sourcethemes.com/academic/docs/page-builder/#contact) for more detail.


