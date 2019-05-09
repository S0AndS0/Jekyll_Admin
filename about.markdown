---
layout: page
title: About
permalink: /about/
---

## ... the project


This project was born from the desire of an administrator wishing the following _meant something_...


```bash
ssh admin sudo jekyll_usermod.sh\
 --user="Bill"\
 --group="devs"\
 --ssh-pub-key="/path-to-bills/pub.key"\
 --help
```

... _like_, make a user named _`Bill`_ within the (possibly shared) _`devs`_ group.


Which would allow _`Bill`_ to do _something like_...


```bash
ssh Bill git-init Excellent_Project
```

... and have that mean something to the effect of, make a new repository under _`Bill`'s_ `${HOME}/git` directory ready for `git clone` and `git push` operations.


> In this case `/srv/Bill/git/Excellent_Project`. would be _`clone`able_ via...


```bash
git clone Bill:git/Excellent_Project
```


Feature-creep then had it's _marry way_ with the project, so to speak, and now there's many more _incantations_ that this project will respond to.


## ... this site's documentation


At it's core this site's documentation is built in large part thanks to the [Jekyll][jekyll-docs] teams' amazing work both with their projects and with fostering an astounding level of team-work within the community of Open Source developers. Other third party resources utilized in building this site are (but probably not limited to) the following unordered list.


> Note; if you believe you have contributed, or that your content or code has been used without citation, the fastest and easiest route is to [fork this repo][this-repo] and correct it with a `pull request` (see GitHub's [About pull requests][about-pull-requests] for general tips), second fastest would be to [Open an Issue][got-issues] to notify project maintainers of the error.


- [Minima][theme] _"is a one-size-fits-all Jekyll theme for writers."_
- [Liquid][liquid] _"is a template engine which was written with very specific requirements"..._


## ... privacy


Seems like every site has to address this somewhere these days, _quick-n-short of it_ is _`The Project's`_ maintainers at this point are __not__ interested in collecting or storing such things. GitHub and CDNs utilized to bring you this site are the only entities (that project maintainers are aware of) at all concerned with directly collecting your meta-data here.


[jekyll-docs]: https://jekyllrb.com/docs/home
[this-repo]: https://github.com/S0AndS0/Jekyll_Admin/
[got-issues]: https://github.com/S0AndS0/Jekyll_Admin/issues/
[theme]: https://github.com/jekyll/minima
[liquid]: https://github.com/Shopify/liquid
[about-pull-requests]: https://help.github.com/en/articles/about-pull-requests
