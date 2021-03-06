(require 'web-mode)
(require 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.svelte?\\'" . web-mode))

(eval-after-load 'web-mode
  '(progn
     (define-key web-mode-map (kbd "M-m") 'js2-mode)))

(provide 'web)
