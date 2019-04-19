---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
list_title: Usage
---

Administration has been split into separate scripts with specific and shared functions. Most if not all scripts (including those for _`Git`_/_`Jekyll`_ clients) maybe run with `--help` to display select documentation within the terminal. Check the `Usage` section for examples.


___


> ## Note for Firejail users
>
> Issues [1817](https://github.com/netblue30/firejail/issues/1817), [887](https://github.com/netblue30/firejail/issues/887) for Firejail shows a bit of the history of login shell options not working so great, in the case of `git` the following errors pop when Firejail is used as the *between* shell and a user __with authorized access__ attempts to clone

```
    Cloning into 'test-repo'...
    fatal: unrecognized command ''git-upload-pack '"'"'git/test-repo'"'" '
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
```

___
