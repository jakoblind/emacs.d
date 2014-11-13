;; Turnen off mouse interface early in startup to avoid momentary display
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

 (global-auto-revert-mode 1)

;;; Appearance


(when (eq system-type "cygwin")
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130))

(setq visible-bell t)

;; Highlight current line
;;;(global-hl-line-mode 1)


(show-paren-mode t)

(delete-selection-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))


(setq debug-on-error t)

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

(setq ns-pop-up-frames nil)

;; possible to undo/redo window splitting

;;; XML pretty print
(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode
http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do
this.  The function inserts linebreaks to separate tags that have
nothing but whitespace between them.  It then indents the markup
by using nxml's indentation rules."
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[ \\t]*\<" nil t)
	(backward-char) (insert "\n"))
      (indent-region begin end))
    (message "Ah, much better!"))

(defun pretty-print-json-region (start end)
  (interactive "r")
  (shell-command-on-region start end "python -m json.tool" nil (current-buffer) 1))


(winner-mode 1)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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
(require 'rainbow-delimiters)
(require 'scala-mode2)
(require 'ensime)


(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(define-key scala-mode-map (kbd "M-s-<left>") 'ensime-pop-find-definition-stack)
;;ensime-inspect-type-at-point
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(add-hook 'clojure-mode-hook (lambda ()
			       (clj-refactor-mode 1)
			       ;; insert keybinding setup here
			       (cljr-add-keybindings-with-prefix "C-c C-c")
			       ))

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))


(define-key paredit-mode-map (kbd "s-<left>") nil)
(define-key paredit-mode-map (kbd "M-<down>") nil)
(define-key paredit-mode-map (kbd "M-<up>") nil)
(define-key paredit-mode-map (kbd "s-<right>") nil)
(define-key paredit-mode-map (kbd "s-S-<left>") nil)
(define-key paredit-mode-map (kbd "s-S-<right>") nil)
(define-key paredit-mode-map (kbd "M-q") nil)
(define-key paredit-mode-map (kbd "M-s") nil)
(define-key paredit-mode-map (kbd "M-d") nil)
(define-key paredit-mode-map (kbd "<enter>") 'paredit-newline)

(define-key paredit-mode-map (kbd "s-e") 'cider-eval-last-sexp)

(global-undo-tree-mode)
(projectile-global-mode)
(autopair-global-mode) ;; enable autopair in all buffers

(load-theme 'brin t)

;;multi cursor
(global-set-key (kbd "M-g") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(define-key global-map (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-x C-y") 'browse-kill-ring)


(require 'keybindings)
(require 'sudo-save)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "49eea2857afb24808915643b1b5bd093eefb35424c758f502e98a03d0d3df4b1" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" default)))
 '(sbt:program-name "/usr/local/bin/sbt"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when window-system
  (let (
	(px (display-pixel-width))
	(py (display-pixel-height))
	(fx (frame-char-width))
	(fy (frame-char-height))
	tx ty
	)
    ;; Next formulas discovered empiric on Windows host with default font.
    (setq tx (- (/ px fx) 7))
    (setq ty (- (/ py fy) 4))
    (setq initial-frame-alist '((top . 2) (left . 2)))
    (add-to-list 'initial-frame-alist (cons 'width tx))
    (add-to-list 'initial-frame-alist (cons 'height ty))
    ) )
