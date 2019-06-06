;; init.el --- Emacs configuration

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; General Emacs Settings ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (>= emacs-major-version 24)
    (require 'package)
	  (add-to-list
		   'package-archives
			     '("melpa" . "https://melpa.org/packages/")
				    t))

(package-initialize)

(setq inhibit-startup-message t) ;; hide the startup message
(tool-bar-mode -1) ;; hide the toolbar
(toggle-scroll-bar -1) ;; hide the scrollbar
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil)) ;;hide scrollbar for emacsclient
(menu-bar-mode -1) ;; hide the menubar, acces with C-mouse3
(load-theme 'tsdh-dark t) ;;starter theme
(global-hl-line-mode 1) ;; highlights the current line.

(server-start) ;;for synctex and emacsclient

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Specific Emacs Package Settings ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;
;; Spellcheck ;;
;;;;;;;;;;;;;;;;

;; find aspell and hunspell automatically
(cond
 ;; try hunspell at first
 ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
	;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
          )))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))

;; end Spellcheck

;; Flycheck for syntax error checking

(global-flycheck-mode)

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'tex-chktex 'LaTeX-mode)
  (flycheck-add-mode 'tex-lacheck 'LaTeX-mode))

(flycheck-add-next-checker 'tex-chktex '(warning . tex-lacheck))

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

;; End Flycheck

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AucTeX configuration & PDF Stuff ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tex)
(require 'reftex)

(TeX-global-PDF-mode t)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("Latexmk shell escape" "latexmk -pdf --shell-escape %s" TeX-run-TeX nil t
      :help "Run latexmk with shell escape on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "Latexmk")))

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

;; for cleveref and nameref
(setq reftex-ref-style-alist
      (quote
       (("Default" t
	 (("\\ref" 13)
	  ("\\pageref" 112)))
	("Varioref" "varioref"
	 (("\\vref" 118)
	  ("\\vpageref" 103)
	  ("\\Vref" 86)
	  ("\\Ref" 82)))
	("Fancyref" "fancyref"
	 (("\\fref" 102)
	  ("\\Fref" 70)))
	("Hyperref" "hyperref"
	 (("\\autoref" 97)
	  ("\\autopageref" 117)))
	("Cleveref" "cleveref"
	 (("\\cref" 99)
	  ("\\Cref" 67)
	  ("\\cpageref" 100)
	  ("\\Cpageref" 68)))
	("Nameref" "nameref"
	 (("\\nameref" 110))))))
(setq reftex-ref-style-default-list (quote ("Cleveref" "Nameref" "Default")))

;; Interleave for notes, etc.

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

;; end AucTeX config

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require  'htmlize)
(setq org-image-actual-width nil)
(setq org-src-fontify-natively t)
(setq org-agenda-include-diary t)
(setq cal-tex-diary t)
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;; Load org babel language if needed (thanks to John Kitchin)
;; via https://emacs.stackexchange.com/questions/20577/org-babel-load-all-languages-on-demand
(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))

;; end org config

;;;;;;;;;;;;;;;;;;;;;;;;
;; helm configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'helm)
(require 'helm-config)

(when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 40)
(helm-autoresize-mode 1)

(helm-mode 1)

;; Helm projectile

;; (setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-switch-project-action 'helm-projectile)

;;Helm flyspell
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct))

;; end helm

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company-mode settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'after-init-hook 'global-company-mode)

;; CompanyAucTeX

(require 'company-auctex)
(company-auctex-init)

;; helm company

(require 'helm-company)
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))

;; end company mode settings

;;;;;;;;;;;;;;;;;;;
;; sage settings ;;
;;;;;;;;;;;;;;;;;;;

;; for sage-shell-mode

(require 'sage-shell-mode)

;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
(sage-shell:define-alias)

;; Turn on eldoc-mode in Sage terminal and in Sage source files
(add-hook 'sage-shell-mode-hook #'eldoc-mode)
(add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)

(setq sage-shell:use-prompt-toolkit t)

;; end sage-shell-mode

;; helm sage

(eval-after-load "sage-shell-mode"
  '(sage-shell:define-keys sage-shell-mode-map
     "C-c C-i"  'helm-sage-complete
     "C-c C-h"  'helm-sage-describe-object-at-point
     "M-r"      'helm-sage-command-history
     "C-c o"    'helm-sage-output-history))

;; end helm sage

;; ob-sagemath

(require 'ob-sagemath)

;; Ob-sagemath supports only evaluating with a session.
(setq org-babel-default-header-args:sage '((:session . t)
										                                              (:results . "output")))

;; C-c c for asynchronous evaluating (only for SageMath code blocks).
(with-eval-after-load "org"
					    (define-key org-mode-map (kbd "C-c c") 'ob-sagemath-execute-async))

;; Do not confirm before evaluation
(setq org-confirm-babel-evaluate nil)

;; Do not evaluate code blocks when exporting.
(setq org-export-babel-evaluate nil)

;; Show images when opening a file.
(setq org-startup-with-inline-images t)

;; Show images after evaluating code blocks.
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

;; end ob-sagemath

;; set correct TEXINPUTS path for SageTeX

(setenv "TEXINPUTS" "/usr/lib/sagemath/local/share/texmf//:")

;; end sage settings

;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'yasnippet)
(yas-global-mode 1)
(setq yas-triggers-in-field t) ;; can expand snippet inside snippet
(advice-add 'yas--auto-fill-wrapper :override #'ignore);; add autofill workaround

;; end yasnippet settings

;;;;;;;;;;;;;;;;;;;;;;;;
;; delimiter settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq show-paren-delay 0)
(show-paren-mode 1)

;;autopair like behavior with electric-pair-mode
(electric-pair-mode t)
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; end delimiter settings

;;;;;;;;;;;;;;;;;;;;
;; Custom Keymaps ;;
;;;;;;;;;;;;;;;;;;;;

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; The default helm "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

;; end keymaps

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Personal file for testing additional packages and settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-file "~/.emacs.d/personal.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto-gen emacs custom.el ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(provide 'init)
;;; init.el ends here
