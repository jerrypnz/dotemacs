;; Packages
(setq gc-cons-threshold 1000000)

(require 'package)
(setq package-enable-at-startup nil)
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(add-to-list 'load-path (concat user-emacs-directory "lib") t)

(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
        '((use-package  . "melpa-stable"))))

(defvar core-packages '(diminish bind-key))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (dolist (p core-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)

(defvar my-conf-dir (concat user-emacs-directory "conf.d"))
(byte-recompile-directory my-conf-dir 0)

(mapc (lambda (filename)
        (load filename nil nil t))
      (directory-files my-conf-dir t "\\.elc$"))

(put 'downcase-region 'disabled nil)
