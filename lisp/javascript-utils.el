;;; javascript-utils.el --- Utility functions for JavaScript coding  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Jakob Lind

;; Author: Jakob Lind <karl.jakob.lind@gmail.com>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Some functions that makes you JavaScript coding more smooth.

;;; Code:

(defun js/console-log ()
  "List all variables in the file, and console log the selected one"
  ;TODO: only show variables in scope at cursor point
  ;C-u should JSON.stringify it
  (interactive)
  (setq js2c--var-list (list))
  (js2-visit-ast
     js2-mode-ast
     (lambda (node end-p)
       (when (null end-p)
         (cond
          ((js2-var-init-node-p node)
           (let ((target (js2-var-init-node-target node))
                 (initializer (js2-var-init-node-initializer node)))
             (when target
               (let* ((parent (js2-node-parent node))
                      (grandparent (if parent (js2-node-parent parent)))
                      (inited (not (null initializer))))
                 (unless inited
                   (setq inited
                         (and grandparent
                              (js2-for-in-node-p grandparent)
                              (memq target
                                    (mapcar #'js2-var-init-node-target
                                            (js2-var-decl-node-kids
                                             (js2-for-in-node-iterator grandparent)))))))
                 (add-to-list 'js2c--var-list (js2-name-node-name target)))))))) t))
  (if (equal js2c--var-list nil)
      (message "No variables found. ")
    (let ((variable (ido-completing-read "Select variable: " js2c--var-list)))
      (js/--move-cursor-to-previous-line)
      (insert "console.log(\"" variable " = \", " variable ");"))))

(defun js/--move-cursor-to-previous-line ()
  "move cursor to previous line"
  (beginning-of-line)
  (newline-and-indent)
  (previous-line)
  (indent-according-to-mode))

(defun js/only (name)
  (save-excursion
    (search-backward (concat name "("))
    (forward-word)
    (insert ".only")
    (message (concat  "Inserted one " name ".only"))))

(defun js/x (name)
  (save-excursion
    (search-backward (concat name "("))
    (insert "x")
    (message (concat "Inserted one x" name ""))))

(defun js/remove-x-or-only (name)
  (save-excursion
    (if (search-backward (concat "x" name "(") 0 t)
        (progn (delete-forward-char 1) (message (concat "Deleted one x" name)))
      (if (search-backward (concat name ".only(") 0 t)
          (progn (forward-word) (kill-word 1) (message (concat "Deleted one " name ".only")))
        (message (concat "No " name ".only or x" name " found"))))))

(defun js/itonly (args)
  "find closest it and make it it.only"
  (interactive "P")
  (js/only "it"))

(defun js/xit (args)
  "find closest it and make it xit"
  (interactive "P")
  (js/x "it"))

(defun js/it (args)
  "find closest xit or it.only and make it to an it"
  (interactive "P")
  (js/remove-x-or-only "it"))

(defun js/describe-only (args)
  "find closest it and make it it.only"
  (interactive "P")
  (js/only "describe"))

(defun js/x-describe (args)
  "find closest it and make it xit"
  (interactive "P")
  (js/x "describe"))

(defun js/clean-describe (args)
  "find closest xit or it.only and make it to an it"
  (interactive "P")
  (js/remove-x-or-only "describe"))


(provide 'javascript-utils)
;;; javascript-utils.el ends here
