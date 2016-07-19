;;; appearance.el ---                                -*- lexical-binding: t; -*-

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

;;

;;; Code:

;; smart mode line
(sml/setup)
(setq sml/theme nil)

(load-theme 'noctilux t)
;;(disable-theme 'noctilux)

;; Increase font size, (and something else?)
(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :weight 'normal
                    :height 130
                    )
;;(set-face-attribute 'default nil :height 120)

;; Highlight current line
(global-hl-line-mode 1)
(hl-line-mode)
;;(set-face-background hl-line-face "darkblue" )


;; bell - make it flash background red instead of make a noise
(setq visible-bell nil)

(make-face 'flash-active-buffer-face)
(set-face-attribute 'flash-active-buffer-face nil
                    :background "red"
                    :foreground "black")
(defun flash-active-buffer ()
  (interactive)
  (run-at-time "100 millisec" nil
               (lambda (remap-cookie)
                 (face-remap-remove-relative remap-cookie))
               (face-remap-add-relative hl-line-face 'flash-active-buffer-face)))

(setq ring-bell-function 'flash-active-buffer)

;show line number in footer
(column-number-mode 1)

;; Color of mode-line, the thing at the bottom of all windows
(set-face-attribute 'mode-line
                 nil
;;                 :foreground "Black"
;;                 :background "Black"
                 ;;:box '(:line-width 1 :style released-button)
                 )

(set-face-attribute 'mode-line-inactive
                    nil
;;                    :foreground "#aaccff"
;;                    :background "Black"
;;                    :box '(:line-width 1 :style released-button)
                    )

(global-visual-line-mode 1)

(setq highlight-symbol-idle-delay 0)

(setq speedbar-use-images nil
      sr-speedbar-right-side nil
      speedbar-show-unknown-files t
      sr-speedbar-width 10
      sr-speedbar-max-width 10
      sr-speedbar-default-width 10
      sr-speedbar-skip-other-window-p t)

;;(sr-speedbar-open)


(provide 'appearance)
;;; appearance.el ends here
