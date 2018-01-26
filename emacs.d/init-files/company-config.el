;; company-mode

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

;;end company