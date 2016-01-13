(use-package magit
  :ensure t
  :bind (("C-x g s" . magit-status)
         ("C-x g l" . magit-log)
         ("C-x g L" . magit-log-buffer-file)
         ("C-x g b" . magit-blame)
         ("C-x g r" . magit-rebase)
         ("C-x g R" . magit-rebase-interactive)
         ("C-x g c" . magit-checkout)
         ("C-x g B" . magit-branch-manager))

  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))
