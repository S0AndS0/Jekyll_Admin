---
layout: post
title: Jekyll Build
date:   2019-04-29 11:12:19 -0700
categories: git-shell-commands
description: The `jekyll-build` client script builds static site files for name repository under `${HOME}/www`
---


Supposing _`Ted`_ just made some additions to their `Radical_Features` documentation, and wants the private server to re-build static files, they might just utilize the [`jekyll-build`][source_master__jekyll-build] script with...


```bash
ssh Ted jekyll-build Radical_Features
```


... by default the above would output files ready for hosting with a Web Server under `/srv/Ted/www/Radical_Features`


[source_master__jekyll-build]: https://github.com/git-utilities/git-shell-commands/blob/master/jekyll-build
