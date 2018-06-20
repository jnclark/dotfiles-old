;; HELM

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

;; END HELM
