;; [ Emacs Config ]

;;(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; emacs's packages
;;(require 'dashboard)
;;(dashboard-setup-startup-hook)
;;(ac-config-default)
;;(doom-modeline-mode 1)
(package-initialize)

;; Load Editor Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/atom-one-dark-theme")
(load-theme 'atom-one-dark t)

;; Custom Color
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "gray55" :slant oblique))))
 '(region ((t (:extend t :background "gray45")))))

;; My Editor View
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(global-hl-line-mode)
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq c-default-style "linux")
(setq c-basic-offset 4)
(c-set-offset 'comment-intro 0)

;; Emacs File Backup Save
(setq backup-directory-alist `(("." . "~/.saves")))

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; My Emacs key binding
(global-set-key (kbd "C-t") 'tab-new)
(global-set-key (kbd "M-s") 'tab-switcher)
(global-set-key (kbd "C-x C-q") 'tab-close)



;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(inhibit-startup-screen t)
;; '(package-selected-packages
;;   '(eshell-toggle php-mode doom-modeline dashboard auto-complete)))

