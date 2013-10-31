;;; deeper-blue-theme.el --- Custom face theme for Emacs

;; Copyright (C) 2010 Scott Frazer.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(deftheme deeper-blue
  "")

(custom-theme-set-faces
 'deeper-blue
 '(default ((t (:background "#181a26" :foreground "#dcdcdc"))))
 '(cursor ((t (:background "#00ff00" :foreground "#000000"))))
 '(region ((t (:background "#103050"))))
 '(mode-line ((t (:background "#bfbfbf" :foreground "#000000"))))
 '(mode-line-inactive ((t (:background "#545454" :foreground "#000000"))))
 '(fringe ((t (:background "#000000"))))
 '(minibuffer-prompt ((t (:foreground "#98f5ff"))))
 '(font-lock-builtin-face ((t (:foreground "#f08080"))))
 '(font-lock-comment-face ((t (:foreground "#7f7f7f"))))
 '(font-lock-constant-face ((t (:foreground "#a2cd5a"))))
 '(font-lock-function-name-face ((t (:foreground "#daa520"))))
 '(font-lock-keyword-face ((t (:foreground "#00bfff"))))
 '(font-lock-string-face ((t (:foreground "#deb887"))))
 '(font-lock-type-face ((t (:foreground "#98f5ff"))))
 '(font-lock-variable-name-face ((t (:foreground "#b4eeb4"))))
 '(font-lock-warning-face ((t (:foreground "#ff0000" :weight bold))))
 '(isearch ((t (:background "#8b3e2f" :foreground "#ffffff"))))
 '(lazy-highlight ((t (:background "#5f9ea0" :foreground "#ffffff"))))
 '(link ((t (:foreground "#00ffff" :underline t))))
 '(link-visited ((t (:foreground "#ee82ee" :underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#e5e5e5" :foreground "#333333")))))

(provide-theme 'deeper-blue)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; deeper-blue-theme.el  ends here
