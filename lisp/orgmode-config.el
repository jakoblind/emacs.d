;;; orgmode-config.el --- My org mode config         -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Jakob Lind

;; Author: Jakob Lind <karl.jakob.lind@gmail.com>
;; Keywords:

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

;; Org mode config

;;; Code:

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "cyan" :bold t :background nil))))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
         "* TODO %?\n %i\n")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n %i\n")))

(defun insert-heading-and-date ()
  "insert a org level 1 heading and date"
  (interactive "")
  (unwind-protect
      ;; if we alread are at top level, dont crash
      (outline-up-heading 4)
    (progn (org-insert-heading-after-current)
           (insert-date nil))))

(define-key org-mode-map (kbd "C-u RET") 'insert-heading-and-date)

(global-set-key (kbd "C-c c") 'org-capture)

(defun insert-date (prefix)
    "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%Y-%m-%d")
                   ((equal prefix '(16)) "%A, %d. %B %Y"))))
      (insert (format-time-string format))))

(defun insert-time (prefix)
    "Insert the current time"
    (interactive "P")
    (let ((format (cond
                   ((not prefix) "%H:%M:%S")
                   ((equal prefix '(4)) "%H:%M:%S %z"))))
      (insert (format-time-string format))))

;;;TODO: we could consider moving these two function somewhere else
(defun jakob/string-to-filename (string)
  "docstring"
  (replace-regexp-in-string "[^a-zA-z-]" "" (replace-regexp-in-string " " "-" (downcase string))))

(defun create-blog-file (header categories)
  "Create a new blog file that can be used in github pages"
  (interactive "sHeader:
sCategories: ")
  (let ((dateToday (format-time-string "%Y-%m-%d"))
        (fullDateToday (format-time-string "%Y-%m-%d %H:%M:%S %z")))
    (find-file
     (concat
      (projectile-project-root) "_posts/"  dateToday "-" (jakob/string-to-filename header) ".markdown"))
    (insert "---
layout: post
title: \"" header "\"
date:   " fullDateToday "
categories: " categories "
---
")))


(provide 'orgmode-config)
;;; orgmode-config.el ends here
