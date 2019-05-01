---
layout:    collections/home
title:     Administration
permalink: /administration/
collection_name: administration
date: 2019-04-17 11:12:11 -0700
list_title: Usage Examples
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
