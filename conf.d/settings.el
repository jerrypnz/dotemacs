
;; Color theme
(require 'birds-of-paradise-plus-theme)
(load-theme 'birds-of-paradise-plus t)

;; (setq evil-default-cursor t)

;; Setting fonts for GUI emacs
(if (display-graphic-p)
    (progn
      (set-face-attribute
       'default nil :font "Source Code Pro 9")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "文泉驿等宽微米黑"
                                     :size 13
                                     :weight 'light)))))

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

;; TextMate minor mode
(eval-after-load 'textmate
  '(progn
     (define-key *textmate-mode-map* [(meta return)] nil)
     (define-key *textmate-mode-map* [(control c) (control k)] nil)
     (define-key *textmate-mode-map* [(control c) (control t)] nil)))

(textmate-mode)
(add-to-list '*textmate-project-roots* "project.clj")
(add-to-list '*textmate-project-roots* "setup.py")
(add-to-list '*textmate-project-roots* ".ropeproject")
(add-to-list '*textmate-project-roots* ".project")
(add-to-list '*textmate-project-roots* "build.xml")
(add-to-list '*textmate-project-roots* "pom.xml")
(add-to-list '*textmate-project-roots* "build.gradle")

;; Ack. use textmate project root as ack root dir
(defun get-project-dir (arg)
  (textmate-project-root))

(setq ack-default-directory-function 'get-project-dir)

;; IDO hacks
;; Display ido results vertically, rather than horizontally
(setq ido-decorations
      (quote ("\n-> "
              """\n   " "\n   ..." "[" "]"
              " [No match]" " [Matched]"
              " [Not readable]" " [Too big]"
              " [Confirm]")))
(defun ido-disable-line-trucation ()
  (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)


;; RET to newline-and-indent
(defun set-newline-and-indent-key ()
  (local-set-key (kbd "RET") 'reindent-then-newline-and-indent))

(mapc (lambda (hook) (add-hook hook 'set-newline-and-indent-key))
      '(c-mode-common-hook))

;; Turn on auto pair for certain modes
(defun turn-on-autopair-mode ()
  (autopair-mode 1))

(mapc (lambda (hook) (add-hook hook 'turn-on-autopair-mode))
      '(python-mode-hook
        c-mode-common-hook
        ruby-mode-hook))

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Powerline
(require 'powerline)
(powerline-default-theme)

(custom-set-faces
 '(mode-line ((t (:background "#0088cc" :foreground "white" :box nil))))
 '(mode-line-inactive ((t (:box nil)))))

;; Zen-coding
(require 'zencoding-mode)
(setq zencoding-indentation 2)
(add-hook 'sgml-mode-hook 'zencoding-mode)

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
(global-set-key (kbd "C-,") 'previous-buffer)
(global-set-key (kbd "C-.") 'next-buffer)

;; Find files in current project
;(global-set-key (kbd "C-S-r") 'find-file-in-project)

;; Expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; Iedit-mode
(global-set-key (kbd "C-;") 'iedit-mode)

(require 'custom-hack)
;; Keybindings for custom hacks
(global-set-key (kbd "C-o") 'start-newline-next)
(global-set-key (kbd "M-o") 'start-newline-prev)
(global-set-key (kbd "C-:") 'toggle-clj-keyword-string)
(global-set-key (kbd "C-S-g") 'ack-current-word)
(global-set-key (kbd "C-*") 'isearch-forward-at-point)
