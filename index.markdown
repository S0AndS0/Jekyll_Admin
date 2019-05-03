---
layout: home
list_title: Usage
---

[Administration][administration] has been split into separate scripts with specific and shared functions. Most if not all scripts (including [`git_shell_commands`][git-shell-commands]) maybe run with `--help` to display select documentation within the terminal.


> Examples will include administrators named _`Elizabeth`_ and _`Joanna`_, and `Git`/`Jekyll` users named _`Bill`_ and _`Ted`_, so as to _liven up_ the documentation experience.


___


> ## Note for Firejail users
>
> Issues [1817][firejail-issue-1817], [887][firejail-issue-887] for Firejail shows a bit of the history of login shell options not working so great, in the case of `git` the following errors pop when Firejail is used as the *between* shell and a user __with authorized access__ attempts to clone

```
    Cloning into 'test-repo'...
    fatal: unrecognized command ''git-upload-pack '"'"'git/test-repo'"'" '
    fatal: Could not read from remote repository.

    Please make sure you have the correct access rights
    and the repository exists.
```

>
> Or in other-words, explore other avenues of _sandboxing_ if security is of concern. Because this project was designed for convenience first.


___


To add to this project's code base or documentation (or stomp a bug), please review the [contributing], and [styling] tips collections, then add yourself to the [contributors] collection in order to speed-up `Pull Request` review process.



[administration]: /Jekyll_Admin/administration/
[git-shell-commands]: /Jekyll_Admin/git_shell_commands/
[contributing]: /Jekyll_Admin/contributing/
[contributors]: /Jekyll_Admin/contributors/
[styling]: /Jekyll_Admin/styling/

[firejail-issue-1817]: https://github.com/netblue30/firejail/issues/1817
[firejail-issue-887]: https://github.com/netblue30/firejail/issues/887
