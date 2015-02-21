(add-hook 'emacs-lisp-mode-hook  'prettify-symbols-mode)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))

(provide 'emacslisp)
