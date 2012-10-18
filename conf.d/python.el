;; Python mode
;; Refer to http://www.emacswiki.org/emacs/ProgrammingWithPythonModeDotEl
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")))
(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)

(defun py-next-block ()
  "go to the next block.  Cf. `forward-sexp' for lisp-mode"
  (interactive)
  (py-mark-block nil 't)
  (back-to-indentation))

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

(setq python-check-command "pyflakes")

;; ropemacs completion
(require 'auto-complete-python)

(defun ropemacs-complete ()
  (interactive)
  (auto-complete '(ac-source-nropemacs-dot)))

(defun ropemacs-dot-command ()
  (interactive)
  (self-insert-command 1)
  (auto-complete '(ac-source-nropemacs-dot)))


(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd ".") 'ropemacs-dot-command)
            (local-set-key (kbd "M-/") 'ropemacs-complete)
            (local-set-key (kbd "C-M-/" 'hippie-expand))))
