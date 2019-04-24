---
layout: post
title: Jekyll Initialize
date:   2019-04-19 11:12:20 -0700
categories: git_shell_commands
excerpt: >-
  The `jekyll-init` client script starts a new `git` repository with a `gh-pages` branch ready for `git clone`, `git push`, and `jekyll-build` operations
---


For an example let's say that _`Bill`_ wants to host an `Excellent_Project`'s documentation on the private server, with the [`jekyll-init`][source_master__jekyll-init] script they might do...


```bash
ssh Bill jekyll-init Excellent_Project
```


... then to `clone` their new repository _`Bill`_ would then be able to...

```bash
cd ~/git

git clone Bill:git/Excellent_Project --origin private-server

cd ~/git/Excellent_Project
```


... and have a grand time making edits locally before...


```bash
cd ~/git/Excellent_Project

git push private-server gh-pages
```


[source_master__jekyll-init]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/jekyll-init
