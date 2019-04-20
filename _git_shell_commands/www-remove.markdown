---
layout: post
title: WWW Remove
date:   2019-04-19 11:12:23 -0700
categories: git_shell_commands
excerpt: >-
  > The `www-remove` client script removes named repository's static files from `${HOME}/www`
---


The [`www-remove`][source_master__www-remove] script should only need to be run for _cleaning-up_ after removing a repository with `repo-remove`.


For example  _`Bill`'s_ static site files for their shared `Ideas` could be cleaned-up with...


```bash
ssh Bill www-remove Ideas
```


... which would remove all files and directories from `/srv/Bill/www/Ideas`


[source_master__www-remove]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/www-remove
