(projectile-global-mode)

(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)


