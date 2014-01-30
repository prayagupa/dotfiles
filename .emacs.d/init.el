;(require 'dirtree)

(require 'ido)
    (ido-mode t)

(global-linum-mode t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")

(load-theme 'solarized-dark t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; fullscreen
(custom-set-variables
   '(initial-frame-alist (quote ((fullscreen . maximized)))))

