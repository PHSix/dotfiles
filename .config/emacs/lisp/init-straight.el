;; straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; (setq straight-use-package-by-default t)

;; Expand use-package for straight.el
(straight-use-package 'use-package)

;; prescient sortter is core
;; (use-package prescient
;;   :straight t
;;   :config
;;   (setq prescient-filter-method '(regexp fuzzy))
;;   )


(provide 'init-straight)
