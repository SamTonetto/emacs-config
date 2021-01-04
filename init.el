;;----------------------------------------

;;; Uses Emacs 27 downloaded from brew using
;;; "brew install emacs-plus@27"
;;; This file is to be placed in "~/.emacs.d/" directory, along with "myinit.org".

;;----------------------------------------

;; this file's true directory
(setq dotfile-dir (file-name-directory
                   (file-chase-links
                    (or load-file-name
                        (buffer-file-name)))))

;; 3rd party stuff
(add-to-list 'load-path (concat dotfile-dir "site-lisp/"))

;;---------------------------------------

;; package setup

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(defvar package-list)
(setq package-list '(async auctex auto-complete autopair clang-format cmake-ide cmake-mode
			   company company-irony company-irony-c-headers flycheck flycheck-irony flycheck-pyflakes google-c-style
			   helm helm-core helm-ctest helm-flycheck helm-flyspell helm-ls-git helm-ls-hg hungry-delete irony let-alist levenshtein
			   markdown-mode pkg-info popup rtags seq solarized-theme vlf web-mode window-numbering writegood-mode yasnippet))

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install missing packages in package-list
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Bootstrap "use-package" - preferred alternative to "require"
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; The file with most of the settings is an org-mode file
;; Here we bootstrap the 'org-mode' package
(unless (package-installed-p 'org)
  (package-refresh-contents)
  (package-install 'org-mode))

;; -------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; esup: Emacs StartUp Profiler
;;       - Profile the load time of the Emacs init file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package esup
  :ensure t
  :init
  (setq esup-child-max-depth 0)
  ;; Use a hook so the message doesn't get clobbered by other messages.
  (add-hook
   'emacs-startup-hook
   (lambda ()
     (message "Emacs ready in %s with %d garbage collections."
              (format "%.2f seconds"
                      (float-time
                       (time-subtract after-init-time before-init-time)))
              gcs-done))))

;; -------------------------------------

;; Load primary init file.
(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))

;; -------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-safe-themes
   '("dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" "f56eb33cd9f1e49c5df0080a3e8a292e83890a61a89bceeaa481a5f183e8e3ef" default))
 '(package-selected-packages
   '(hide-lines hide-comnt highlight-doxygen tide rainbow-mode zenburn-theme ws-butler writegood-mode window-numbering which-key web-mode warm-night-theme vlf vimish-fold use-package undo-tree ujelly-theme twilight-bright-theme try tao-theme tangotango-theme tango-plus-theme tabbar sublimity sublime-themes subatomic-theme sr-speedbar spacemacs-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smooth-scroll smex slime seti-theme rainbow-delimiters python-mode powerline planet-theme plan9-theme phoenix-dark-pink-theme phoenix-dark-mono-theme pdf-tools paradox ox-reveal org-bullets neotree naysayer-theme naquadah-theme monokai-theme moe-theme modern-cpp-font-lock minimap minimal-theme material-theme lua-mode lsp-ui lsp-ivy live-py-mode lenlen-theme latex-preview-pane latex-math-preview kaolin-themes json-mode js2-mode jedi jazz-theme irony-eldoc inkpot-theme indent-guide imenu-anywhere iedit hungry-delete htmlize hindent highlight-indent-guides helm-ls-hg helm-ls-git helm-flyspell helm-flycheck helm-descbinds helm-ctest heaven-and-hell hc-zenburn-theme haskell-mode graphviz-dot-mode grandshell-theme google-c-style god-mode ggtags framemove fortpy flyspell-correct-ivy flymake-google-cpplint flymake-cursor flycheck-pyflakes flycheck-irony flatui-theme flatui-dark-theme flatland-theme flatland-black-theme find-file-in-project faff-theme expand-region exec-path-from-shell esup espresso-theme elpy eclipse-theme ebib dumb-jump dracula-theme doom-themes darktooth-theme darkmine-theme cyberpunk-theme cyberpunk-2019-theme csharp-mode cquery counsel-projectile counsel-etags company-rtags company-quickhelp company-lsp company-irony-c-headers company-irony company-c-headers color-theme-sanityinc-tomorrow color-identifiers-mode cmake-mode cmake-ide clues-theme clang-format chicken-scheme challenger-deep-theme buffer-move bubbleberry-theme better-defaults beacon badwolf-theme autopair auto-package-update auto-complete-clang auto-complete-c-headers auctex atom-dark-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme all-the-icons alect-themes aggressive-indent ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(lsp-ui-doc-background ((t (:background nil))))
 '(lsp-ui-doc-header ((t (:inherit (font-lock-string-face italic))))))
