---
layout: post
title:  Updating
date:   2019-04-21 11:12:12 -0700
description: The following instructions are relevant only after following `Install` instructions for this project
---


For the sake of an example, let's suppose that _`Elizabeth`_ spots that there was a meaningful update to this project.


Assuming _`Elizabeth`'s_ local `~/.ssh/config` looks similar to...


```
Host liz
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User liz
```


Logging-in would look something like...


```bash
ssh liz
```


Elevating to root user account, regardless, would be nearly identical to...


```bash
sudo su -
```


Then changing directories to the directory that this project was `clone`d to could sorta be...


```bash
cd /usr/local/etc/Jekyll_Admin
```


And updating via `make` would be as easy as...


```bash
make update && make install
```


> Note see the [`Makefile`][makefile_source] sourced code for what the above `make` command entails


Exiting root level permissions would most defiantly, probably, look like...


```bash
exit
```


> Note, updating via `make` will automatically commit any changes to the local `git` branch checked-out during [`make install`][docs_install] prior to changing branches to `master` and `pull`ing in any new updates. After which the local branch is checked-out, `master` branch changes are merged, and scripts are re-linked.
>
> End result of _merging madness_ is that local changes should not be lost, permanently, though there may be occasions for `conflicts` of the _`Git`_ verity.


And that would the extent of what _should_ be needed to update administration scripts, however, updating preexisting user account `git-shell-commands` scripts is still a _bit_ more involved.



[docs_install]: /Jekyll_Admin/administration/installation/

[makefile_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/Makefile
