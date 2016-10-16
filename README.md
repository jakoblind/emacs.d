#Jakobs Emacs config

Welcome to my Emacs configuration, hope you will find something useful here. I have an intention to write a blogpost when I add something cool and I link to them in the blogposts-section below.

## Installation

```bash
$ git submodule init
$ git submodule update
$ ln -s ~/dev/emacs.d ~/.emacs.d
```

## Overview

### Blogposts

[Automatically import JS files from you project]("https://jakoblind.github.io/emacs/javascript/2016/10/16/automatically-import-js-files-from-you-project.html")
[Quickly go to Github PR page from Emacs](https://jakoblind.github.io/emacs/git/2016/10/14/quickly-go-to-github-pr-page-from-emacs.html)

### JavaScript
`javascript-utils.el` has some interesting functions for JavaScript developers.

* **js/import** Lists all JavaScript files in projectile project and all dependencies from package.json in ido list. The selected one is insert in an import statement at the cursor.
* **js/console-log** Lists all javascript variables in the buffer in an ido list. The one you picked is used in a console.log statment that is inserted where you have the cursor.
* **js/itonly** In Jasmine tests: Find closest `it` and convert it to an `it.only`
* **js/xit** In Jasmine tests: Find closest `it` and convert it to an `xit`
* **js/it** In Jasmine tests: Find closest `xit` or `it.only` and convert it to an `it`
* **js/describe-only** In Jasmine tests: Find closest `describe` and convert it to an `describe.only`
* **js/x-describe** In Jasmine tests: Find closest `describe` and convert it to an `xdescribe`
* **js/clean-describe** In Jasmine tests: Find closest `xdescribe` or `describe.only` and convert it to an `describe`



## Inspiration

* [https://github.com/magnars/.emacs.d](https://github.com/magnars/.emacs.d)
* [https://github.com/bodil/ohai-emacs](https://github.com/bodil/ohai-emacs)
* [https://github.com/pierre-lecocq/emacs4developers](https://github.com/pierre-lecocq/emacs4developers)
