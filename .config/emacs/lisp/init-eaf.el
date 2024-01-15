;; only install `eaf' in linux platform.
(when (and (not sys/WSL) (not (eq system-type 'darwin)))
  (+load-repo
   "emacs-eaf/emacs-application-framework"
   (lambda ()
     (use-package eaf
       :config
       )
     )
   )
  )


(provide 'init-eaf)
