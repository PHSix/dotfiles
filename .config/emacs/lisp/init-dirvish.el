(use-package dirvish
  :straight t
  :config
  (dirvish-override-dired-mode)

  (evil-define-key 'normal 'dirvish-mode-map
    (kbd "q") #'dirvish-quit
   )
  )

(provide 'init-dirvish)
