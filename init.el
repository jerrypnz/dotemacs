(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(starter-kit
    starter-kit-lisp
    starter-kit-eshell
    starter-kit-bindings
    iedit
    autopair
    color-theme-solarized
    cyberpunk-theme
    zenburn-theme
    clojure-mode
    elpy
    geiser
    org
    markdown-mode+
    cider
    nrepl-eval-sexp-fu
    align-cljlet
    yasnippet
    undo-tree
    expand-region
    textmate
    zencoding-mode
    ample-zen-theme
    ack))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path (concat user-emacs-directory "lib") t)

(defvar my-conf-dir (concat user-emacs-directory "conf.d"))
(byte-recompile-directory my-conf-dir 0)

(mapc (lambda (filename)
        (load filename nil nil t))
      (directory-files my-conf-dir t "\\.elc$"))
(put 'downcase-region 'disabled nil)
