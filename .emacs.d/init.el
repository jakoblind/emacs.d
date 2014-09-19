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
;;;(global-hl-line-mode 1)

(load-theme 'tango-dark)

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

;; possible to undo/redo window splitting
(winner-mode 1)
(require 'paredit)
(require 'expand-region)
(require 'autopair)
(require 'js2-refactor)
(require 'multiple-cursors)
(require 'undo-tree)
(require 'smooth-scrolling)
(require 'clojure-mode)
(require 'clj-refactor)
(require 'cider)

(when (require 'rainbow-delimiters nil 'noerror)
  (add-hook 'clojure-mode-hook 'rainbow-delimiters-mode))

(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               ;; insert keybinding setup here
                               (cljr-add-keybindings-with-prefix "C-c C-c")
                               ))

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))

(defvar my-nasty-paredit-keybindings-remappings
  '(("M-s"         "s-s"         paredit-splice-sexp)
    ("M-r"          "s-r"      paredit-splice-sexp-killing-backward)
    ("M-<up>"      "s-<up>"      paredit-splice-sexp-killing-backward)
    ("M-<down>"    "s-<down>"    paredit-splice-sexp-killing-forward)
    ("C-<right>"   "s-<right>"   paredit-forward-slurp-sexp)
    ("C-<left>"    "s-<left>"    paredit-forward-barf-sexp)
    ("C-M-<left>"  "s-S-<left>"  paredit-backward-slurp-sexp)
    ("C-M-<right>" "s-S-<right>" paredit-backward-barf-sexp)))

(--each my-nasty-paredit-keybindings-remappings
  (let ((original (car it))
        (replacement (cadr it))
        (command (car (last it))))
    (define-key paredit-mode-map (read-kbd-macro original) nil)
    (define-key paredit-mode-map (read-kbd-macro replacement) command)))

(define-key paredit-mode-map (kbd "C-<right>") 'paredit-forward)
(define-key paredit-mode-map (kbd "C-<left>") 'paredit-backward)
(define-key paredit-mode-map (kbd "C-<up>") 'paredit-forward-up)
(define-key paredit-mode-map (kbd "C-<down>") 'paredit-forward-down)
(define-key paredit-mode-map (kbd "C-s-<up>") 'paredit-backward-up)
(define-key paredit-mode-map (kbd "C-s-<down>") 'paredit-backward-down)

(global-undo-tree-mode)
(projectile-global-mode)
(autopair-global-mode) ;; enable autopair in all buffers

;;multi cursor
;(global-set-key (kbd "C-g") 'mc/mark-next-word-like-this)
;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(define-key global-map (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)


(require 'keybindings)
