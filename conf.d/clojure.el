(use-package clojure-mode
  :ensure t
  :pin melpa-stable
  :mode (("\\.clj\\'" . clojure-mode)
         ("\\.cljs\\'" . clojure-mode))

  :config
  (font-lock-add-keywords
   'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "λ")
                              nil)))))

  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\)("
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "ƒ")
                              nil)))))

  (font-lock-add-keywords
   'clojure-mode `(("\\(#\\){"
                    (0 (progn (compose-region (match-beginning 1)
                                              (match-end 1) "∈")
                              nil)))))

  ;;Treat hyphens as a word character when transposing words
  (defvar clojure-mode-with-hyphens-as-word-sep-syntax-table
    (let ((st (make-syntax-table clojure-mode-syntax-table)))
      (modify-syntax-entry ?- "w" st)
      st))

  (defun live-transpose-words-with-hyphens (arg)
    "Treat hyphens as a word character when transposing words"
    (interactive "*p")
    (with-syntax-table clojure-mode-with-hyphens-as-word-sep-syntax-table
      (transpose-words arg)))

  (bind-keys :map clojure-mode-map
             ("M-t" . live-transpose-words-with-hyphens))

  (add-hook 'clojure-mode-hook
            (lambda ()
              (setq buffer-save-without-query t)))

  (defvar custom-my-let-style-forms '(fact facts))

  (dolist (sym custom-my-let-style-forms)
    (put-clojure-indent sym 1)))

(use-package cider
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'cider-repl-mode-hook 'subword-mode))

(use-package clj-refactor
  :ensure t
  :config
  (add-hook 'clojure-mode-hook (lambda() (clj-refactor-mode 1)))
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package nrepl-eval-sexp-fu
  :config
  (use-package highlight)
  (setq nrepl-eval-sexp-fu-flash-duration 0.5)
  (setq nrepl-hide-special-buffers t))
