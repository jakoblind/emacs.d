;;; PACKAGE STUFF
(setq
 wanted-packages
 '(
   projectile
   js2-mode
   js2-refactor
   clojure-mode
   clj-refactor
   color-theme
   autopair
   expand-region
   yasnippet
   auto-complete
   ace-jump-mode
   browse-kill-ring
   paredit
   smex
   ido
   flx
   flx-ido
   magit
   multiple-cursors
   undo-tree
   smooth-scrolling
))

(defun install-wanted-packages ()
  "Install wanted packages according to a specific package manager"
    (require 'package)
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
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
