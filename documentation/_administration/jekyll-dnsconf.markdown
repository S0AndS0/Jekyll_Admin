---
layout: post
title:  Jekyll DNS Configurer
date:   2019-04-19 11:12:14 -0700
description: The `jekyll_dnsconf.sh` administration script adds a _`Git`_/_`Jekyll`_ user to DNS configurations
---

Available options may be listed via `jekyll_dnsconf.sh --help`, currently _wired_ for `Unbound` DNS (Domain Name Server); script [source][jekyll-dnsconf_source] is also available for auditing prior to issuing a `git clone`.


Supposing that the Administrators want _`Bill`_ and _`Ted`_ to share the `devs` domain name for the private server, _`Joanna`_could conger DNS configurations via...


```bash
ssh joan sudo jekyll_dnsconf.sh\
 --domain="devs"\
 --tld="lan"\
 --interface='eth0'\
 --clobber="yes"\
 --help
```


Which without the `--help` option, will setup the following configurations...


```
server:
    private-domain: "devs.lan."
    local-zone: "devs.lan." static
    local-data: "devs.lan.      IN A    192.168.0.5"
    local-data-ptr: "192.168.0.5    devs.lan."
```


... within the `/etc/unbound/unbound.conf.d/devs.lan.conf` file.


------


Latter by invoking the following, _`Elizabeth`_ could add an `admins` domain hosted even more privately from the server's `vpn0` interface, to collaborate with _`Joanna`_...


```bash
ssh liz sudo jekyll_dnsconf.sh\
 --group="admins"\
 --tld="lan"\
 --interface='vpn0'\
 --clobber="yes"\
 --help
```


... at which point an `/etc/unbound/unbound.conf.d/admins.lan.conf` file would start looking like...


```
server:
    private-domain: "admins.lan."
    local-zone: "admins.lan." static
    local-data: "admins.lan.      IN A    10.8.0.2"
    local-data-ptr: "10.8.0.2    admins.lan."
```



[jekyll-dnsconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
