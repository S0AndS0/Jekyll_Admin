---
layout: post
title:  Bundle Install
date:   2019-04-23 11:12:14 -0700
categories: git_shell_commands
description: The `bundle-install` client script installs _`Gem`_ and _`Jekyll`_ dependencies for named repository
---


As an example let's suppose that _`Bill`_ has modified their `Excellent_Project`'s `_config.yml`, or `Gemfile`, configuration file(s) with new requirements or dependencies. _`Bill`_ could issue the following to the [`bundle-install`][source_master__bundle-install] script...


```bash
ssh Bill bundle-install Excellent_Project
```


... which'll update what's installed for that project's _`Jekyll`_ instance, and should allow for future [`jekyll-build`][post_jekyll-build] commands to run without errors related to missing dependencies.


[source_master__bundle-install]: https://github.com/git-utilities/git-shell-commands/blob/master/bundle-install
[post_jekyll-build]: /Jekyll_Admin/git_shell_commands/jekyll-build/
