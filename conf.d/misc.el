(use-package company
  :ensure t
  :pin melpa-stable

  :config
  (global-company-mode)
  (setq company-idle-delay 0))

(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-c SPC" . ace-jump-mode))

(use-package zencoding-mode
  :ensure t
  :config
  (setq zencoding-indentation 2)
  (add-hook 'sgml-mode-hook 'zencoding-mode))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package autopair
  :ensure t
  :config
  (defun turn-on-autopair-mode ()
    (autopair-mode 1))

  (mapc (lambda (hook) (add-hook hook 'turn-on-autopair-mode))
        '(python-mode-hook
          c-mode-common-hook
          ruby-mode-hook
          js-mode-hook
          scala-mode-hook)))

(use-package whitespace-cleanup-mode
  :ensure t
  :config
  (global-whitespace-cleanup-mode))

(use-package custom-hack
  :commands xml-format
  :bind (("C-o" . start-newline-next)
         ("M-o" . start-newline-prev)
         ("C-:" . toggle-clj-keyword-string)
         ("C-x g u" . git/browse-repo)))
