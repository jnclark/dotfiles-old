;;delimiter stuff

(setq show-paren-delay 0)
(show-paren-mode 1)

;;end delimiter stuff

;;autopair like behavior with electric-pair-mode
(electric-pair-mode t)
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
