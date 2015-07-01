(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
;; El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-recipes")
(setq el-get-user-package-directory
      (expand-file-name "~/.emacs.d/el-get-init"))
(setq el-get-verbose t)

;; local sources
(setq el-get-sources
      '((:name magit
               :after (global-set-key (kbd "C-x C-z") 'magit-status))))

(setq my-packages
      (append
       '(el-get rainbow-delimiters undo-tree diminish web-mode lua-mode nginx-mode tomorrow-theme
                less-css-mode js2-mode flycheck flycheck-pos-tip js-comint auto-complete nyan-mode
                tern anzu volatile-highlights git-gutter ace-jump-mode helm projectile)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Highlight current row
(global-hl-line-mode 1)
(global-visual-line-mode 1)

;; Disable auto-saves and backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Disable startup stuff
(setq inhibit-startup-message t)
(setq inhibit-startup-screen t)

;; IDO
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-show-dot-for-dired t)

;; Disable menu bar and scroll bar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; mode line settings
(require 'nlinum)
(nlinum-mode t)
(column-number-mode t)
(size-indication-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; Font scaling
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)

;; whitespace-mode config
(require 'whitespace)
;;(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))
(global-whitespace-mode 1)

;; Show matching parens
(show-paren-mode 1)

;; Use X clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t )

;; Support zsh scripts
(add-to-list 'auto-mode-alist '("\\.zsh" . sh-mode))

;; Recently opened files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-delay 0)
 '(flycheck-highlighting-mode (quote lines))
 '(js2-mode-show-parse-errors nil)
 '(js2-mode-show-strict-warnings nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'color-theme-tomorrow)
(color-theme-tomorrow--define-theme night-eighties)
