---
layout: page
title: Installation
permalink: /install/
---

> This step is only needed once per server setup, see [updating][update] for updating pre-existing installs of this project.


Elevate to root user account


```bash
sudo su -
```


Change directories to installation parent directory


```bash
cd /usr/local/etc
```


Clone project


```bash
git clone git@github.com:S0AndS0/Jekyll_Admin.git
```


Change directories to project directory


```bash
cd /usr/local/etc/jekyll_admin
```


Install dependencies via `make`


```bash
make install-dependencies
```


Install (symbolically link) scripts


```bash
make install
```


Exit root level permissions


```bash
exit
```


> Note, installing via `make` will automatically checkout a local git branch
> for tracking any local customizations.


[update]: {{ "/update/" | relative_url }}
