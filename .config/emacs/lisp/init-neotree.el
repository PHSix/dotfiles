(use-package neotree
  :straight t
  ;; :after (projectile . evil-collection)
  :after evil-collection
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq neo-window-width 45)

  (add-hook 'neotree-mode-hook #'hl-line-mode)

  (evil-define-key 'normal 'global
    (kbd "C-n") #'neotree-toggle
    )

  (evil-collection-define-key 'normal 'neotree-mode-map
    "r" #'neotree-rename-node
    "d" #'neotree-delete-node
    "a" #'neotree-create-node
    "o" #'neotree-enter
    )
  )

(use-package projectile
  :straight t
  :config
  (projectile-mode t)
  (evil-define-key 'normal 'global
    (kbd "<leader>ff") #'projectile-find-file
    (kbd "<leader>fp") #'projectile-switch-project
    (kbd "<leader>ap") #'projectile-add-known-project
    )
  )

(use-package rg
  :straight t
  )

(provide 'init-neotree)
