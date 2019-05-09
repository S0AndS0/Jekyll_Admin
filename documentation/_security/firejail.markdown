---
layout: post
title:  Firejail Notes
date:   2019-05-08 10:11:12 -0700
categories: security
description: Current state of issues related to using Firejail as a _between_ shell for other shells
---

Issues [1817][firejail-issue-1817], [887][firejail-issue-887] for Firejail shows a bit of the history of login shell options not working so great, in the case of `git` the following errors pop when Firejail is used as the _**between** shell_ and a user __with authorized access__ attempts to clone


```
    Cloning into 'test-repo'...
    fatal: unrecognized command ''git-upload-pack '"'"'git/test-repo'"'" '
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
```


> Or in other-words, explore other avenues of _sandboxing_ if security is of concern, such as a full `chroot` for Firejail to use, so that curious users like _`Bill`_ are sufficiently protected from themselves.



[firejail-issue-1817]: https://github.com/netblue30/firejail/issues/1817
[firejail-issue-887]: https://github.com/netblue30/firejail/issues/887
