(use-package magit
  :straight t
  :defer t
  )

(use-package git-gutter
  :straight t
  :init
  :config
  (custom-set-variables
   '(git-gutter:modified-sign "|") ;; two space
   '(git-gutter:added-sign "|")    ;; multiple character is OK
   '(git-gutter:deleted-sign "|"))
  (evil-define-key 'normal 'global
    (kbd "g j") #'git-gutter:next-hunk
    (kbd "g k") #'git-gutter:previous-hunk
    (kbd "<leader> g s") #'git-gutter:stage-hunk
    (kbd "<leader> g r") #'git-gutter:revert-hunk
    )
  (global-git-gutter-mode)
  )

(provide 'init-git)
