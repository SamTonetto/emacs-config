;;; This config is based on an install of Emacs 25 with Cocoa on MAC OSX Sierra
;;; Installed using "brew install emacs --with-cocoa".

;;; This file is to be placed in "~/.emacs.d/" directory, along with "myinit.org".

;; Enable access to MELPA package archive
;; package.el should be default in Emacs 24 onwards.
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; "Use-package" is a preferred alternative to "require"
;; Here we bootstrap 'use-package'.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; The file with most of the settings is an org-mode file
;; Here we bootstrap the 'org-mode' package
(unless (package-installed-p 'org)
  (package-refresh-contents)
  (package-install 'org-mode))

;; Load primary init file.
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))
