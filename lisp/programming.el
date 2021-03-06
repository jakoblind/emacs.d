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


(eval-after-load "magit"
  (lambda () (interactive) (progn
                        (remove-hook 'server-switch-hook 'magit-commit-diff) ;dont show diff on commit
                        (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
                        (defun git-commit-check-style-conventions (force) t) ;dont ask if commit message is too long. i already know) )

                        ;; Make magit never ask for a stash message. Instead always use default.
                        (defun magit-stash-read-message ()
                          (concat (format "On %s: " (or (magit-get-current-branch) "(no branch)")) (magit-rev-format "%h %s")))

                        )))

(setq magit-completing-read-function
    'magit-ido-completing-read) ; use ido in magit

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

(defun gh-pr ()
  "go to github pull request page for repo"
  (interactive)
  (browse-url (concat (replace-regexp-in-string ".git$" "" (magit-get "remote" "origin" "url")) "/pulls")))

;(defun set-auto-complete-as-completion-at-point-function ()
;  (setq completion-at-point-functions '(auto-complete)))

;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)
(require 'editorconfig)
(editorconfig-mode 1)

(provide 'programming)
