---
layout: post
title: Installation
date:   2019-04-17 11:12:11 -0700
categories: admin
description: This step is only needed once per server setup, see `Update` for updating pre-existing installs of this project
---


For example's sake, _`Joanna`_ a server administrator, decides that _`Bill`_ and _`Ted`_ should have _`Git`_/_`Jekyll`_ accounts for easy logging of their excellent adventures.


Assuming _`Joanna`'s_ local `~/.ssh/config` looks similar to...


```
Host joan
   HostName <host-or-IP-goes-here>
   User joan
   IdentitiesOnly yes
   IdentityFile ~/.ssh/joans-private-key
```


Logging-in would look something like...


```bash
ssh joan
```

... then elevating to root user account, regardless, would be...


```bash
sudo su -
```


And changing directories to a chosen installation parent directory could look like...


```bash
cd /usr/local/etc
```


... then a `git clone` of this project would be...


```bash
git clone git@github.com:S0AndS0/Jekyll_Admin.git
```


Changing directories (one more time), to project this project's directory would look somewhat like...


```bash
cd /usr/local/etc/Jekyll_Admin
```


Installing dependencies via `make`, note these `make` commands utilize the project's [`Makefile`][makefile_source] script, would most defiantly look like...


```bash
make install-dependencies
```


And finally installing (symbolically linking) scripts with would be...


```bash
make install
```


Exiting root level permissions could then look like...


```bash
exit
```


> Note, installing via `make` will automatically checkout a local git branch for tracking any local customizations.


Administrators such as _`Joanna`_ would then only have a few more steps to follow before unleashing imaginative clients like _`Bill`_ and _`Ted`_ on the private server.


Namely [`jekyll_usermod.sh`][post_jekyll_usermod] and [`jekyll_dnsconf.sh`][post_jekyll_dnsconf] scripts for every user, then repeated use of [`jekyll_wwwconf.sh`][post_jekyll_wwwconf] script for each repository that a user wishes to have static site files hosted.


[post_jekyll_dnsconf]: /Jekyll_Admin/administration/jekyll_dnsconf.html
[post_jekyll_usermod]: /Jekyll_Admin/administration/jekyll_usermod.html
[post_jekyll_wwwconf]: /Jekyll_Admin/administration/jekyll_wwwconf.html

[makefile_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/Makefile
