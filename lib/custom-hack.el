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

(defun xml-format (use-xmllint-p)
  (interactive "P")
  (save-excursion
    (shell-command-on-region
     (mark)
     (point)
     (if use-xmllint-p
         "xmllint --format -"
       "tidy -utf8 -xml -i -w 76 --indent-attributes true 2>/dev/null")
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
      (ack (concat ack-command word)))))

;; I-search with initial contents.
;; original source: http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

;; Show the current repo+branch in github/bitbucket
(defun git/browse-repo (dir)
  (interactive
   (list (or (projectile-project-p)
             (projectile-completing-read "Project: " (projectile-relevant-known-projects)))))
  (unless (magit-git-repo-p dir)
    (user-error "Not a git repo"))

  (-let* (((remote . branch) (magit-get-remote-branch))
          (cmd (format "git config --get remote.%s.url" remote))
          (remote-url (s-trim (shell-command-to-string cmd)))
          ((_input _prot _user host _port filepath _suffix)
           (s-match (rx (? (group (+? nonl)) "://")
                        (? (group (+? nonl)) "@")
                        (group (+ (not (any "/" ":"))))
                        (? ":" (group (+ digit)) "/")
                        (? ":")
                        (group (* nonl))
                        (group ".git"))
                    remote-url))
          (url
           (pcase host
             (`"bitbucket.org"
              (format "https://bitbucket.org/%s/src/%s" filepath branch))
             (`"github.com"
              (format "https://github.com/%s/tree/%s" filepath branch))
             (host
              (error "Don't know how to browse URL for host: %s" host)))))
    (browse-url url)))

(provide 'custom-hack)
