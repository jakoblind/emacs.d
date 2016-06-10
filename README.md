##My Emacs config

Most of this emacs config is copied by others (se inspiration section), but there are some original content written by me.

### JavaScript
`javascript-utils.el` has some interesting functions for JavaScript developers.

* **js/console-log** Lists all javascript variables in the buffer in an ido list. The one you picked is used in a console.log statment that is inserted where you have the cursor.
* **js/itonly** In Jasmine tests: Find closest `it` and convert it to an `it.only`
* **js/xit** In Jasmine tests: Find closest `it` and convert it to an `xit`
* **js/it** In Jasmine tests: Find closest `xit` or `it.only` and convert it to an `it`
* **js/describe-only** In Jasmine tests: Find closest `describe` and convert it to an `describe.only`
* **js/x-describe** In Jasmine tests: Find closest `describe` and convert it to an `xdescribe`
* **js/clean-describe** In Jasmine tests: Find closest `xdescribe` or `describe.only` and convert it to an `describe`


## Installation

ln -s ~/dev/emacs.d ~/.emacs.d

## Inspiration

* [https://github.com/magnars/.emacs.d](https://github.com/magnars/.emacs.d)
* [https://github.com/bodil/ohai-emacs](https://github.com/bodil/ohai-emacs)
* [https://github.com/pierre-lecocq/emacs4developers](https://github.com/pierre-lecocq/emacs4developers)
