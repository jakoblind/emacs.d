;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; No splash screen please ... jeez
;(setq inhibit-startup-message t)

; MAC KEY BINDINGS
; META: cmd key
; CTRL: ctrl key
; SUPER: option key
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(setq mac-option-modifier 'super)

(setq user-full-name "Jakob Lind")
(setq user-mail-address "karl.jakob.lind@gmail.com")

(add-to-list 'load-path user-emacs-directory)

(setq fill-column 80)

;; Don't break lines for me, please
(setq-default truncate-lines t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq-default highlight-tabs t)
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Remove all backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; Appearance

(setq visible-bell t)

;; Highlight current line
(global-hl-line-mode 1)

(show-paren-mode t)

(delete-selection-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;;; install all packages
(require 'packages)
(global-set-key (kbd "C-x o") 'switch-window)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "/elpa/auto-complete-20140824.1658/dict/"))
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(require 'ido)
(require 'flx-ido)
(ido-mode t)

 ;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(require 'paredit)
(require 'expand-region)
(require 'autopair)
(require 'js2-refactor)
(require 'multiple-cursors)
(require 'undo-tree)
(require 'smooth-scrolling)
(global-undo-tree-mode)
(projectile-global-mode)
(autopair-global-mode) ;; enable autopair in all buffers


;;multi cursor
(global-set-key (kbd "C-g") 'mc/mark-next-word-like-this)
;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(define-key global-map (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)

;(load-file "~/cedet-1.1/common/cedet.el")
;(global-ede-mode 1)                      ; Enable the Project management system
;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;(global-srecode-minor-mode 1)            ; Enable template insertion menu
;(require 'ecb)


(require 'keybindings)
