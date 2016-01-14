(defvar *lisp-mode-hooks*
  '(scheme-mode-hook
    emacs-lisp-mode-hook
    lisp-mode-hook
    clojure-mode-hook))

(use-package rainbow-delimiters
  :ensure t
  :config
  (dolist (x *lisp-mode-hooks*)
    (add-hook x 'rainbow-delimiters-mode)))

(use-package paredit
  :ensure t
  :bind ("M-)" . paredit-forward-slurp-sexp)
  :config
  (dolist (x *lisp-mode-hooks*)
    (add-hook x 'enable-paredit-mode))
  (use-package paredit-extra))
