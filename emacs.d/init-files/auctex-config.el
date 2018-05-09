;;auctex
(require 'tex)
(require 'reftex)

(TeX-global-PDF-mode t)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; enable auto-fill mode, nice for text
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; for synctex
(TeX-source-correlate-mode t)
(setq TeX-view-program-selection '((output-pdf "Zathura")))

;; make reftex work with Auctex
(setq reftex-plug-into-AUCTeX t)

;; reftex insert non breaking space before cite
(setq reftex-format-cite-function
      '(lambda (key fmt)
	 (let ((cite (replace-regexp-in-string "%l" key fmt)))
	   (if (or (= ?~ (string-to-char fmt))
		   (member (preceding-char) '(?\ ?\t ?\n ?~)))
	       cite
	     (concat "~" cite)))))

(setq reftex-label-alist
      '(("axiom" ?a "ax:"  "~\\ref{%s}" t ("axiom"   "ax.") -2)
	("definition" ?d "def:"  "~\\ref{%s}" t ("definition"   "df.") -3)
	("conjecture" ?c "conj:"  "~\\ref{%s}" t ("conjecture"   "cj.") -3)
	("algorithm" ?g "alg:"  "~\\ref{%s}" t ("algorithm"   "al.") -4)
	("theorem" ?h "thm:" "~\\ref{%s}" t   ("theorem" "th.") -3)
	("proposition" ?p "prop:" "~\\ref{%s}" t   ("proposition" "pp.") -3)
	("lemma" ?m "lem:" "~\\ref{%s}" t   ("lemma" "lm.") -3)
	("claim" ?x "claim:" "~\\ref{%s}" t   ("claim" "cl.") -3)
	("case" ?y "case:" "~\\ref{%s}" t   ("case" "cs.") -4)))

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (LaTeX-add-environments
	     '("axiom" LaTeX-env-label)
	     '("definition" LaTeX-env-label)
	     '("conjecture" LaTeX-env-label)
	     '("algorithm" LaTeX-env-label)
	     '("theorem" LaTeX-env-label)
	     '("proposition" LaTeX-env-label)
	     '("lemma" LaTeX-env-label)
	     '("claim" LaTeX-env-label)
	     '("case" LaTeX-env-label))))

;; for cref, quick fix
(defun reftex-format-cref (label def-fmt ref-style)
  (format "\\cref{%s}" label))
(setq reftex-format-ref-function 'reftex-format-cref)

;; for helm bibtex and org-ref, with interleave
(require 'org-ref)
(require 'helm-bibtex)
(require 'interleave)

(setq org-ref-note-title-format
      "** TODO %9a (%y) - %t
 :PROPERTIES:
  :Custom_ID: %k
  :INTERLEAVE_PDF: ./pdf/%k.pdf
  :AUTHOR: %9a 
  :JOURNAL: %j
  :YEAR: %y
  :VOLUME: %v
  :PAGES: %p
  :DOI: %D
  :URL: %U
 :END:
")

;; install pdf tools
(pdf-tools-install)
;; for synctex in pdf-tools
(setq TeX-source-correlate-start-server t)
;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
	  #'TeX-revert-document-buffer)

;; function to facilitate org notes call from helm bibtex
(defun my/org-ref-notes-function (candidates)
  (let ((key (helm-marked-candidates)))
    (funcall org-ref-notes-function (car key))))

(helm-delete-action-from-source "Edit notes" helm-source-bibtex)
;; Note that 8 is a magic number of the index where you want to insert the command. You may need to change yours.
(helm-add-action-to-source "Edit notes" 'my/org-ref-notes-function helm-source-bibtex 8)
(provide 'auctex-config)
;;; auctex-config.el ends here
