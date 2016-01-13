(defvar my-packages
  '(multiple-cursors
    cyberpunk-theme
    zenburn-theme
    ample-zen-theme
    clojure-mode
    cider
    elpy
    geiser
    org
    markdown-mode+
    clj-refactor
    nrepl-eval-sexp-fu
    align-cljlet
    undo-tree
    sbt-mode
    php-mode
    web-mode
    haskell-mode
    dockerfile-mode
    puppet-mode
    color-theme-sanityinc-tomorrow
    monokai-theme))

(when (boundp 'package-pinned-packages)
  (setq package-pinned-packages
                '((cider              . "melpa-stable")
                  (clojure-mode       . "melpa-stable")
                  (clj-refactor       . "melpa-stable")
                  (scala-mode2        . "melpa-stable")
                  (rainbow-delimiters . "melpa-stable"))))
