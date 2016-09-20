;; Custom stuff to the go layer

(setq jp-go-packages
      '(go-mode
        (go-guru :location site)))

(defun jp-go/pre-init-go-mode ()
  (spacemacs|use-package-add-hook go-mode
    :post-config

    ;; Use goimports
    (setq gofmt-command "goimports")

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


(defun jp-go/init-go-guru()
  (let ((go-path (getenv "GOPATH")))
    (if (not go-path)
        (spacemacs-buffer/warning
         "GOPATH variable not found, go-guru configuration skipped.")
      (load-gopath-file
       go-path "/src/golang.org/x/tools/cmd/guru/go-guru.el"))))
