---
layout: post
title: List
date:   2019-05-01 11:12:21 -0700
categories: git-shell-commands
description: The `list` client script lists files and/or directory paths under `${HOME}`.
---


Nothing special, the [`list`][source_master__list] script is just a short cut to `ls -hl` for a given user's `${HOME}` or sub-directory there in, eg....


```bash
ssh Bill list www/Excellent_Project
```


... would list static site files for _`Bill`'s_ `Excellent_Project`. And...


```bash
ssh Ted list git/Radical_Features
```


... would list currently checked out files for _`Ted`'s_ `Radical_Features` `Git` repository.


[source_master__list]: https://github.com/git-utilities/git-shell-commands/blob/master/list
