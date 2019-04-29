---
layout: post
title: Master Branch Development Installation
date:  2019-04-25 11:12:11 -0700
description: Utilize `git remote add` with `root` level access to remote server to ensure testing environment and usage is similar documented examples
---

> These instructions use a `~/.ssh/confg` similar to the following...


```
Host server_admin
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User root
```


___


Within local terminal _`alpha`_ log-in to the remote server and issue the following...


```bash
ssh server_admin

mkdir -p ~/git/Jekyll_Admin
cd ~/git/Jekyll_Admin

git init .
git config receive.denyCurrentBranch updateInstead
```


Then within local terminal _`beta`_ change directories to where this project is `clone`d to and _whisper_ the following to add a new remote...


```bash
cd ~/github/Jekyll_Admin

## Add a `dev` remote pointing to private server
git remote add dev server_admin:git/Jekyll_Admin

## Track changes within a local branch
git checkout -b local_master

## Push local branch to private server
git push --force dev local_master:master
```

> Note, the _`git push`**` --force `**`<remote> <local_branch>:<remote_branch>`_ is usually only necessary the first time around, future _`push`es_ could look like _`git push dev local_master:master`_


Within the _`alpha`_ terminal utilize the [_`make install`_][docs_install] command option to install (symbolically link) project scripts. Any future `git push dev local_master:master` _should_ update the linked to scripts for; [adding _`Git`_/_`Jekyll`_][docs_jekyll_usermod] users, adding _dev_ groups to [DNS configurations][docs_jekyll_dnsconf], and updating [Web Server][docs_jekyll_wwwconf] configurations with new project documentation paths.


If adding new scripts then update the `SCRIPT_NAMES_TO_LINK` variable within the [`Makefile`][source_makefile] (around line nine) then use [`make update`][docs_updating] within the _`alpha`_ terminal to update links.


Once local changes are bug-free see [`git merge local_master`][docs_merge] examples, and [Pull Request][docs_pull_request] tips.


[docs_install]: /administration/installation.html
[docs_updating]: /administration/updating.html
[docs_jekyll_usermod]: /administration/jekyll_usermod.html
[docs_jekyll_dnsconf]: /administration/jekyll_dnsconf.html
[docs_jekyll_wwwconf]: /administration/jekyll_wwwconf.html

[docs_merge]: /contributing/merge.html
[docs_pull_request]: /contributing/pull_request.html

[source_makefile]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/Makefile
