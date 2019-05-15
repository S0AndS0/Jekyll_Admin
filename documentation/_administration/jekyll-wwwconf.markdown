---
layout: post
title:  Jekyll WWW Configurer
date:   2019-04-20 11:12:15 -0700
description: The `jekyll_wwwconf.sh` administration script adds a __new__ repository for given user to Web Server configurations
---

Available options may be listed via `jekyll_wwwconf.sh --help`, currently _wired_ for `Nginx` Web Server; script [source][jekyll-wwwconf_source] is also available for auditing prior to issuing a `git clone`.


For an example, _`Bill`_ has an `Excellent_Project` that they want to host on the private server; the administrator, _`Elizabeth`_, could issue the following...


```bash
ssh liz sudo jekyll_wwwconf.sh\
 --user='Bill'\
 --group='devs'\
 --interface='eth0'\
 --tld='lan'\
 --server='nginx'\
 --repo='Excellent_Project'\
 --help
```


... and perhaps not to be out-done _`Ted`_ may want to host `Radical_Features`, so they ask _`Joanna`_ to preform the following _incantations_...


```bash
ssh joan sudo jekyll_wwwconf.sh\
 --user='Ted'\
 --group='devs'\
 --interface='eth0'\
 --tld='lan'\
 --server='nginx'\
 --repo='Radical_Features'\
 --help
```


So long as both users have had the [`jekyll_dnsconf.sh`][docs_jekyll_dnsconf] script ran with similar options to those described in the related post, both _`Bill`_ and _`Ted`_ can check-out each-other's hosted documentation via `http://ted.devs.lan/Radical_Features` and `http://bill.devs.lan/Excellent_Project`



[docs_jekyll_dnsconf]: /Jekyll_Admin/administration/jekyll-dnsconf/
[jekyll-wwwconf_source]: https://github.com/S0AndS0/Jekyll_Admin/blob/master/jekyll_wwwconf.sh
