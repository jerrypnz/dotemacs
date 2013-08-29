;; The indentation style
(setq c-default-style "java"
      c-basic-offset 4)

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable
        (concat user-emacs-directory "clang-complete"))
  (add-to-list 'ac-sources 'ac-source-clang-async)
  (ac-clang-launch-completion-process))

(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
