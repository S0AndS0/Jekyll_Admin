---
layout: post
title:  Documentation
date:   2019-04-29 13:12:11 -0700
description: Guide-lines and other tips for documentation writers and editors
---

Please _mostly_ commit to the same noncommittal tone that's kinda already found within this project's documentation, while also remaining swiftly informative.


- Except for Front-Mater `.markdown` and `.md` files __must__ use pure Mark Down, eg. __no__ Liquid, HTML, etc.

- If editing a preexisting page then add your GitHub user-name to the list of `editors:` within that page's Front-Mater, eg...


```MarkDown
---
layout: post
title:  Styling of Documentation
date:   2019-04-29 13:12:11 -0700
description: Guide-lines and other tips for documentation writers
editors: GitHub-UserName Another-UserName
# Lists are space separated
---
```


- If adding a new page then write your GitHub user-name to the `author:` Front-Mater for that page, eg...


```MarkDown
---
layout: post
title:  Styling of Documentation
date:   2042-04-01 02:03:04 -0700
description: Tips on new _excellent_ feature from the future
author: GitHub-UserName
# Layouts will eventually pick-up on these configs
---
```


- Links shall be at the end of pages separated from content by three newlines, eg...


```MarkDown
---
# ... Front-Mater goes here...
---

Content of post or page


- [Example][external_link] link to external resource

- Link to [Internal][internal_link] resource



[external_link]: https://example.com
[internal_link]: /Jekyll_Admin/404.html
```


> Additionally as shown above, list items should have one newline between, and _blocks_ of formatted content should have two newlines between.
