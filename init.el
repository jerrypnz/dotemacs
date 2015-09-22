(setq gc-cons-threshold 100000000)
;; Better defaults
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq inhibit-startup-screen t)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      ediff-window-setup-function 'ediff-setup-windows-plain
      save-place-file (concat user-emacs-directory "places"))

;; Packages

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(defvar my-packages
  '(helm
    helm-ag
    helm-projectile
    helm-gtags
    magit
    projectile
    multiple-cursors
    ace-jump-mode
    autopair
    cyberpunk-theme
    zenburn-theme
    ample-zen-theme
    company
    clojure-mode
    cider
    elpy
    geiser
    org
    markdown-mode+
    clj-refactor
    nrepl-eval-sexp-fu
    align-cljlet
    yasnippet
    undo-tree
    expand-region
    zencoding-mode
    ack
    scala-mode2
    sbt-mode
    php-mode
    web-mode
    haskell-mode
    dockerfile-mode
    puppet-mode
    powerline
    diminish
    color-theme-sanityinc-tomorrow
    whitespace-cleanup-mode
    monokai-theme))

(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
                '((cider              . "melpa-stable")
                  (clojure-mode       . "melpa-stable")
                  (clj-refactor       . "melpa-stable")
                  (scala-mode2        . "melpa-stable")
                  (rainbow-delimiters . "melpa-stable")
                  (helm               . "melpa")
                  (helm-projectile    . "melpa")
                  (projectile         . "melpa"))))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

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

(setq gc-cons-threshold 1000000)
