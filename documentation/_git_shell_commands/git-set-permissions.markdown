---
layout: post
title:  Git Set Permissions
date:   2019-04-28 11:12:18 -0700
categories: git_shell_commands
description: The `git-set-permissions` client script designed to _refresh_ permissions for named repository
---


Hopefully there is never a need for using the [`git-set-permissions`][source_master__git-set-permissions] script directly, but supposing somehow _`Bill`'s_ shared `Ideas` repository had it's permissions get a little messy, they could try...


```bash
ssh Bill git-set-permissions Ideas
```


... before bothering one of the administrators for an assist.


As of the latest revision this script will set `750` for all directories and `640` for all files under the named repository, in this example's case; `/srv/Bill/git/Ideas`


[source_master__git-set-permissions]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/git-set-permissions
