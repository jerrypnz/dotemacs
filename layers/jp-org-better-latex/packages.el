;; Better Latex support for org:
;;
;; - Syntax highlighting with `minted'
;; - Better Chinese support

(setq jp-org-better-latex-packages
      '(org :location built-in))

(defun jp-org-better-latex/post-init-org ()

  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode %f"
          "xelatex -shell-escape -interaction nonstopmode %f"
          "xelatex -shell-escape -interaction nonstopmode %f"
          "xelatex -shell-escape -interaction nonstopmode %f"
          "rm -f %o/%b*.vrb")) ;; for multiple passes

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
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
