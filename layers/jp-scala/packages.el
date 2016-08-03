;; Custom stuff to the scala layer

(setq jp-scala-packages
      '(scala-mode))

(defun jp-scala/pre-init-scala-mode ()

  (spacemacs|use-package-add-hook scala-mode
    :post-config

    (defun scala//in-multiline-string-p ()
      "Return t if current point is in a multiline string"
      (let* ((state (syntax-ppss))
             (is-string (nth 3 state))
             (start (nth 8 state)))
        (and is-string
             (string= "\"\"\"" (buffer-substring-no-properties start (+ start 3))))))

    (defun scala/insert-margin-on-multiline-string ()
      "Insert margin `|' and indent the line if we are in a multiline string.
Only works when previous line contains a margin. Remember to add `stripMargin' to
the end of your string."
      (when (scala//in-multiline-string-p)
        (let ((prev-line (buffer-substring-no-properties
                          (line-beginning-position 0)
                          (line-end-position 0)))
              (current-line (thing-at-point 'line)))
          (when (not (string-match-p "^[[:space:]]*|" current-line))
            (cond
             ;; We are in the middle of multiline string. Use the same indent
             ;; as previous line.
             ((string-match "^[[:space:]]*\\(|[[:space:]]*\\)" prev-line)
              (let ((prefix (match-string-no-properties 0 prev-line)))
                (beginning-of-line)
                (insert prefix)))

             ;; We are in the beginning of a multiline string. scala-mode supports
             ;; indent of multiline strings if it starts with a `|'.
             ((string-match "\"\"\"[[:space:]]*|" prev-line)
              (beginning-of-line)
              (insert "|")
              (indent-according-to-mode)))))))

    (defun scala/newline-and-indent-with-pipe ()
      (interactive)
      (scala/newline-and-indent-with-asterisk)
      (scala/insert-margin-on-multiline-string))

    (defun scala/insert-margin-befor-ending-parens ()
      (cond
       ((eq 'scala/newline-and-indent-with-pipe this-command)
        (save-excursion
          (forward-line 1)
          (scala/insert-margin-on-multiline-string)))

       ;; Thse two commands are defined in `jp-core' layer, which is like `o'
       ;; and `O' command in vim.
       ((or (eq 'jp/start-newline-next this-command)
            (eq 'jp/start-newline-prev this-command))
        (scala/insert-margin-on-multiline-string))))

    (define-key scala-mode-map (kbd "RET") 'scala/newline-and-indent-with-pipe)

    (add-hook 'scala-mode-hook
              (lambda ()
                ;; Add the hook to the end of the list and use buffer local hooks
                ;; because we want to enable this hook only in scala-mode.
                (add-hook 'post-command-hook 'scala/insert-margin-befor-ending-parens t t)))

    (setq ensime-startup-snapshot-notification nil)

    )
  )
