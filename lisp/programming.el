(require 'multiple-cursors)
;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
;(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "/elpa/auto-complete-20141208.809/dict/"))
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;(global-auto-complete-mode t)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;magit
(setq magit-push-always-verify nil)
(global-set-key (kbd "C-c s") 'magit-status)

;; try to make magit faster
(setq magit-refresh-status-buffer nil)
(remove-hook 'server-switch-hook 'magit-commit-diff) ;dont show diff on commit



(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "s-<tab>") 'yas-expand)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;multi cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "s->") 'mc/mark-next-like-this-word)
(global-set-key (kbd "s-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(define-key global-map (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)


;(defun set-auto-complete-as-completion-at-point-function ()
;  (setq completion-at-point-functions '(auto-complete)))

;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(require 'editorconfig)

(provide 'programming)
