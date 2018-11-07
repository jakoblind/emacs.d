(require 'js2-mode)
(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.emacs.d/Es6-React-Snippets-Emacs/snippets")))
(add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?λ) prettify-symbols-alist)))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))

(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))

;;enable auto complete mode in jsx mode
(add-to-list 'ac-modes 'js2-jsx-mode)

(setq js2-mode-show-parse-errors nil)
(setq js2-mode-show-strict-warnings nil)

;; Disable JSCS linting because we use es lint
(let ((checkers (get 'javascript-eslint 'flycheck-next-checkers)))
  (put 'javascript-eslint 'flycheck-next-checkers
       (remove '(warning . javascript-jscs) checkers)))

;; (require 'tern)
;; (add-hook 'js2-mode-hook (lambda () (tern-mode t))) ;
;; (setq tern-command (cons (executable-find "tern") '()))
;; (eval-after-load 'tern
;;   '(progn
;;      (define-key tern-mode-keymap (kbd "C-c C-r") 'nil) ; we are going to use that binding for js2 refactor
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

(require 'js2-refactor)
(require 'prettier-js)

;add prettier if .prettierrc exist
(eval-after-load 'js2-mode
  '(progn
     (add-hook 'js2-mode-hook #'add-node-modules-path)
     (add-hook 'js2-mode-hook (lambda () (when (locate-dominating-file default-directory ".prettierrc") (prettier-js-mode))))))

(add-hook 'js-mode-hook #'js2-refactor-mode)
(add-hook 'js-mode-hook #'flycheck-mode)
(add-hook 'js-mode-hook 'auto-insert-mode)

(setq js2-skip-preprocessor-directives t)

(js2r-add-keybindings-with-prefix "C-c C-r")

(require 'flycheck)

(defun eslint-get-local-path ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules")))
    (and root
         (expand-file-name "node_modules/eslint/bin/eslint.js"
                           root))))
(defun eslint-fix ()
  "Format the current file with ESLint."
  (interactive)
  (let ((eslint (eslint-get-local-path)))
    (if (executable-find eslint)
        (progn (call-process eslint nil "*ESLint Errors*" nil "--fix" buffer-file-name)
               (revert-buffer t t t))
      (message "ESLint not found."))))

(defun my/use-eslint-from-node-modules ()
  (let ((eslint (eslint-get-local-path)))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; add a semicolon at end of line with M-; in js2-mode
(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "C-c C-j") 'nil)
     (define-key js2-mode-map (kbd "M-j") 'nil)
     (define-key js2-mode-map (kbd "M-R") 'js2r-rename-var)
     (define-key js2-mode-map (kbd "M-/") 'comment-region)
     (define-key js2-mode-map (kbd "M-S-<down>") 'js2r-move-line-down)
     (define-key js2-mode-map (kbd "M-S-<up>") 'js2r-move-line-up)))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(jsx\\)\\'" . "JSX component skeleton")
     '("Short description: "
       "import React from 'react';" \n
       "import _ from 'lodash';" \n
       "" \n
       "class "
       (first (split-string (file-name-nondirectory (buffer-file-name)) "\\."))
       " extends React.Component {" \n
       "render() {" \n
       "return (<div>"
       > _
       "</div>);" \n
       "}" \n
       "}" \n
       "" \n
       "export default "
       (first (split-string (file-name-nondirectory (buffer-file-name)) "\\."))
       ";" \n)))

(defun run-at-end-of-line (c) (point-to-register 16)
                      (end-of-line)
                      (funcall c)
                      (jump-to-register 16))

(defun my-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(add-hook 'js-mode-hook 'my-paredit-nonlisp)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))


;;
;; My custom edit and refactoring commands for Javascript
;;
(defun req-to-import ()
  "Convert a require statement to an ES6 import statement"
  (interactive)
  (beginning-of-line)
  (kill-word 1)
  (insert "import")
  (end-of-line)
  (backward-char)
  (paredit-backward)
  (paredit-backward)
  (kill-word 1)
  (delete-backward-char 1)
  (delete-backward-char 1)
  (insert "from ")
  (paredit-forward-down)
  (paredit-splice-sexp))

(provide 'javascript)
