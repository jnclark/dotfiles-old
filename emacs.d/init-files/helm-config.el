;; HELM

(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

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

;; END HELM
