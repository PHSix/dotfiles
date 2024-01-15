(use-package vterm
  :straight t
  :config
  (setq vterm-kill-buffer-on-exit t)

  ;; set vterm buffer local font face
  (add-hook 'vterm-mode-hook
          (lambda ()
            (set (make-local-variable 'buffer-face-mode-face) 'hack-nerd-font)
            (buffer-face-mode t)))
  (evil-define-key 'insert 'vterm-mode-map
    (kbd "C-c") 'vterm-send-C-c
    )
  )

(use-package vterm-toggle
  :straight t
  :config


  ;; show vterm buffer in bottom side window
  (setq vterm-toggle-fullscreen-p nil)
  (add-to-list 'display-buffer-alist
	       '((lambda (buffer-or-name _)
		   (let ((buffer (get-buffer buffer-or-name)))
		     (with-current-buffer buffer
		       (or (equal major-mode 'vterm-mode)
			   (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		 (display-buffer-reuse-window display-buffer-in-side-window)
		 (side . bottom)
		 (reusable-frames . visible)
		 (window-height . 0.3)))


  (evil-define-key 'normal 'global (kbd "C-t") #'vterm-toggle)
  (evil-define-key 'insert 'vterm-mode-map
    (kbd "C-t") #'vterm-toggle
    )
  (when (eq system-type 'darwin)
    (evil-define-key 'insert 'vterm-mode-map
      (kbd "M-v") #'vterm-yank
      )
    )
  )


(provide 'init-shell)
