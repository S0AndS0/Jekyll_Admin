---
layout: post
title: Jekyll DNS Configurer
date:   2019-04-17 11:12:14 -0700
categories: admin
excerpt: >
  > The `jekyll_dnsconf.sh` administration script is designed for when a new _`Git`_/_`Jekyll`_ user is to be added to a private server.
---

Available options may be listed via `jekyll_dnsconf.sh --help`, currently _wired_ for `Unbound` DNS (Domain Name Server), and note [source][jekyll-dnsconf_source] is also available for auditing prior to issuing a `git clone`.


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


[jekyll-dnsconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_dnsconf.sh
