---
layout: post
title: Jekyll User Modifier
date:   2019-04-17 11:12:13 -0700
categories: admin
---

> This script is designed to be useful when a new user is added.
>
> By default new users are __not__ allowed to `clone` and/or `push` to their respective `git-shell-commands/` directories, but this may change in future revisions.


Available options listed via `jekyll_usermod.sh --help`


Example of creating a new user named _`Bill`_ with home directory under `/srv`


```bash
sudo jekyll_usermod.sh\
 --user="Bill"\
 --group="devs"\
 --ssh-auth-keys="/path-to-bills/pub.key"\
 --help
```


Assuming that _`Bill`_ has the following configurations within their local `.ssh/config`...


```
Host private-git
   HostName <host-or-IP-goes-here>
   User Bill
   IdentitiesOnly yes
   IdentityFile ~/.ssh/private-git-key
```

_`Bill`_ may now list the available `git-commands` via...


```bash
ssh private-git list --help
```


Which may output something like...


```
-rwxr-xr-x 1 Bill devs ... bundle-install
-rwxr-xr-x 1 Bill devs ... bundle-update
-rwxr-xr-x 1 Bill devs ... copy-theme
-rwxr-xr-x 1 Bill devs ... edit-configs
-rwxr-xr-x 1 Bill devs ... git-init
-rwxr-xr-x 1 Bill devs ... git-set-permissions
-rwxr-xr-x 1 Bill devs ... jekyll-build
-rwxr-xr-x 1 Bill devs ... jekyll-init
-rwxr-xr-x 1 Bill devs ... list
-rwxr-xr-x 1 Bill devs ... repo-remove
drwxr-xr-x 2 Bill devs ... shared_functions
-rwxr-xr-x 1 Bill devs ... www-remove
-rwxr-xr-x 1 Bill devs ... www-set-permissions
```


-------


If at a latter point a new user by the name of _`Ted`_ who is also apart of the `devs` group needs to be added, it may look similar to...


```bash
sudo jekyll_usermod.sh\
 --user="Ted"\
 --group="devs"\
 --ssh-auth-keys="/path-to-teds/pub.key"\
 --help
```
