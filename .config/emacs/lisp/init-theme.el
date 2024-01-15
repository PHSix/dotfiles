(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-tokyo-night t)
  ;; (load-theme 'doom-one t)
  ;; (load-theme 'doom-ayu-dark t)
  )

(use-package mood-line
  :straight t
  :config
  (mood-line-mode t)
  (setq mood-line-glyph-alist mood-line-glyphs-fira-code)
  (setq mood-line-evil-state-alist
	'((normal . ("[N]" . font-lock-variable-name-face))
	  (insert . ("[I]" . font-lock-string-face))
	  (visual . ("[V]" . font-lock-keyword-face))
	  (replace . ("[R]" . font-lock-type-face))
	  (motion . ("[M]" . font-lock-constant-face))
	  (operator . ("[O]" . font-lock-function-name-face))
	  (emacs . ("[E]" . font-lock-builtin-face)))
	)
  )

;;; all the icons dependences for every plugin which need icon display
(use-package all-the-icons
  :straight t
  :if (display-graphic-p)
  )

(use-package dashboard
  :straight t
  :config
  (setq dashboard-banner-logo-title "Weclome back Emacs~")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook)
  (add-hook 'dashboard-mode-hook #'dashboard-jump-to-recents)
  )

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode)
  )

;;; font customize
(if (eq system-type 'gnu/linux)
    (set-face-attribute 'default nil
			:family "Monaco"
			:height 150)
  (set-face-attribute 'default nil
		      :family "Monaco"
		      :height 190))

(defun +increment-font-size ()
  (interactive)
  (let ((current-height (face-attribute 'default :height)))
    (set-face-attribute
     'default nil
     :height (+ current-height 10)
     )
    )
  )

(defun +decrement-font-size ()
  (interactive)
  (let ((current-height (face-attribute 'default :height)))
    (set-face-attribute
     'default nil
     :height (- current-height 10)
     )
    )
  )

(global-set-key (kbd "M-=") #'+increment-font-size)
(global-set-key (kbd "M--") #'+decrement-font-size)

(use-package nerd-icons :straight t)

(provide 'init-theme)
