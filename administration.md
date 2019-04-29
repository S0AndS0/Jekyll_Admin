---
layout: collections/home
collection_name: administration
title: Administration
list_title: Usage Examples
permalink: /admin/
description: Bash scripts for Jekyll/Git allowed users and server configuration modifications
---

For this collection of examples, assume that administrators _`Joanna`_ and _`Elizabeth`_ have the following configuration blocks within their local `~/.ssh/config` files...


### _`Elizabeth`'s_ `~/.ssh/config` file


```
Host liz
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User liz
```


### _`Joanna`'s_ `~/.ssh/config` file


```
Host joan
    IdentitiesOnly yes
    IdentityFile ~/.ssh/private.key
    HostName <ip-to-server>
    User joan
```


... where _`<ip-to-server>`_ is replaced with the IP address to the server that they are administrating.