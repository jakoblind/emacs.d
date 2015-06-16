(require 'org2blog)

(let (credentials)
  ;; only required if your auth file is not already in the list of auth-sources
  (add-to-list 'auth-sources "~/.netrc")
  (setq credentials (auth-source-user-and-password "blog.jakoblind.no"))
  (setq org2blog/wp-blog-alist
        `(("blog.jakoblind.no"
           :url "http://blog.jakoblind.no/xmlrpc.php"
           :username ,(car credentials)
           :password ,(cadr credentials)))))

(setq org2blog/wp-blog-alist
      '(("my-blog"
         :url "http://blog.jakoblind.no/xmlrpc.php"
         :username "jakob")))

(eval-after-load 'org-mode
  '(progn
     (define-key org-mode-map (kbd "M-e") 'smex)
     (define-key org-mode-map (kbd "M-x") 'smex)))


(provide 'blog)
