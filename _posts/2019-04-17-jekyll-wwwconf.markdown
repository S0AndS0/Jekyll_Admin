---
layout: post
title: Jekyll WWW Configurer
date:   2019-04-17 11:12:15 -0700
categories: admin
---

> This script is designed to be useful when a user has made a new repository.


Available options listed via `jekyll_wwwconf.sh --help`, currently _wired_ for `Nginx` Web Server


For an example, _`Bill`_ has an `Excellent_Project` that they want to host on the private server; the administrator could issue the following...


```bash
sudo jekyll_wwwconf.sh\
 --user='Bill'\
 --group='devs'\
 --interface='eth0'\
 --tld='lan'\
 --server='nginx'\
 --repo='Excellent_Project'\
 --help
```


... and perhaps not to be out-done _`Ted`_ may want to host `Radical_Features`; to which the administrator could preform the following _incantations_...


```bash
sudo jekyll_wwwconf.sh\
 --user='Ted'\
 --group='devs'\
 --interface='eth0'\
 --tld='lan'\
 --server='nginx'\
 --repo='Radical_Features'\
 --help
```


So long as both users have had the [`jekyll_dnsconf.sh`][jekyll-dnsconf] script ran with similar options to those described in the related post, both _`Bill`_ and _`Ted`_ can check-out each-other's hosted documentation via `http://ted.devs.lan/Radical_Features` and `http://bill.devs.lan/Excellent_Project`


{% capture jekyll_dnsconf %}{%- post_url 2019-04-17-jekyll-dnsconf -%}{% endcapture %}
[jekyll-dnsconf]: {{ jekyll_dnsconf | relative_url }}
