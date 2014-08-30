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

(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)

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

(setq
 wanted-packages
 '(
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
   autopair
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

(global-set-key (kbd "C-x o") 'switch-window)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140824.1658/dict/")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(require 'ido)
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
(autopair-global-mode) ;; enable autopair in all buffers

;;from magnars
(define-key global-map (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)


;;jakobs functions
(global-set-key (kbd "C-<up>") 'er/expand-region)
(global-set-key (kbd "C-<down>") 'er/contract-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<left>") (kbd "C-<left>"))
(global-set-key (kbd "s-<right>") (kbd "C-<right>"))
(global-set-key (kbd "s-S-<left>") (kbd "C-S-<left>"))
(global-set-key (kbd "s-S-<right>") (kbd "C-S-<right>"))

(global-set-key (kbd "M-S-<left>") (kbd "C-S-a"))
(global-set-key (kbd "M-S-<right>") (kbd "C-S-e"))
(global-set-key (kbd "M-<left>") (kbd "C-a"))
(global-set-key (kbd "M-<right>") (kbd "C-e"))
(global-set-key (kbd "M-<up>") (kbd "M-<"))
(global-set-key (kbd "M-<down>") (kbd "M->"))
(global-set-key (kbd "M-<backspace>") 'kill-whole-line)
(global-set-key (kbd "S-<return>") (kbd "C-e <return>"))
(global-set-key (kbd "M-S-<up>") (kbd "C-a C-k C-k <up> C-y <up>"))
(global-set-key (kbd "M-S-<down>") (kbd "C-a C-k C-k <down> C-y <up>"))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

(global-set-key (kbd "M-e") 'smex)
(global-set-key (kbd "M-d") 'duplicate-line)
(global-set-key (kbd "M-f") (kbd "C-s"))
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-x") (kbd "C-w"))
(global-set-key (kbd "M-c") (kbd "M-w"))
(global-set-key (kbd "M-v") (kbd "C-y"))
(global-set-key (kbd "M-z") (kbd "C-_"))
;(global-set-key (kbd "M-w") (kbd "C-X k"))
(global-set-key (kbd "M-f") (kbd "C-s"))
(global-set-key (kbd "M-a") (kbd "C-x h"))
