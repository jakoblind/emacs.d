(require 'scala-mode2)
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(define-key scala-mode-map (kbd "M-s-<left>") 'ensime-pop-find-definition-stack)
;;ensime-inspect-type-at-point

(provide 'scala)
