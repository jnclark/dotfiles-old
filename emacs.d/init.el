;; init.el --- Emacs configuration

(when (>= emacs-major-version 24)
    (require 'package)
	  (add-to-list
		   'package-archives
			     '("melpa" . "https://melpa.milkbox.net/packages/")
				    t))

(package-initialize)

(setq inhibit-startup-message t) ;; hide the startup message
(tool-bar-mode -1) ;; hide the toolbar
(toggle-scroll-bar -1) ;; hide the scrollbar
(add-to-list 'default-frame-alist
	     '(vertical-scroll-bars . nil)) ;;hide scrollbar for emacsclient
(menu-bar-mode -1) ;; hide the menubar, acces with C-mouse3
(load-theme 'tsdh-dark t) ;;starter theme
(global-hl-line-mode 1) ;; highlights the current line.

(server-start) ;;for synctex and emacsclient

(load-file "~/.emacs.d/init-files/spell-check-config.el")
(load-file "~/.emacs.d/init-files/syntax-check-config.el")
(load-file "~/.emacs.d/init-files/auctex-config.el")
(load-file "~/.emacs.d/init-files/reftex-config.el")
(load-file "~/.emacs.d/init-files/org-config.el")
(load-file "~/.emacs.d/init-files/helm-config.el")
(load-file "~/.emacs.d/init-files/company-config.el")
(load-file "~/.emacs.d/init-files/sage-config.el")
(load-file "~/.emacs.d/init-files/yasnippet-config.el")
(load-file "~/.emacs.d/init-files/delimiter-config.el")
(load-file "~/.emacs.d/init-files/keymaps.el")
(load-file "~/.emacs.d/init-files/personal.el")
