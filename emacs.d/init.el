;; init.el --- Emacs configuration

(setq inhibit-startup-message t) ;; hide the startup message
(tool-bar-mode -1) ;; hide the toolbar
(toggle-scroll-bar -1) ;; hide the scrollbar

(load-theme 'misterioso t);;starter theme

(global-linum-mode t) ;; enable line numbers globally

;; org mode keymaps
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

(setenv "TEXINPUTS" "/usr/lib/sagemath/local/share/texmf//:");;Set correct TEXINPUTS path for SageTeX
