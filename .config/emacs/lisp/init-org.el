(use-package org-modern
  :straight t
  :hook (org-mode . org-modern-mode)
  )

(use-package ox-hugo
  :straight t
  :after ox
  )

(provide 'init-org)
