(setq jp-cypher-packages
      '(cypher-mode))

(defun jp-cypher/init-cypher-mode ()
  (use-package cypher-mode
    :config

    (define-key cypher-mode-map
      (kbd "RET") 'electric-newline-and-maybe-indent))

  )
