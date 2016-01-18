(use-package helm
  :ensure t
  :pin melpa
  :bind (("C-c r" . helm-resume)
         ("C-*"   . helm-occur))

  :init
  (helm-mode 1)

  :config
  (setq helm-split-window-in-side-p           t
        helm-move-to-line-cycle-in-source     t
        helm-ff-search-library-in-sexp        t
        helm-scroll-amount                    8
        helm-ff-file-name-history-use-recentf t)

  (bind-key "C-c h" 'helm-command-prefix)
  (unbind-key "C-x c")
  (bind-keys :map helm-map
             ("<tab>" . helm-execute-persistent-action)
             ("C-i"   . helm-execute-persistent-action)
             ("C-z"   . helm-select-action))

  (use-package helm-gtags
    :ensure t
    :pin melpa
    :bind (("M-t"   . helm-gtags-find-tag)
           ("M-r"   . helm-gtags-find-rtag)
           ("M-s"   . helm-gtags-find-symbol)
           ("C-c <" . helm-gtags-previous-history)
           ("C-c >" . helm-gtags-next-history)
           ("M-."   . helm-gtags-find-tag-from-here)
           ("M-,"   . helm-gtags-pop-stack))

    :config
    (custom-set-variables
     '(helm-gtags-ignore-case t)
     '(helm-gtags-auto-update t)
     '(helm-gtags-suggested-key-mapping t))

    (mapc (lambda (h)
            (add-hook h 'helm-gtags-mode))
          '(java-mode-hook
            scala-mode-hook
            c-mode-common-hook)))

  (use-package helm-ag
    :ensure t
    :commands helm-ag
    :config
    (setq helm-ag-base-command "ag --nocolor --nogroup")
    (setq helm-ag-insert-at-point 'symbol)

    (defun projectile-helm-ag ()
      (interactive)
      (helm-ag (projectile-project-root)))

    (bind-key "C-x a" 'projectile-helm-ag)))


(use-package projectile
  :ensure t
  :pin melpa

  :bind ("M-y" . helm-show-kill-ring)

  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t)

  (use-package helm-projectile
    :ensure t
    :config
    (helm-projectile-on)))
