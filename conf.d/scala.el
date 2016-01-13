(use-package scala-mode2
  :ensure t
  :pin melpa-stable
  :mode ("\\.scala\\'" . scala-mode)
  
  :config
  ;; Fancy unicode arrows
  (defun right-arrow ()
    (interactive)
    (cond ((looking-back "=") 
           (backward-delete-char 1) (insert "⇒"))
          ((looking-back "-")
           (backward-delete-char 1) (insert "→"))
          (t (insert ">"))))
  
  (defun left-arrow ()
    (interactive)
    (if (looking-back "<") 
        (progn (backward-delete-char 1)
               (insert "←"))
      (insert "-")))
  
  
  (add-hook 'scala-mode-hook '(lambda () (interactive) 
                                (local-set-key (kbd "-") 'left-arrow)
                                (local-set-key (kbd ">") 'right-arrow))))

 


