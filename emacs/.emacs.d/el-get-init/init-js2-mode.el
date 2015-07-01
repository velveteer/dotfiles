(el-get 'sync 'tern)
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook
          (lambda ()
            (setq js2-bounce-indent-p t)
            (linum-mode 1)
            (tern-mode t)
            (js2-mode-keybindings)))

(defun js2-mode-keybindings ()
  (local-set-key (kbd "C-M-n") 'next-error)
  (local-set-key (kbd "C-M-p") 'previous-error))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
