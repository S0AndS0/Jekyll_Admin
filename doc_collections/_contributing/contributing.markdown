---
layout:    collections/home
title:     Contributing
permalink: /contributing/
collection_name: contributing
date: 2019-04-24 11:12:11 -0700
list_title:  Advanced Setup Examples
description: How to add to code base or documentation of this project
---

> Please see [GitHub's Help on `Fork`ing][github_help_fork] if this is unfamiliar terminology


For this collection of examples, assume that administrators _`Joanna`_ and _`Elizabeth`_ have the following configuration blocks within their local `~/.ssh/config` files...


### _`Elizabeth`'s_ `~/.ssh/config` file


```
Host github.com
    IdentitiesOnly yes
    IdentityFile ~/.ssh/github_private.key
    HostName github.com
    User git

Host server_admin
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User root

Host liz
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User liz

Host git_liz
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User Elizabeth
```


------


### _`Joanna`'s_ `~/.ssh/config` file


```
Host github.com
    IdentitiesOnly yes
    IdentityFile ~/.ssh/github_private.key
    HostName github.com
    User git

Host joan
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User joan

Host git_joan
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User Joanna
```


... where _`<ip-to-server>`_ is replaced with the IP address to the server that they are administrating.


___


> Note, _`<GitHub-UserName>`_ in either of the following should be replaced by a [GitHub User Name][github_join] controlled by the respective life-form.


For the sake of an example, suppose that _`Elizabeth`_ has already `clone`d this project's source code prior [_`fork`ing_][fork_link], adding a new remote might look something like...


```bash
cd ~/github/Jekyll_Admin

git remote add fork https://github.com/<GitHub-UserName>/Jekyll_Admin.git
```


... now things like _`git push fork master`_ will mean something to _`Git`_


------


And where _`Joanna`_ to have already [_`fork`ed_][fork_link] and cloned from there, eg...


```bash
cd ~/github

git clone git@github.com:<GitHub-UserName>/Jekyll_Admin.git
```


... then adding an [_`upstream`_][github_help_upstream] remote for tracking this project's source during tests may look like...


```bash
cd ~/github/Jekyll_Admin

git remote add upstream https://github.com/S0AndS0/Jekyll_Admin.git
```

... which enables _`merging`ing_ from this project's source via...


```bash
git fetch upstream gh-pages:src_gh-pages

git checkout gh-pages
git merge src_gh-pages
```



[github_join]: https://github.com/join
[github_help_fork]: https://help.github.com/en/articles/fork-a-repo
[github_help_upstream]: https://help.github.com/en/articles/configuring-a-remote-for-a-fork

[fork_link]: https://github.com/S0AndS0/Jekyll_Admin/fork
[fork_list]: https://github.com/S0AndS0/Jekyll_Admin/network/members
