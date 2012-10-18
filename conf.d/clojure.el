;; (eval-after-load 'clojure-mode
;;   '(font-lock-add-keywords
;;     'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "λ")
;;                                nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "ƒ")
                               nil))))))

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "∈")
                               nil))))))


(require 'clojure-mode)
(require 'rainbow-delimiters)


(add-hook 'clojure-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (rainbow-delimiters-mode)
            (add-to-list 'ac-sources 'ac-source-yasnippet)
            (setq buffer-save-without-query t)))


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

(define-key clojure-mode-map (kbd "M-t") 'live-transpose-words-with-hyphens)

(setq auto-mode-alist (append '(("\\.cljs$" . clojure-mode))
                              auto-mode-alist))

(dolist (x '(scheme emacs-lisp lisp))
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'enable-paredit-mode)
  (add-hook (intern (concat (symbol-name x) "-mode-hook")) 'rainbow-delimiters-mode))

(defun live-windows-hide-eol ()
 "Do not show ^M in files containing mixed UNIX and DOS line endings."
 (interactive)
 (setq buffer-display-table (make-display-table))
 (aset buffer-display-table ?\^M []))


(when (eq system-type 'windows-nt)
  (add-hook 'nrepl-mode-hook 'live-windows-hide-eol ))

(add-hook 'nrepl-interaction-mode-hook
          (lambda ()
            (nrepl-turn-on-eldoc-mode)
            (enable-paredit-mode)))

(add-hook 'nrepl-mode-hook
          (lambda ()
            (nrepl-turn-on-eldoc-mode)
            (enable-paredit-mode)
            (define-key nrepl-mode-map
              (kbd "{") 'paredit-open-curly)
            (define-key nrepl-mode-map
              (kbd "}") 'paredit-close-curly)))

(setq nrepl-popup-stacktraces nil)
;; (add-to-list 'same-window-buffer-names "*nrepl*")

;;Auto Complete
;;(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
;;(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

(defun clojure-complete ()
  (interactive)
  (auto-complete '(ac-source-nrepl-ns
                   ac-source-nrepl-vars
                   ac-source-nrepl-ns-classes
                   ac-source-nrepl-all-classes
                   ac-source-nrepl-java-methods
                   ac-source-nrepl-static-methods)))

(add-hook 'nrepl-mode-hook
          (lambda ()
            (local-set-key (kbd "M-/") 'clojure-complete)
            (local-set-key (kbd "C-M-/" 'hippie-expand))))
(add-hook 'nrepl-interaction-mode-hook
          (lambda ()
            (local-set-key (kbd "M-/") 'clojure-complete)
            (local-set-key (kbd "C-M-/" 'hippie-expand))))
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

;; highlight expression on eval
(require 'highlight)
(require 'nrepl-eval-sexp-fu)
(setq nrepl-eval-sexp-fu-flash-duration 0.5)

