;; Flycheck for syntax error checking
(global-flycheck-mode)

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'tex-chktex 'LaTeX-mode)
  (flycheck-add-mode 'tex-lacheck 'LaTeX-mode))

(flycheck-add-next-checker 'tex-chktex '(warning . tex-lacheck))

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))