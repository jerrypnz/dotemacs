;; Setting fonts for GUI emacs
(if (display-graphic-p)
    (progn
      (set-face-attribute
       'default nil :font "Ubuntu Mono 12")
      (dolist (charset '(kana han symbol cjk-misc bopomofo))
        (set-fontset-font (frame-parameter nil 'font)
                          charset
                          (font-spec :family "文泉驿等宽微米黑" :size 16)))))
