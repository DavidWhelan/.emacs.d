
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; install use package if it hasn't been already
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package company
  :ensure t
  :config (add-hook 'after-init-hook 'global-company-mode))  

(use-package magit
  :ensure t
  :pin melpa-stable)

;; minibuffer completion
(use-package ivy
  :ensure t
  :config

  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d%d) ")
  
  (ivy-mode 1))

;; better isearch using ivy
(use-package swiper
  :bind (("C-s" . 'swiper-isearch))
  :ensure t
  :after ivy)

;; project management
(use-package projectile
  :ensure t
  :pin melpa-stable
  :bind (("C-c p" . 'projectile-command-map))
  :config(projectile-mode +1))

(use-package vscode-icon
  :ensure t
  :commands (vscode-icon-for-file))

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn t)

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(load (expand-file-name "~/.roswell/helper.el"))

(setq sly-lisp-implementations
      '((ros ("ros" "-Q" "run") :coding-system utf-8-unix)
        (qlot ("qlot" "exec" "ros" "-Q" "run") :coding-system utf-8-unix)))

(setq inferior-lisp-program "ros -Q run")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(vscode-icon ivy magit dired-sidebar)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
