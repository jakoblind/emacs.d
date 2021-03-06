;; Turnen off mouse interface early in startup to avoid momentary display
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(package-initialize)
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

;(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(setq fill-column 80)

;; Don't break lines for me, please
(setq-default truncate-lines t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq confirm-nonexistent-file-or-buffer nil)
(setq ido-create-new-buffer 'always)
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

(setq-default highlight-tabs t)
(setq-default show-trailing-whitespace 0)
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

(setq shell-file-name "/bin/sh")

(when (eq system-type "cygwin")
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130))

(show-paren-mode t)

(delete-selection-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (setq tooltip-use-echo-area t)
  (blink-cursor-mode -1))


; disable mouse scrolling to left and right
(global-set-key [wheel-left] 'ignore)
(global-set-key [wheel-right] 'ignore)
(global-set-key [double-wheel-left] 'ignore)
(global-set-key [double-wheel-right] 'ignore)
(global-set-key [triple-wheel-left] 'ignore)
(global-set-key [triple-wheel-right] 'ignore)

;;this might be good to enable when debugging lisp
;;(setq debug-on-error t)

;;; install all packages
(require 'packages)

(require 'ido)
(require 'flx-ido)
(ido-mode t)

(require 'magit-gitflow)
(require 'fill-column-indicator)
;(setq fci-rule-column 45)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

 ;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)


(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (buffer-disable-undo)
    (fundamental-mode)))

(add-hook 'find-file-hooks 'my-find-file-check-make-large-file-read-only-hook)

(setq ns-pop-up-frames nil)

;; possible to undo/redo window splitting

(defun create-note (file)
  (interactive "sFilename: ")
  (find-file (concat "/Users/jakoblind/Google Drive/emacsnotes/" file)))

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(winner-mode 1)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq-default indent-tabs-mode nil)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(global-set-key (kbd "M-W") 'recentf-open-files)

(require 'expand-region)
(require 'autopair)
(require 'undo-tree)
(require 'smooth-scrolling)
(require 'rainbow-delimiters)
(require 'highlight-symbol)

;;my programmingmodules
(require 'programming)
(require 'myparedit)
(require 'javascript)
(require 'markdown)
(require 'javascript-utils)
(require 'clojure)
;;(require 'scala)
(require 'emacslisp)
(require 'web)
(require 'npm)
(require 'blog)

(require 'window)
(require 'prettyprint)
(require 's)
(global-unset-key (kbd "s-<down-mouse-1>"))
(global-set-key (kbd "s-<mouse-1>") 'mc/add-cursor-on-click)
;make the cursor thin
;(require 'cursor-chg)
;(change-cursor-mode 0)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))


(global-undo-tree-mode)
(projectile-global-mode)
(autopair-global-mode) ;; enable autopair in all buffers

(require 'appearance)

;; I always wanna use bash in emacs
(setq explicit-shell-file-name "/bin/bash")

;; C-d to kill buffer if process is dead.
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

(require 'nodejs-repl-eval)
(require 'keybindings)
(require 'sudo-save)
(require 'macros)

(require 'orgmode-config)

;; Packages fetch from github submodule
(add-to-list 'load-path "~/.emacs.d/js2r-es6")
(require 'js2r-es6)
(add-to-list 'load-path "~/.emacs.d/es6-snippets")
(require 'es6-snippets)
(add-to-list 'load-path "~/.emacs.d/github-pullrequest")
(require 'github-pullrequest)

(server-start)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("613a7c50dbea57860eae686d580f83867582ffdadd63f0f3ebe6a85455ab7706" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "49eea2857afb24808915643b1b5bd093eefb35424c758f502e98a03d0d3df4b1" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" default)))
 '(sbt:program-name "/usr/local/bin/sbt")
 '(sgml-basic-offset 4))
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
(put 'downcase-region 'disabled nil)
