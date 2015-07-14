;; Color theme
;(require 'birds-of-paradise-plus-theme)

;;(load-theme 'ample-zen t)
;;(load-theme 'solarized-light t)
;;(load-theme 'zenburn t)
(load-theme 'sanityinc-tomorrow-eighties t)

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

;; Undo tree
(global-undo-tree-mode)

;; Delete selected text
(delete-selection-mode t)

;; TextMate minor mode
; (eval-after-load 'textmate
;   '(progn
;      (define-key *textmate-mode-map* [(meta return)] nil)
;      (define-key *textmate-mode-map* [(control c) (control k)] nil)
;      (define-key *textmate-mode-map* [(control c) (control t)] nil)))
;
; (textmate-mode)
; (add-to-list '*textmate-project-roots* "project.clj")
; (add-to-list '*textmate-project-roots* "setup.py")
; (add-to-list '*textmate-project-roots* ".ropeproject")
; (add-to-list '*textmate-project-roots* ".project")
; (add-to-list '*textmate-project-roots* "build.xml")
; (add-to-list '*textmate-project-roots* "pom.xml")
; (add-to-list '*textmate-project-roots* "build.gradle")
; (add-to-list '*textmate-project-roots* "build.sbt")

;; Ack. use textmate project root as ack root dir

;; IDO hacks
;; Display ido results vertically, rather than horizontally
;(setq ido-decorations
;      (quote ("\n-> "
;              """\n   " "\n   ..." "[" "]"
;              " [No match]" " [Matched]"
;              " [Not readable]" " [Too big]"
;              " [Confirm]")))
;(defun ido-disable-line-trucation ()
;  (set (make-local-variable 'truncate-lines) nil))
;(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)


;; RET to newline-and-indent
(defun set-newline-and-indent-key ()
  (local-set-key (kbd "RET") 'reindent-then-newline-and-indent))

(mapc (lambda (hook) (add-hook hook 'set-newline-and-indent-key))
      '(c-mode-common-hook
        js-mode-hook))

;; Turn on auto pair for certain modes
(defun turn-on-autopair-mode ()
  (autopair-mode 1))

(mapc (lambda (hook) (add-hook hook 'turn-on-autopair-mode))
      '(python-mode-hook
        c-mode-common-hook
        ruby-mode-hook
        js-mode-hook
        scala-mode-hook))

;; Company Mode
(add-hook 'after-init-hook 'global-company-mode)
(setq company-idle-delay 0)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Powerline
;;(require 'powerline)
;;(powerline-default-theme)
;
; (custom-set-faces
;  '(mode-line ((t (:background "#0088cc" :foreground "white" :box nil))))
;  '(mode-line-inactive ((t (:box nil)))))

;; Zen-coding
(require 'zencoding-mode)
(setq zencoding-indentation 2)
(add-hook 'sgml-mode-hook 'zencoding-mode)

;; Cleanup spaces on save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; XML indentation
(setq nxml-child-indent 4)

;; Auto revert
(global-auto-revert-mode t)

;; Magit
(setq magit-last-seen-setup-instructions "1.4.0")

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

;; ===== Custom keybindings ====
;;
;; Buffer and window switching
;;(global-set-key (kbd "C-,") 'previous-buffer)
;;(global-set-key (kbd "C-.") 'next-buffer)

;; Expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Join lines
(global-set-key (kbd "C-c q") 'join-line)

;; Magit
(global-set-key (kbd "C-x g s") 'magit-status)
(global-set-key (kbd "C-x g l") 'magit-log)
(global-set-key (kbd "C-x g L") 'magit-log-buffer-file)
(global-set-key (kbd "C-x g b") 'magit-blame)
(global-set-key (kbd "C-x g r") 'magit-rebase)
(global-set-key (kbd "C-x g R") 'magit-rebase-interactive)
(global-set-key (kbd "C-x g c") 'magit-checkout)
(global-set-key (kbd "C-x g B") 'magit-branch-manager)

;; Helm AG
(global-set-key (kbd "C-x a") 'projectile-helm-ag)

;; Ace Jump Mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'custom-hack)
;; Keybindings for custom hacks
(global-set-key (kbd "C-o") 'start-newline-next)
(global-set-key (kbd "M-o") 'start-newline-prev)
(global-set-key (kbd "C-:") 'toggle-clj-keyword-string)
(global-set-key (kbd "C-*") 'isearch-forward-at-point)
