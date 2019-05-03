---
layout: post
title:  Bash
date:   2019-04-29 12:12:11 -0700
description: Tips and other guide-lines for `Bash` script writers/editors
---

Aside from writing code that serves some purpose within this project, here's some tips on how to get Bash code accepted within the code base;


- Tabs (`\t`) shall be four spaces (`    `) each, with very few (if any) exceptions.

- Avoid sacrificing readability for the sake of brevity.

- The _soft_ column limit is `119` for code and `79` for comments.

- Avoid submitting scripts longer than `300` lines of actionable code. For example new-lines (`\n`), and self-documentation such as `usage` functions __don't__ count.

- Within reason use built-ins where-ever possible, because pipes (`|`) can be _expensive_.
