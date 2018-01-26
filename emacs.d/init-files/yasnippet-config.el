;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-triggers-in-field t) ;;can expand snippet inside snippet
(advice-add 'yas--auto-fill-wrapper :override #'ignore);;add autofill workaround
