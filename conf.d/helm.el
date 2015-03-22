(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

; rebind tab to run persistent action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
; make TAB works in terminal
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
; list actions using C-z
(define-key helm-map (kbd "C-z")  'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

;; open helm buffer inside current window, not occupy whole other window
;; move to end or beginning of source when reaching top or bottom of source.
;; search for library in `require' and `declare-function' sexp.
;; scroll 8 lines other window using M-<next>/M-<prior>
(setq helm-split-window-in-side-p           t
      helm-move-to-line-cycle-in-source     t
      helm-ff-search-library-in-sexp        t
      helm-scroll-amount                    8
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

;; customize
(custom-set-variables
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t)
 '(helm-gtags-suggested-key-mapping t))

;; key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-find-tag-from-here)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

;; helm-ag
(setq helm-ag-base-command "ag --nocolor --nogroup")
(setq helm-ag-command-option "--all-text")
(setq helm-ag-insert-at-point 'symbol)

(defun projectile-helm-ag ()
  (interactive)
  (helm-ag (projectile-project-root)))

(global-set-key (kbd "C-M-f") 'projectile-helm-ag)
