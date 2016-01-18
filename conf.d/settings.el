;; Color theme
;(require 'birds-of-paradise-plus-theme)

;;(load-theme 'ample-zen t)
;;(load-theme 'solarized-light t)
;;(load-theme 'zenburn t)
;(load-theme 'sanityinc-tomorrow-eighties t)

;; (setq evil-default-cursor t)

;; Setting fonts for GUI emacs
(if (and (eq system-type 'gnu/linux) (display-graphic-p))
    (progn
      (set-face-attribute
       'default nil :font "Source Code Pro Bold 9")))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "WenQuanYi Micro Hei Mono Light"
                               :size 14)))

;; Change auto-save dir
(defvar my-backup-dir (concat temporary-file-directory "emacs-backup"))

(setq backup-directory-alist
      `((".*" . ,my-backup-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,my-backup-dir t)))

(if (not (file-accessible-directory-p my-backup-dir))
    (make-directory my-backup-dir))

;; Delete selected text
(delete-selection-mode t)

;; RET to newline-and-indent
(defun set-newline-and-indent-key ()
  (local-set-key (kbd "RET") 'reindent-then-newline-and-indent))

(mapc (lambda (hook) (add-hook hook 'set-newline-and-indent-key))
      '(c-mode-common-hook
        js-mode-hook))

;; Powerline
;;(require 'powerline)
;;(powerline-default-theme)
;
; (custom-set-faces
;  '(mode-line ((t (:background "#0088cc" :foreground "white" :box nil))))
;  '(mode-line-inactive ((t (:box nil)))))

;; XML indentation
(setq nxml-child-indent 4)

;; Auto revert
(global-auto-revert-mode t)

;; Smooth scrolling
(setq scroll-margin 10
      scroll-step 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      redisplay-dont-pause t)
(setq-default scroll-up-aggressively 0.01
              scroll-down-aggressively 0.01)

;; Keep isearch highlight, and use a keybinding to clear it manually
(setq lazy-highlight-cleanup nil)
(global-set-key (kbd "C-&") 'lazy-highlight-cleanup)

;; Join lines
(global-set-key (kbd "C-c q") 'join-line)

;; Fullscreen on Mac
(global-set-key (kbd "C-x 9") 'toggle-frame-fullscreen)
