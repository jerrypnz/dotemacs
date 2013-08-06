;; Add functions to Vi-like behaviors

(defun start-newline-next ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun start-newline-prev ()
  (interactive)
  (if (eq (forward-line -1) 0)
      (start-newline-next)
    (progn
      (message "begin new line at the start")
      (beginning-of-line)
      (newline)
      (forward-line -1))))

(defun copy-line-buttom ()
  (interactive)
  (beginning-of-line)
  (kill-line)
  (yank)
  (newline)
  (yank))

(defun char-at-point ()
  (interactive)
  (buffer-substring-no-properties (point) (+ 1 (point))))

(defun clj-string-name (s)
  (substring s 1 -1))

(defun clj-keyword-name (s)
  (substring s 1))

(defun delete-and-extract-sexp ()
  (let* ((begin (point)))
    (forward-sexp)
    (let* ((result (buffer-substring-no-properties begin (point))))
      (delete-region begin (point))
      result)))

(defun toggle-clj-keyword-string ()
  (interactive)
  (save-excursion
    (if (equal 1 (point))
        (message "beginning of file reached, this was probably a mistake.")
      (cond ((equal "\"" (char-at-point))
             (insert ":" (clj-string-name (delete-and-extract-sexp))))
            ((equal ":" (char-at-point))
             (insert "\"" (clj-keyword-name (delete-and-extract-sexp)) "\""))
            (t (progn
                 (backward-char)
                 (toggle-clj-keyword-string)))))))

(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region
     (mark)
     (point)
     "xmllint --format -"
     (buffer-name) t)))

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region
     (mark)
     (point)
     "python -m json.tool"
     (buffer-name) t)))

(defun get-word-under-cursor ()
  (let* ((current-point (point))
         (word-start (progn (skip-syntax-backward "w_")
                            (point)))
         (word-end (progn (skip-syntax-forward "w_")
                          (point)))
         (word (buffer-substring word-start word-end)))
    (goto-char current-point)
    word))

(require 'ack)

(defun ack-current-word ()
  (interactive)
  (let ((word (get-word-under-cursor)))
    (if (string= word "")
        (message "No word found under cursor")
      (ack (concat "ack " word)))))

(defun search-word-under-cursor ()
  (interactive)
  (let ((word (get-word-under-cursor)))
    (if (string= word "")
        (message "No word found under cursor")
      (progn
        (isearch-search)
        (isearch-yank-string word)))))

(provide 'custom-hack)

