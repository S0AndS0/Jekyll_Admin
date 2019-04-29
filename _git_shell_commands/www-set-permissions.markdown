---
layout: post
title: WWW Set Permissions
date:   2019-04-19 11:12:24 -0700
categories: git_shell_commands
description: The `www-set-permissions` client script resets static file permissions for named repository under `${HOME}/www`
---


Much like the [`git-set-permissions`][post_git-set-permissions], the [`www-set-permissions`][source_master__www-set-permissions] should __not__ be needed on a regular basis, however, supposing that _`Ted`_ wanted to _revive_ the shared `Ideas` repository, got so far as [`jekyll-build`][post_jekyll-build], but somehow permissions got messed up; they could issue...


```bash
ssh Ted www-set-permissions Ideas
```


... to try and resolve things before asking for administrator aid.


[source_master__www-set-permissions]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/www-set-permissions

[post_git-set-permissions]: /Jekyll_Admin/git_shell_commands/git-set-permissions.html
[post_jekyll-build]: /Jekyll_Admin/git_shell_commands/jekyll-build.html
