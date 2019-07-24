---
layout: post
title: WWW Set Permissions
date:   2019-05-04 11:12:24 -0700
categories: git-shell-commands
description: The `www-set-permissions` client script resets static file permissions for named repository under `${HOME}/www`
---


Much like the [`git-set-permissions`][docs_git_set_permissions], the [`www-set-permissions`][source_master__www-set-permissions] should __not__ be needed on a regular basis, however, supposing that _`Ted`_ wanted to _revive_ the shared `Ideas` repository, got so far as [`jekyll-build`][docs_jekyll_build], but somehow permissions got messed up; they could issue...


```bash
ssh Ted www-set-permissions Ideas
```


... to try and resolve things before asking for administrator aid.


[source_master__www-set-permissions]: https://github.com/git-utilities/git-shell-commands/blob/master/www-set-permissions

[docs_git_set_permissions]: /Jekyll_Admin/git-shell-commands/git-set-permissions/
[docs_jekyll_build]: /Jekyll_Admin/git-shell-commands/jekyll-build/
