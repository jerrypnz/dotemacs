;; Custom stuff to the scala layer

(setq jp-scala-packages
      '(scala-mode2))


(defun jp-scala/pre-init-scala-mode2 ()

  (spacemacs|use-package-add-hook scala-mode2
    :post-config

    (defun scala//in-multiline-string-p ()
      "Return t if current point is in a multiline string"
      (let* ((state (syntax-ppss))
             (is-string (nth 3 state))
             (start (nth 8 state)))
        (and is-string
             (string= "\"\"\"" (buffer-substring start (+ start 3))))))

    (defun scala/insert-margin-on-multiline-string ()
      "Insert margin `|' and indent the line if we are in a multiline string.
Only works when previous line contains a margin. Remember to add `stripMargin' to
the end of your string."
      (interactive)
      (when (scala//in-multiline-string-p)
        (let ((prev-line (buffer-substring-no-properties
                          (line-beginning-position 0)
                          (line-end-position 0))))
          (message prev-line)
          (when (string-match "^[[:space:]]*|" prev-line)
            (insert (match-string-no-properties 0 prev-line))))))

    (defun scala/newline-and-indent-with-pipe ()
      (interactive)
      (scala/newline-and-indent-with-asterisk)
      (scala/insert-margin-on-multiline-string))

    (define-key scala-mode-map (kbd "RET") 'scala/newline-and-indent-with-pipe)

    )
  )
