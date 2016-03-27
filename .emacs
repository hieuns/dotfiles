;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
      '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
 (package-refresh-contents))

(defvar myPackages
 '(better-defaults
   ein
   elpy
   flycheck
   material-theme
   py-autopep8
   markdown-mode))

(mapc #'(lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
     myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(load-theme 'material t) ;; load material theme
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules
   (quote
    (elpy-module-company
     elpy-module-eldoc
     elpy-module-pyvenv
     elpy-module-yasnippet
     elpy-module-django
     elpy-module-sane-defaults)))
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(column-number-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(setq elpy-rpc-python-command "python3")
(elpy-use-cpython "python3")
(elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
 (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
 (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; MARKDOWN CONFIGURATION
;; --------------------------------------

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown file" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; init.el ends here
