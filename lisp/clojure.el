(require 'clojure-mode)
(require 'clj-refactor)
(require 'cider)
(require 'ac-cider)
(require 'html-to-hiccup)

(add-hook 'clojure-mode-hook 'prettify-symbols-mode)

(add-hook 'cider-mode-hook 'ac-flyspell-workaround)
(add-hook 'cider-mode-hook 'ac-cider-setup)
(add-hook 'cider-repl-mode-hook 'ac-cider-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-mode))

(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               ;; insert keybinding setup here
                               (cljr-add-keybindings-with-prefix "C-c C-c")
                               ))

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))

(eval-after-load "cider"
  '(define-key cider-mode-map (kbd "C-c C-d") 'ac-cider-popup-doc))

(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
           (figwheel-sidecar.repl-api/start-figwheel!)
           (figwheel-sidecar.repl-api/cljs-repl))")

(provide 'clojure)
