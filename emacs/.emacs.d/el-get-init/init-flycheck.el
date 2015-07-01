(require 'flycheck)
(add-hook 'js2-mode-hook
    (lambda () (flycheck-mode t)))
