;; Custom stuff to the go layer

(setq jp-go-packages
      '(go-mode))

(defun jp-go/pre-init-go-mode ()
  (spacemacs|use-package-add-hook go-mode
    :post-config

    ;; Jump to definition
    (define-key go-mode-map (kbd "M-.") 'godef-jump)

    ;; Go playground
    (defun go-play ()
      (interactive)
      (let* ((temporary-file-directory (expand-file-name "tmp/" (getenv "GOPATH")))
             (tf
              (progn
                (make-directory temporary-file-directory t)
                (make-temp-file "go-play" nil ".go"))))
        (find-file tf)
        (insert "package main

import (
	\"fmt\"
)

func main() {
	fmt.Printf(\"\")
}")
        (goto-char 61)
        (go-mode)
        (define-key
          (current-local-map)
          (kbd "C-c C-k")
          (lambda () (interactive)
            (save-buffer)
            (delete-file (buffer-file-name))
            (kill-buffer)))
        (define-key
          (current-local-map)
          (kbd "C-c C-c")
          (lambda () (interactive)
            (save-buffer)
            (compile (format "go run %s" (buffer-file-name)))))))

    ))
