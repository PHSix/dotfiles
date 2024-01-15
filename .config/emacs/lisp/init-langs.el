(use-package nix-mode
  :mode "\\.nix\\'"
  )

(use-package rjsx-mode
  :straight t
  :mode ("\\.tsx\\'" "\\.jsx\\'")
  )

(use-package web-mode
  :straight t
  :config
  )

(use-package typescript-mode
  :straight t
  :mode "\\.ts\\'"
  :config
  (setq typescript-indent-level 2)
  )

(use-package markdown-mode
  :straight t
  :mode "\\.md\\'"
  )

(use-package json-mode
  :straight t
  :mode "\\.json\\'"
  )

(use-package rust-mode
  :straight t
  :mode "\\.rs\\'"
  )

(use-package go-mode
  :mode "\\.go\\'"
  :straight t
  :config
  (add-hook 'go-mode-hook 'presets/tab-indent)
  )

(provide 'init-langs)
