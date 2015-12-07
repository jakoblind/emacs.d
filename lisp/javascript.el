(require 'js2-mode)
(require 'js2-refactor)
(require 'react-snippets)

(add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?λ) prettify-symbols-alist)))

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

(require 'js2-refactor)
(add-hook 'js-mode-hook #'js2-refactor-mode)
(add-hook 'js-mode-hook #'flycheck-mode)
(add-hook 'js-mode-hook 'auto-insert-mode)
(add-hook 'js2-mode-hook 'ac-js2-mode)

(js2r-add-keybindings-with-prefix "C-c C-r")

;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

(require 'flycheck)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; add a semicolon at end of line with M-; in js2-mode
(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-eval-dwim)
     (define-key js2-mode-map (kbd "M-j") 'nil)
     (define-key js2-mode-map (kbd "M-R") 'js2r-rename-var)
     (define-key js2-mode-map (kbd "M-/") 'comment-region)
     (define-key js2-mode-map (kbd "M-S-<down>") 'js2r-move-line-down)
     (define-key js2-mode-map (kbd "M-S-<up>") 'js2r-move-line-up)
     (define-key js2-mode-map (kbd "M-<mouse-1>") 'ac-js2-jump-to-definition)
     (define-key js2-mode-map (kbd "M-m") 'web-mode)
     (define-key js2-mode-map (kbd "M-S-<backspace>") '(lambda () (interactive) (run-at-end-of-line '(lambda () (backward-char) (delete-char 1)))))
     (define-key js2-mode-map (kbd "M-;") '(lambda () (interactive) (run-at-end-of-line '(lambda () (insert ";")))))
     (define-key js2-mode-map (kbd "M-,") '(lambda () (interactive) (run-at-end-of-line '(lambda () (insert ",")))))))

(eval-after-load 'autoinsert
  '(define-auto-insert
     '("\\.\\(jsx\\)\\'" . "JSX component skeleton")
     '("Short description: "
       "import React from 'react';" \n
       "import _ from 'lodash';" \n
       "" \n
       "var "
       (first (split-string (file-name-nondirectory (buffer-file-name)) "\\."))
       " = React.createClass({" \n
       "render() {" \n
       "return (<div>"
       > _
       "</div>);" \n
       "}" \n
       "});" \n
       "" \n
       "module.exports = "
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


(provide 'javascript)
