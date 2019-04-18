---
layout: page
title: Update
permalink: /update/
---

Elevate to root user account


```bash
sudo su -
```


Change directories to installation parent directory


```bash
cd /usr/local/etc/jekyll_admin
```


Update via `make`


```bash
make update
```


Exit root level permissions


```bash
exit
```


> Note, updating via `make` will automatically commit any changes to the local
> `git` branch checked-out during `make install` prior to changing branches to
> `master` and `pull`ing in any new updates. After which the local branch is
> checked-out, `master` branch changes are merged, and scripts are re-linked.
