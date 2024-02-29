;;;; package --- Summary
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;; Commentary:

;;; Code:

;; install use package if it hasn't been already
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package telephone-line
  :ensure t
  :config
  (telephone-line-mode 1))

(use-package company
  :ensure t
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package magit
  :ensure t
  :pin melpa-stable)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package yasnippet
  :ensure t
  
  :config
  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "C-o") yas-maybe-expand)

  (define-key yas-keymap (kbd "C-n") 'yas-next-field-or-maybe-expand)
  (define-key yas-keymap (kbd "C-p") 'yas-prev-field)
  
  (yas-global-mode 1))

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
  :config (projectile-mode +1))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

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

(use-package zenburn-theme
  :ensure t)

(use-package solarized-theme
  :ensure t)

(load-theme 'solarized-light t)

(electric-pair-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(when (string= system-type "darwin")
  (setq dired-use-ls-dired nil))

(setq inhibit-startup-screen t)
(kill-buffer "*scratch*")

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
;;; init.el ends here
