(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

; move camelcase
(global-subword-mode 1)

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)

(global-set-key (kbd "C-a") 'smarter-move-beginning-of-line)

(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (call-interactively 'goto-line))
    (linum-mode -1)))
(global-set-key (kbd "s-l") 'goto-line-with-feedback)

(global-set-key (kbd "C-s-<down>") (lambda () (interactive) (ignore-errors (next-line 5))))
(global-set-key (kbd "C-s-<up>") (lambda () (interactive) (ignore-errors (previous-line 5))))
(global-set-key (kbd "M-n") (lambda () (interactive) (ignore-errors (next-line 5))))
(global-set-key (kbd "M-p") (lambda () (interactive) (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-c +") 'text-scale-increase)
(global-set-key (kbd "C-c -") 'text-scale-decrease)

(provide 'keybindings-common)
