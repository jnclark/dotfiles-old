;;org reveal

(require 'ox-reveal)

;;(setq org-reveal-root "../reveal.js")
(setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
(setq org-reveal-mathjax t)

(setq org-image-actual-width nil)

(require  'htmlize)

(setq org-src-fontify-natively t)

(setq org-agenda-include-diary t)
(setq cal-tex-diary t)
(add-to-list 'org-modules "org-habit")

;; Load org babel language if needed (thanks to John Kitchin)
;; via https://emacs.stackexchange.com/questions/20577/org-babel-load-all-languages-on-demand
(defadvice org-babel-execute-src-block (around load-language nil activate)
  "Load language if needed"
  (let ((language (org-element-property :language (org-element-at-point))))
    (unless (cdr (assoc (intern language) org-babel-load-languages))
      (add-to-list 'org-babel-load-languages (cons (intern language) t))
      (org-babel-do-load-languages 'org-babel-load-languages org-babel-load-languages))
    ad-do-it))
