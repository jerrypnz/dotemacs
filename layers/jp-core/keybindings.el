;; Custom keybindings

;; Expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

;; Join lines
(global-set-key (kbd "C-c q") 'join-line)

;; Fullscreen on Mac
(global-set-key (kbd "C-x 9") 'toggle-frame-fullscreen)

;; Keybindings for custom functions
(global-set-key (kbd "C-o") 'jp/start-newline-next)
(global-set-key (kbd "M-o") 'jp/start-newline-prev)

;; Smartparens Strict mode
(define-key smartparens-strict-mode-map (kbd "M-<right>") 'sp-forward-slurp-sexp)
(define-key smartparens-strict-mode-map (kbd "M-<left>")  'sp-forward-barf-sexp)

(define-key smartparens-strict-mode-map (kbd "M-S-<right>")  'sp-backward-barf-sexp)
(define-key smartparens-strict-mode-map (kbd "M-S-<left>")  'sp-backward-slurp-sexp)
(define-key smartparens-strict-mode-map (kbd "M-<up>")    'sp-raise-sexp)
