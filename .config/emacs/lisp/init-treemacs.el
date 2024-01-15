(use-package treemacs
  :straight t
  :init
  (add-to-list 'recentf-exclude "\.cache/treemacs-persist")
  :config
  (defun +treemacs-toggle()
    "toggle treemacs visiblily"
    (interactive)
    (pcase (treemacs-current-visibility)
      (`visible (delete-window (treemacs-get-local-window)))
      (_ (treemacs))
      )
    )

  ;;; TODO: implement
  (defun +treemacs-rename-plus ()
    "Rename file or project"
    (interactive)
    )

  (add-hook 'treemacs-select-hook (lambda (_) (display-line-numbers-mode 0)))

  (with-eval-after-load 'treemacs
    (evil-define-key 'normal 'global
	;; (kbd "<leader> s w") #'treemacs-switch-workspace
	(kbd "C-n") #'+treemacs-toggle)
    (evil-define-key 'treemacs treemacs-mode-map
      (kbd "a") #'treemacs-create-file
      (kbd "r") #'treemacs-rename-file
      ;; (kbd "R") #'+treemacs-rename-plus
      (kbd "C-n") #'+treemacs-toggle
      (kbd "E") #'treemacs-visit-node-ace-horizontal-split
      (kbd "S") #'treemacs-visit-node-ace-vertical-split
      (kbd "d") nil
      (kbd "d f") #'treemacs-delete-file
      (kbd "c p") #'treemacs-copy-file
      (kbd "o") #'treemacs-RET-action
      )
    )
  )


(use-package treemacs-all-the-icons
  :straight t
  :config
  (treemacs-load-theme "all-the-icons")
  )

;; for fix treemacs in evil mode
(use-package treemacs-evil
  :straight t
  )

(use-package treemacs-projectile
  :straight t
  :after projectile
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

(provide 'init-treemacs)
