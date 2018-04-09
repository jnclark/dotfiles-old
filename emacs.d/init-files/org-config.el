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
