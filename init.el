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
    auto-complete
    auto-complete-clang-async
    color-theme-solarized
    cyberpunk-theme
    zenburn-theme
    clojure-mode
    python-mode
    geiser
    ipython
    org
    org2blog
    markdown-mode+
    nrepl
    ac-nrepl
    nrepl-eval-sexp-fu
    align-cljlet
    yasnippet
    undo-tree
    expand-region
    textmate
    zencoding-mode
    ack
    powerline))

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
