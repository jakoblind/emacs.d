(require 'js2-mode)
(require 'js2-refactor)
(require 'react-snippets)

(add-hook 'js2-mode-hook
            (lambda ()
              (push '("function" . ?λ) prettify-symbols-alist)))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;; add a semicolon at end of line with M-; in js2-mode
(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "M-S-<down>") 'js2r-move-line-down)
     (define-key js2-mode-map (kbd "M-S-<up>") 'js2r-move-line-up)
     (define-key js2-mode-map (kbd "M-<backspace>") '(lambda () (interactive) (run-at-end-of-line '(lambda () (backward-char) (delete-char 1)))))
     (define-key js2-mode-map (kbd "M-;") '(lambda () (interactive) (run-at-end-of-line '(lambda () (insert ";")))))
     (define-key js2-mode-map (kbd "M-,") '(lambda () (interactive) (run-at-end-of-line '(lambda () (insert ",")))))))

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

(add-hook 'js2-mode-hook 'my-paredit-nonlisp)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))


(provide 'javascript)
