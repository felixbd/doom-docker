
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

(ido-mode 1)
(ido-everywhere 1)

(advice-add 'highlight-indent-guides-auto-set-faces :override #'ignore)

(setq debug-on-error t)

(set-face-attribute 'default nil :family "Fira Code" :height 120)

(after! org
  (require 'ox-reveal)

  (setq org-babel-min-lines-for-block-output 0)
  (setq org-babel-default-header-args
        (cons '(:session . "none")
              (assq-delete-all :session org-babel-default-header-args)))

  (add-hook #'org-mode-hook #'org-special-block-extras-mode)

  (setq org-ascii-text-width 120)

  (setq org-latex-listings 'minted  ;; (setq org-latex-src-block-background 'minted
        org-latex-packages-alist '(("" "minted"))
        org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  (setq org-latex-minted-options '(("frame" "lines")
                                   ("linenos" "true")
                                   ("fontsize" "\\small")
                                   ("breaklines" "true")
                                   ("breakanywhere" "true")
                                   ("tabsize" "4")))

  (setq org-latex-classes
        '(("article" "\\documentclass[11pt]{article}"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

  (add-to-list 'org-latex-classes
               '("koma-book" "\\documentclass{scrbook}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (add-to-list 'org-latex-classes
               '("koma-article"
                 "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

(setq doom-theme 'doom-one)

(setq display-line-numbers-type 'relative)

(setq org-directory "~/org/")

