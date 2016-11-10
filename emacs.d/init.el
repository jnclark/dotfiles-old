;; init.el --- Emacs configuration

(setq inhibit-startup-message t) ;; hide the startup message
(tool-bar-mode -1) ;; hide the toolbar
(toggle-scroll-bar -1) ;; hide the scrollbar

(load-theme 'misterioso t);;starter theme

(global-linum-mode t) ;; enable line numbers globally

(setenv "TEXINPUTS" "/usr/lib/sagemath/local/share/texmf//:");;Set correct TEXINPUTS path for SageTeX
