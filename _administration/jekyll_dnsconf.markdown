---
layout: post
title: Jekyll DNS Configurer
date:   2019-04-17 11:12:14 -0700
categories: admin
description: The `jekyll_dnsconf.sh` administration script adds a _`Git`_/_`Jekyll`_ user to DNS configurations
---

Available options may be listed via `jekyll_dnsconf.sh --help`, currently _wired_ for `Unbound` DNS (Domain Name Server); [source][jekyll-dnsconf_source] is also available for auditing prior to issuing a `git clone`.


Supposing that _`Elizabeth`_ is tasked with adding _`Ted`_, who is apart of the `devs` group, to the `.lan` top level domain...


```bash
ssh liz sudo jekyll_dnsconf.sh\
 --user="Ted"\
 --group="devs"\
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
    local-data: "ted.devs.lan.      IN A    ipv4-or-6-addr"
    local-data-ptr: "ipv4-or-6-addr    ted.devs.lan."
```


... within the `/etc/unbound/unbound.conf.d/devs.lan.conf` file.


------


And _`Joanna`_ could add _`Bill`_ similarly with...


```bash
ssh joan sudo jekyll_dnsconf.sh\
 --user="Bill"\
 --group="devs"\
 --tld="lan"\
 --interface='eth0'\
 --clobber="yes"\
 --help
```


... at which point the `/etc/unbound/unbound.conf.d/devs.lan.conf` file would start looking like...


```
server:
    private-domain: "devs.lan."
    local-zone: "devs.lan." static
    local-data: "ted.devs.lan.      IN A    ipv4-or-6-addr"
    local-data-ptr: "ipv4-or-6-addr    ted.devs.lan."
    local-data: "bill.devs.lan.      IN A    ipv4-or-6-addr"
    local-data-ptr: "ipv4-or-6-addr    bill.devs.lan."
```


[jekyll-dnsconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
