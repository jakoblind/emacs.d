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

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))


;;; PACKAGE STUFF
(setq
 wanted-packages
 '(
   projectile
   js2-mode
   js2-refactor
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


;;; jakobs functions
;;TODO
; fix scrolling
; mulitple cursors sux

;; file navigation
(global-set-key (kbd "M-o") 'projectile-find-file)
(global-set-key (kbd "M-i") 'projectile-display-buffer)
(global-set-key (kbd "M-b") 'ido-switch-buffer)


(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; code navigation
(delete-selection-mode 1)

(global-set-key (kbd "C-<up>") 'er/expand-region)
(global-set-key (kbd "C-<down>") 'er/contract-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<left>") (kbd "C-<left>"))
(global-set-key (kbd "s-<right>") (kbd "C-<right>"))
(global-set-key (kbd "s-S-<left>") (kbd "C-S-<left>"))
(global-set-key (kbd "s-S-<right>") (kbd "C-S-<right>"))
(global-set-key (kbd "s-<backspace>") (kbd "C-<backspace>"))

(global-set-key (kbd "M-S-<left>") (kbd "C-S-a"))
(global-set-key (kbd "M-S-<right>") (kbd "C-S-e"))
(global-set-key (kbd "M-<left>") (kbd "C-a"))
(global-set-key (kbd "M-<right>") (kbd "C-e"))
(global-set-key (kbd "M-<up>") (kbd "M-<"))
(global-set-key (kbd "M-<down>") (kbd "M->"))
(global-set-key (kbd "M-<backspace>") 'delete-line)
(global-set-key (kbd "S-<return>") (kbd "C-e <return>"))

(defun delete-line (&optional arg)
  (interactive "P")
  (flet ((kill-region (begin end)
		      (delete-region begin end)))
    (kill-whole-line arg)))


(autoload 'copy-from-above-command "misc"
    "Copy characters from previous nonblank line, starting just above point.

  \(fn &optional arg)"
    'interactive)

 (defun duplicate-line ()
   (interactive)
   (forward-line 1)
   (open-line 1)
   (copy-from-above-command))


(global-set-key (kbd "M-e") 'smex)
(global-set-key (kbd "M-d") 'duplicate-line)
(global-set-key (kbd "M-f") (kbd "C-s"))
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-z") (kbd "C-_"))
;(global-set-key (kbd "M-w") (kbd "C-X k"))
(global-set-key (kbd "M-f") (kbd "C-s"))
(global-set-key (kbd "M-a") (kbd "C-x h"))
(global-set-key (kbd "M-q") (kbd "C-x C-c"))
(global-set-key (kbd "M-l") 'goto-line-with-feedback)

;;moving text
(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
	    (exchange-point-and-mark))
     (let ((column (current-column))
	      (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
	    (transpose-lines arg))
       (forward-line -1)))))

(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))

(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))

(global-set-key (kbd "M-S-<down>") 'move-text-down)
(global-set-key (kbd "M-S-<up>") 'move-text-up)
