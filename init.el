;; Turnen off mouse interface early in startup to avoid momentary display
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
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

;;; Appearance
(set-face-attribute  'mode-line
                 nil
                 :foreground "gray80"
                 :background "gray25"
                 :box '(:line-width 1 :style released-button))

(set-face-attribute  'mode-line-inactive
                     nil
                     :foreground "gray30"
                     :background "gray96"
                     :box '(:line-width 1 :style released-button))

(when (eq system-type "cygwin")
  (set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 130))

;increase font size, (and something else?)
(set-face-attribute 'default nil :height 150)
;(set-face-attribute 'default nil :height 120)

(setq visible-bell t)

;; Highlight current line
(global-hl-line-mode 1)
(set-face-background hl-line-face "gray96")

;show line number in footer
(column-number-mode 1)

(show-paren-mode t)

(delete-selection-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
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

 ;; Display ido results vertically, rather than horizontally
  (setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
  (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
  (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
  (defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
    (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
  (add-hook 'ido-setup-hook 'ido-define-keys)

(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (buffer-disable-undo)
    (fundamental-mode)))

(add-hook 'find-file-hooks 'my-find-file-check-make-large-file-read-only-hook)

(setq ns-pop-up-frames nil)

;; possible to undo/redo window splitting

(require 'dired+)

(defun create-note (file)
  (interactive "sFilename: ")
  (find-file (concat "/Users/jakoblind/Google Drive/emacsnotes/" file)))

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
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
(require 'clojure)
(require 'scala)
(require 'emacslisp)
(require 'web)
(require 'npm)

(require 'window)
(require 'prettyprint)
(require 's)

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

(load-theme 'noctilux t)
;(disable-theme 'noctilux)
                                        ;

(global-visual-line-mode 1)

(setq highlight-symbol-idle-delay 0)

(setq speedbar-use-images nil
      sr-speedbar-right-side nil
      speedbar-show-unknown-files t
      sr-speedbar-width 10
      sr-speedbar-max-width 10
      sr-speedbar-default-width 10
      sr-speedbar-skip-other-window-p t)

(sr-speedbar-open)

(require 'nodejs-repl-eval)

(require 'keybindings)
(require 'sudo-save)


(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
(defalias 'ack-with-args 'ack-and-a-half-with-args)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "1a85b8ade3d7cf76897b338ff3b20409cb5a5fbed4e45c6f38c98eee7b025ad4" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "49eea2857afb24808915643b1b5bd093eefb35424c758f502e98a03d0d3df4b1" "2b5aa66b7d5be41b18cc67f3286ae664134b95ccc4a86c9339c886dfd736132d" default)))
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
(put 'downcase-region 'disabled nil)
