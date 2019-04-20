---
layout: post
title: Repository Remove
date:   2019-04-19 11:12:22 -0700
categories: git_shell_commands
excerpt: >-
  > The `repo-remove` client script removes named repository from `${HOME}/git`
---


Careful with the [`repo-remove`][source_master__repo-remove] script! If for instance _`Bill`_ ran this script on their `Ideas` repository, then _`Ted`_ would no longer be able to push to their shared repository, eg...


```bash
ssh Bill repo-remove Ideas
```


... would remove the named repository's source files and `.git` directory from the server.


[source_master__repo-remove]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/git_shell_commands/repo-remove
