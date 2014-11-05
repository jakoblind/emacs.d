;;; jakobs functions
;;TODO
; fix scrolling
; mulitple cursors sux
; duplicate should be able to duplicate the exact selection
; c-<backspace> should not put content in killbuffer
; when opening a new window, move focus to it

;; file navigation
(global-set-key (kbd "M-o") 'projectile-find-file)
(global-set-key (kbd "M-i") 'projectile-display-buffer)
(global-set-key (kbd "M-b") 'ido-switch-buffer)


(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Window navigation
(global-set-key (kbd "M-1") (kbd "C-x 1"))
(global-set-key (kbd "M-2") (kbd "C-x 2"))
(global-set-key (kbd "M-3") (kbd "C-x 3"))
(global-set-key (kbd "M-4") (kbd "C-x 0"))
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "M-`") 'winner-undo)
(global-set-key (kbd "M-~") 'winner-redo)


;(windmove-up)

;; code navigation

; move camelcase
(global-subword-mode 1)

(global-set-key (kbd "C-<up>") 'er/expand-region)
(global-set-key (kbd "C-<down>") 'er/contract-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<left>") (kbd "C-<left>"))
(global-set-key (kbd "s-<right>") (kbd "C-<right>"))
(global-set-key (kbd "s-S-<left>") (kbd "C-S-<left>"))
(global-set-key (kbd "s-S-<right>") (kbd "C-S-<right>"))
;(global-set-key (kbd "s-<left>") 'backward-word)
;(global-set-key (kbd "s-<right>") 'forward-word)
;(global-set-key (kbd "C-<left>") 'backward-word)
;(global-set-key (kbd "C-<right>") 'forward-word)
(global-set-key (kbd "s-<backspace>") (kbd "C-<backspace>"))

(global-set-key (kbd "M-S-<left>") (kbd "C-S-a"))
(global-set-key (kbd "M-S-<right>") (kbd "C-S-e"))
(global-set-key (kbd "M-<left>") 'smarter-move-beginning-of-line)
(global-set-key (kbd "M-<right>") (kbd "C-e"))
(global-set-key (kbd "M-<up>") (kbd "M-<"))
(global-set-key (kbd "M-<down>") (kbd "M->"))
(global-set-key (kbd "M-<backspace>") 'delete-line)
(global-set-key (kbd "S-<return>") (kbd "C-e <return>"))
(global-set-key (kbd "M-<return>") (kbd "C-a <return> C-p"))
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

(defun delete-line (&optional arg)
  (interactive "P")
  (flet ((kill-region (begin end)
                      (delete-region begin end)))
    (kill-whole-line arg)))


(autoload 'copy-from-above-command "misc"
    "Copy characters from previous nonblank line, starting just above point.

  \(fn &optional arg)"
    'interactive)


(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

 (defun duplicate-line ()
   (interactive)
   (forward-line 1)
   (open-line 1)
   (copy-from-above-command))


(global-set-key (kbd "M-e") 'smex)
(global-set-key (kbd "M-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-z") (kbd "C-_"))
(global-set-key (kbd "M-w") (kbd "C-X k"))
(global-set-key (kbd "M-a") (kbd "C-x h"))
(global-set-key (kbd "M-q") (kbd "C-x C-c"))
(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (call-interactively 'goto-line))
    (linum-mode -1)))
(global-set-key (kbd "M-l") 'goto-line-with-feedback)

(global-set-key (kbd "M-f")  'isearch-forward)
(define-key isearch-mode-map (kbd "M-f") 'isearch-repeat-forward)

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

(provide 'keybindings)
