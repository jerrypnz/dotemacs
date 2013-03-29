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
    auto-complete
    color-theme-solarized
    clojure-mode
    python-mode
    ipython
    org
    org2blog
    nrepl
    ac-nrepl
    nrepl-eval-sexp-fu
    align-cljlet
    yasnippet
    undo-tree
    expand-region
    textmate
    zencoding-mode
    ack))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path (concat user-emacs-directory "lib") t)
(add-to-list 'load-path (concat user-emacs-directory "pymacs-0.25") t)

(defvar my-conf-dir (concat user-emacs-directory "conf.d"))
(byte-recompile-directory my-conf-dir 0)

(mapc (lambda (filename)
        (load filename nil nil t))
      (directory-files my-conf-dir t "\\.elc$"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(ansi-term-color-vector [unspecified "#1F1611" "#660000" "#144212" "#EFC232" "#5798AE" "#BE73FD" "#93C1BC" "#E6E1DC"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(cursor-color "#839496")
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "8281168b824a806489ca7d22e60bb15020bf6eecd64c25088c85b3fd806fc341" "edb4ea9f96208f1691d6a6ebb70498257d1466058f7907ac0f4966da101101e2" default)))
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#452E2E")
 '(foreground-color "#839496")
 '(org-agenda-files (quote ("~/org/notes.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
