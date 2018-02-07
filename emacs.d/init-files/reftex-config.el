;; make reftex work with Auctex
(setq reftex-plug-into-AUCTeX t)

;; insert non breaking space before cite
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
