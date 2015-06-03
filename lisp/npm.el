;;; npm.el ---                                       -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Jakob Lind

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

;;

;;; Code:

(setq npm-vars-new-dependency ""
      npm-vars-run "")

(defun npm-install ()
  "Install all dependencies"
  (interactive)
  (message "Installing dependencies...  (Check *npm* for the output)")
  (start-process "npm-install" "*npm*" "npm" "install")
  )


(defun npm-new-dependency ()
  "Install and save new dependency"
  (interactive)
  (setq npm-vars-new-dependency (read-from-minibuffer "New dependency (e.g: minimist): " npm-vars-new-dependency))
  (message (concat "Installing " npm-vars-new-dependency))
  (start-process "npm-install" "*npm*" "npm" "install" "--save" npm-vars-new-dependency)
  )

(defun npm-run ()
  "run a task"
  (interactive)
  (setq npm-vars-run (read-from-minibuffer "Name of task: " npm-vars-run))
  (message (concat "running " npm-vars-run))
  (start-process "npm-run" "*npm*" "npm" "run" npm-vars-run)
  )

(defun npm-deploy-preprod ()
  "run a task"
  (interactive)
  (message (concat "Deploying to preprod..."))
  (start-process "npm-run" "*npm-deploy*" "npm" "run" "deploy:preprod")
  )

(provide 'npm)
;;; npm.el ends here
