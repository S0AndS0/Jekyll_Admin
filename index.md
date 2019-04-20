---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
list_title: Usage
---

[Administration][administration] has been split into separate scripts with specific and shared functions. Most if not all scripts (including [`git_shell_commands`][git-shell-commands]) maybe run with `--help` to display select documentation within the terminal.


> Examples will include administrators named _`Elizabeth`_ and _`Joanna`_, and `Git`/`Jekyll` users named _`Bill`_ and _`Ted`_, so as to _liven up_ the documentation experience.


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


[administration]: {{ '/admin/' | relative_url }}
[git-shell-commands]: {{ 'git_shell_commands' | relative_url }}
