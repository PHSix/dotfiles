
;;; Treesitter feature was stable after emacs29 released.
(when (> emacs-major-version 28)
  (use-package tree-sitter-langs
    :straight t
    )
  
  (setq go-ts-mode-indent-offset 4)

  ;; emacs core content tree-sitter after the 29 major version.
  (add-hook 'after-init-hook #'global-tree-sitter-mode)
  
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
  
  )


(provide 'init-treesitter)
