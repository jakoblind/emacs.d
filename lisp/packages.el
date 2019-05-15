;;; PACKAGE STUFF
(setq
 wanted-packages
 '(
   nodejs-repl
   org2blog
   editorconfig
   highlight-symbol
   markdown-mode
   feature-mode
   rainbow-delimiters
   less-css-mode
   projectile
   js2-mode
   js2-refactor
   xref-js2
   clojure-mode
   clj-refactor
   autopair
   expand-region
   yasnippet
   auto-complete
   ace-jump-mode
   browse-kill-ring
   paredit
   smex
   markdown-toc
   ido
   flx
   flx-ido
   magit
   magit-gitflow
   multiple-cursors
   undo-tree
   smooth-scrolling
   cider
   ac-cider
   html-to-hiccup
   exec-path-from-shell
   ensime
   noctilux-theme
   cursor-chg
   web-mode
   emmet-mode
   helm-projectile
   dash-at-point
   tern
   tern-auto-complete
   windresize
   web-beautify
   ack-and-a-half
   ido-completing-read+
   smart-mode-line
   fill-column-indicator
   f
   flycheck
   vue-mode
   toggle-quotes
   js-import
   github-pullrequest
   org-journal
   add-node-modules-path
   prettier-js
   ack
   ag
   ido-ubiquitous
   rjsx-mode
))

(defun install-wanted-packages ()
  "Install wanted packages according to a specific package manager"
    (require 'package)
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
    (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
;    (add-to-list 'package-archives '("melpa-snapshots" . "http://melpa.milkbox.net/packages/"))
    (add-to-list 'package-archives '("marmelade" . "http://marmalade-repo.org/packages/"))
    (package-initialize)
    (let ((need-refresh nil))
      (mapc (lambda (package-name)
          (unless (package-installed-p package-name)
        (set 'need-refresh t))) wanted-packages)
      (if need-refresh
        (package-refresh-contents)))
    (mapc (lambda (package-name)
        (unless (package-installed-p package-name)
          (package-install package-name))) wanted-packages)
    )
(install-wanted-packages)

(provide 'packages)
