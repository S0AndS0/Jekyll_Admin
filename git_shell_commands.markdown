---
layout:    modules/collection-home/collection-home
title:     Git Shell Commands
permalink: /git_shell_commands/
collection_name: git_shell_commands
date: 2019-04-22 11:12:15 -0700
list_title: Usage Examples
# description:
---

For this collection of examples, assume that _`Git`_/_`Jekyll`_ users _`Ted`_ and _`Bill`_ have the following configuration blocks within their local `~/.ssh/config` files...


### _`Bill`'s_ `~/.ssh/config` file


```
Host bill
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName devs.lan
    User Bill
```


### _`Ted`'s_ `~/.ssh/config` file


```
Host ted
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName devs.lan
    User Ted
```


... where _`~/.ssh/private.key`_ is the file path their respective private key for authenticating to the server that _`Joanna`_ and _`Elizabeth`_ have setup.


The above configurations enables terse `git-shell-commands` such as...


```bash
ssh bill list git-shell-commands
```
