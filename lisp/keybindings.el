;;; jakobs functions
;;TODO
; fix scrolling
; mulitple cursors sux
; duplicate should be able to duplicate the exact selection
; when opening a new window, move focus to it

;; file navigation
(global-set-key (kbd "M-o") 'helm-projectile)
(global-set-key (kbd "M-i") 'projectile-display-buffer)
(global-set-key (kbd "M-b") 'ido-switch-buffer)


(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-c C-i") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

(global-set-key (kbd "C-c C-s") 'magit-status)

;; Window navigation
(global-set-key (kbd "M-1") (lambda () (interactive) (delete-other-windows)))
(global-set-key (kbd "M-2") (lambda () (interactive) (split-window-below)))
(global-set-key (kbd "M-3") (lambda () (interactive) (split-window-right)))
(global-set-key (kbd "M-4") (lambda () (interactive) (delete-window)))
(global-set-key (kbd "M-§") 'other-window)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "M-`") 'winner-undo)
(global-set-key (kbd "M-~") 'winner-redo)


;(windmove-up)

;; code navigation

; move camelcase
(global-subword-mode 1)

(defun forward-symbol-shift-aware (arg)
  "`forward-symbol', with shift-select-mode support.
Shift + this command's key extends/activates the region
around the text moved over."
  (interactive "^p")
  (forward-symbol arg))

(defun move-end-of-line-shift-aware (arg)
  "`forward-symbol', with shift-select-mode support.
Shift + this command's key extends/activates the region
around the text moved over."
  (interactive "^p")
  (move-end-of-line arg))

(global-set-key (kbd "C-<up>") 'er/expand-region)
(global-set-key (kbd "C-<down>") 'er/contract-region)
(global-set-key (kbd "s-<down>") 'er/contract-region)
(global-set-key (kbd "s-<up>") 'er/expand-region)
(global-set-key (kbd "s-<left>") (lambda () (interactive "^")
                                  (forward-symbol-shift-aware -1)))
(global-set-key (kbd "s-<right>") 'forward-symbol-shift-aware)

(defun delete-word-no-kill (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word-no-kill (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-word-no-kill (- arg)))

(global-set-key (kbd "s-<backspace>") 'backward-delete-word-no-kill)

(global-set-key (kbd "M-<left>") 'smarter-move-beginning-of-line)
(global-set-key (kbd "M-<right>") 'move-end-of-line-shift-aware)
(global-set-key (kbd "M-<up>") 'beginning-of-buffer)
(global-set-key (kbd "M-<down>") (kbd "M->"))
(global-set-key (kbd "C-s-<down>") (lambda () (interactive) (ignore-errors (next-line 5))))
(global-set-key (kbd "C-s-<up>") (lambda () (interactive) (ignore-errors (previous-line 5))))
(global-set-key (kbd "M-s-<down>") 'scroll-up-command)
(global-set-key (kbd "M-s-<up>") 'scroll-down-command)
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


(global-set-key (kbd "M-e") 'helm-M-x)
(global-set-key (kbd "M-d") 'duplicate-current-line-or-region)
(global-set-key (kbd "M-s") 'save-buffer)
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "M-z") 'undo-tree-undo)
(global-set-key (kbd "M-w")
        '(lambda () (interactive)
           (let (kill-buffer-query-functions) (kill-buffer))))

(global-set-key (kbd "M-a") 'mark-whole-buffer)
(global-set-key (kbd "M-q") (kbd "C-x C-c"))

(global-set-key (kbd "M-h") 'highlight-symbol)
(global-set-key (kbd "M-j") (lambda () (interactive) (join-line -1)))

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
(define-key isearch-mode-map (kbd "<down>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<up>") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "<return>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<esc>") 'isearch-exit)
(define-key isearch-mode-map (kbd "M-v") 'isearch-yank-pop)

; text
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
   (move-text-internal (- arg))
   (previous-line))

(global-set-key (kbd "M-S-<down>") 'move-text-down)
(global-set-key (kbd "M-S-<up>") 'move-text-up)

(provide 'keybindings)
