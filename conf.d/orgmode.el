;; Org mode settings
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)

(defvar org-directory "~/org")

(setq org-default-notes-file (concat org-directory "/captures.org"))

(setq org-agenda-files `(,(concat org-directory "/todos.org")
                         ,(concat org-directory "/todos/work")
                         ,(concat org-directory "/notes/work")))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


(setq org-capture-templates
      '(("t" "Task" entry (file+headline
                           (concat org-directory "/todos.org")
                           "Tasks")
         "** TODO %?\n\n")
        ("n" "Note" entry (file (concat org-directory "/notes.org"))
         "* %<%D> %^{Title} :NOTE:%^G\n%?")))

(setq org-latex-pdf-process
  '("xelatex -shell-escape -interaction nonstopmode %f"
    "xelatex -shell-escape -interaction nonstopmode %f"
    "xelatex -shell-escape -interaction nonstopmode %f"
    "xelatex -shell-escape -interaction nonstopmode %f")) ;; for multiple passes

;; Stop org from keep the tables centered
(setq org-latex-tables-centered nil)
(setq org-latex-listings 'minted)

(defvar en-article "
\\documentclass{scrartcl}
\\usepackage{hyperref}
\\usepackage{color}
\\usepackage[hyperref,x11names,usenames,dvipsnames]{xcolor}
\\hypersetup{colorlinks=true,linkcolor=BlueViolet}
\\usepackage{minted}
\\usepackage[top=1in,bottom=1in,left=0.8in,right=0.8in]{geometry}
\\usepackage[center,pagestyles]{titlesec}
\\usepackage{indentfirst}
\\usepackage[export]{adjustbox}
\\usemintedstyle{emacs}
\\setlength{\\parskip}{0.5\\baselineskip}
\\setlength{\\parindent}{0em}
\\titleformat{\\section}{\\Large\\bfseries}{\\S\\,\\thesection}{1em}{}
\\titleformat{\\subsection}{\\large\\bfseries}{\\S\\,\\thesubsection}{1em}{}
\\titleformat{\\subsubsection}{\\bfseries}{$\\cdot$~\\,\\thesubsubsection}{0.5em}{}
\\newpagestyle{main}{
\\sethead{\\small\\S\\,\\thesection\\quad\\sectiontitle}{}{$\\cdot$~\\thepage~$\\cdot$}
\\setfoot{}{}{}\\headrule}
\\pagestyle{main}
")

(defvar en-beamer "
\\documentclass\[presentation\]\{beamer\}
\\usepackage{minted}
\\usemintedstyle{emacs}
\\AtBeginSection[]{\\begin{frame}<beamer>\\frametitle{Topic}\\tableofcontents[currentsection]\\end{frame}}
")

(defvar zh-preamble "
\\usepackage{xeCJK}
\\setCJKmainfont[BoldFont=Adobe Heiti Std, ItalicFont=Adobe Kaiti Std]{Adobe Song Std}
\\setCJKmonofont[Scale=0.9]{Adobe Song Std}
\\setCJKfamilyfont{song}[BoldFont=Adobe Heiti Std]{Adobe Song Std}
\\setCJKfamilyfont{sf}[BoldFont=Adobe Heiti Std]{Adobe Song Std}
\\renewcommand{\\contentsname}{目录}
\\renewcommand{\\listfigurename}{插图目录}
\\renewcommand{\\listtablename}{表格目录}
\\renewcommand{\\refname}{参考文献}
\\renewcommand{\\abstractname}{摘要}
\\renewcommand{\\indexname}{索引}
\\renewcommand{\\tablename}{表}
\\renewcommand{\\figurename}{图}
")



(defvar cn-article
  (concat en-article zh-preamble))

(defvar cn-beamer
  (concat en-beamer zh-preamble))

(require 'ox-latex)
(require 'ox-beamer)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))

(add-to-list 'org-latex-classes
             `("article"
               ,en-article
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
              `("cn-article"
                ,cn-article
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
              `("beamer"
                ,en-beamer
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
              `("cn-beamer"
                ,cn-beamer
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


