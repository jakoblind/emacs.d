(global-set-key (kbd "C-x p") 'projectile-find-file)
(global-set-key (kbd "C-x i") 'projectile-switch-project)

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-'") 'er/expand-region)
(global-set-key (kbd "M-'") 'er/contract-region)

(global-set-key (kbd "M-o") 'other-window)


;; Mark additional regions matching current region
;(global-set-key (kbd "M-'") 'mc/mark-all-dwim)
;(global-set-key (kbd "C-[") 'mc/mark-previous-like-this)
;(global-set-key (kbd "C-'") 'mc/mark-next-like-this)
;(global-set-key (kbd "C-\"") 'mc/mark-more-like-this-extended)

(provide 'keybindings-linux)
