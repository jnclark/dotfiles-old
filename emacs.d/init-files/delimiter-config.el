(require 'rainbow-delimiters)

;;delimiter stuff

(setq show-paren-delay 0)
(show-paren-mode 1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'LaTeX-mode-hook #'rainbow-delimiters-mode)
(add-hook 'latex-mode-hook #'rainbow-delimiters-mode)
(add-hook 'TeX-mode-hook #'rainbow-delimiters-mode)

;;end delimiter stuff

;;autopair like behavior with electric-pair-mode
(electric-pair-mode t)
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
(add-hook 'sage-shell-mode-hook
              (lambda ()
                (define-key sage-mode-map "\"" 'electric-pair)
                (define-key sage-mode-map "\'" 'electric-pair)
                (define-key sage-mode-map "\(" 'electric-pair)
                (define-key sage-mode-map "\[" 'electric-pair)
                (define-key sage-mode-map "\{" 'electric-pair)))

