---
layout: post
title:  Bash Code
date:   2019-04-29 12:12:11 -0700
description: Styling guide-lines and other tips for `Bash` scripts
---

Tabs (`\t`) shall be four spaces (`    `) except in cases of using `-EOF`, eg...


```
tee -a /tmp/test.txt 1>/dev/null <<-EOF
\t    Hello\n\t    World
EOF
```

```bash
tee -a /tmp/test.txt 1>/dev/null <<-EOF
        Hello
        World
EOF
```

```bash
# cat /tmp/test.txt
    Hello
    World
```


------
