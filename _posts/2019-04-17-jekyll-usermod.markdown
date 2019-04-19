---
layout: post
title: Jekyll User Modifier
date:   2019-04-17 11:12:13 -0700
categories: admin
excerpt: >
  > The `jekyll_usermod.sh` administration script is intended for adding new `Git`/`Jekyll` users to a private server.
---

By default new users are __not__ allowed to `clone` and/or `push` to their respective [`git-shell-commands/`][git-shell-commands_source] directories, but this may change in future revisions.


Available options may be listed via `jekyll_usermod.sh --help`, note [source][jekyll-usermod_source] is also available for auditing prior to issuing a `git clone`.

___


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


If at a later point a new user by the name of _`Ted`_ who is also apart of the `devs` group needs to be added, it may look similar to...


```bash
sudo jekyll_usermod.sh\
 --user="Ted"\
 --group="devs"\
 --ssh-auth-keys="/path-to-teds/pub.key"\
 --help
```

[git-shell-commands_source]: https://github.com/S0AndS0/Jekyll_Admin/tree/master/git_shell_commands
[jekyll-usermod_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_usermod.sh
