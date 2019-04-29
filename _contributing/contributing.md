---
layout: collections/home
collection_name: contributing
title: Contributing
list_title: Advanced Setup Examples
permalink: /contributing/
description: How to add to code base or documentation of this project
---

For this collection of examples, assume that administrators _`Joanna`_ and _`Elizabeth`_ have the following configuration blocks within their local `~/.ssh/config` files...


### _`Elizabeth`'s_ `~/.ssh/config` file


```
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


### _`Joanna`'s_ `~/.ssh/config` file


```
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
