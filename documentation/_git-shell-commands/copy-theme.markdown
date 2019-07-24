---
layout: post
title:  Copy Theme
date:   2019-04-24 11:12:15 -0700
categories: git_shell_commands
description: The `copy-theme` client script copies source Theme files listed in named repository's `_config.yml` site configuration file
---


Supposing that _`Ted`_ wanted to check-out their _`Radical_Features`_ Theme files, the following might be what _`Ted`'ll_ whisper at their terminal in regard to the [`copy-theme`][source_master__copy-theme] script...


```bash
ssh Ted copy-theme Radical_Features

cd ~/git/Radical_Features
git pull
```


------


Perhaps instead _`Bill`_ wants to check-out Theme source files not normally within their _`Excellent_Project`'s_ site configuration, `Architect` for example...


```bash
ssh Bill copy-theme --theme='architect' Excellent_Project

cd ~/git/Excellent_Project
git pull
```

------


However, both _`Bill`_ and _`Ted`_ should be careful because running either of the above could cause conflicts or pre-existing files to be overwritten. In the case of the latter, this is _no big deal_ as a _`git show <something>`_ enables file recovery of previous versions, __but__ in the case of the former _`Bill`_ and _`Ted`_ would be wise to be kind to their administrators.


[source_master__copy-theme]: https://github.com/git-utilities/git-shell-commands/blob/master/copy-theme
