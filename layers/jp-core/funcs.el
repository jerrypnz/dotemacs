;; Custom functions

(defun jp/start-newline-next ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun jp/start-newline-prev ()
  (interactive)
  (if (eq (forward-line -1) 0)
      (jp/start-newline-next)
    (progn
      (message "Begin new line at the start")
      (beginning-of-line)
      (newline)
      (forward-line -1))))

(defun jp/xml-format (use-xmllint-p)
  (interactive "P")
  (save-excursion
    (shell-command-on-region
     (mark)
     (point)
     (if use-xmllint-p
         "xmllint --format -"
       "tidy -utf8 -xml -i -w 76 --indent-attributes true 2>/dev/null")
     (buffer-name) t)))

(defun jp/json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region
     (mark)
     (point)
     "python -m json.tool"
     (buffer-name) t)))
