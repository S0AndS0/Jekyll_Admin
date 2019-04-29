---
layout: collections/home
collection_name: git_shell_commands
title: Git Shell Commands
list_title: Usage Examples
permalink: /git_shell_commands/
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
