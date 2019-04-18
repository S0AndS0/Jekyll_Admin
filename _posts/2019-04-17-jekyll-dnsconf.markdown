---
layout: post
title: Jekyll DNS Configurer
date:   2019-04-17 11:12:14 -0700
categories: admin
---

> This script is designed to be useful when a new user is added.


Available options listed via `jekyll_dnsconf.sh --help`, currently _wired_ for `Unbound` DNS (Domain Name Server)


Example of adding `ted` who is apart of the `devs` group to the `.lan` top level domain.


```bash
sudo jekyll_dnsconf.sh\
 --user="ted"\
 --group="devs"\
 --tld="lan"\
 --interface='eth0'\
 --clobber="yes"\
 --help
```


Which will setup the following configurations...


```
server:
    private-domain: "devs.lan."
    local-zone: "devs.lan." static
#
# Then append the following to: ${_dns_conf_path}
#
    local-data: "ted.devs.lan.      IN A    ipv4-or-6-addr"
    local-data-ptr: "ipv4-or-6-addr    ted.devs.lan."

```


... within the `/etc/unbound/unbound.conf.d/devs.lan.conf` file.
