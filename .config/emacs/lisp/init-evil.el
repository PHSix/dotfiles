(use-package undo-fu
  :straight t
  :after evil
  :init
  (setq evil-undo-system 'undo-fu)
  )

(use-package undo-fu-session
  :straight t
  :after undo-fu
  :config
  (undo-fu-session-global-mode)
  )

(use-package evil :straight t
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-symbol-word-search t
	evil-want-C-u-scroll t
	evil-mode-line-format 'nil
	)
  :config

  (defun +close-current-buffer ()
    (interactive)
    (kill-buffer (current-buffer))
    )
  
  ;; paste from system clipboard
  (defun evil-paste-after-from-+ ()
    (interactive)
    (let ((evil-this-register ?+))
      (call-interactively 'evil-paste-after)))
  (defun evil-yank-to-+ ()
    (interactive)
    (let ((evil-this-register ?+))
      (call-interactively 'evil-yank)))

  (defvar +evil-smooth-scroll-steps 10
    "Number of steps for smooth scrolling animation.")
  
  (defun +evil-smooth-scroll-half-page-down ()
    "Smoothly scroll down with animation."
    (interactive)
    (let* ((scroll-lines-per-step (/ (window-body-height) +evil-smooth-scroll-steps 2))
           (scroll-amount (- (window-body-height) scroll-lines-per-step))
           (scroll-delay 0.02))  ; Delay between each scroll step in seconds
      
      (dotimes (i +evil-smooth-scroll-steps)
	(evil-next-line scroll-lines-per-step)
	(redisplay t)
	(sit-for scroll-delay))))

  (defun +evil-smooth-scroll-half-page-up ()
    "Smoothly scroll down with animation."
    (interactive)
    (let* ((scroll-lines-per-step (/ (window-body-height) +evil-smooth-scroll-steps 2))
           (scroll-amount (- (window-body-height) scroll-lines-per-step))
           (scroll-delay 0.02))  ; Delay between each scroll step in seconds
      
      (dotimes (i +evil-smooth-scroll-steps)
	(evil-previous-line scroll-lines-per-step)
	(redisplay t)
	(sit-for scroll-delay))))

  (define-key evil-normal-state-map "fp" 'evil-paste-after-from-+)
  (define-key evil-visual-state-map "fy" 'evil-yank-to-+)

  (evil-mode t)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-set-leader 'visual (kbd "SPC"))
  (evil-define-key 'normal 'global
    (kbd ";") #'evil-ex
    (kbd "C-s") 'save-buffer
    )

  (evil-define-key 'insert 'global (kbd "M-v") #'clipboard-yank)

  (evil-define-key 'normal 'global
    (kbd "<leader> f f") #'consult-fd
    (kbd "<leader> f b") #'consult-buffer
    (kbd "<leader> f w") #'consult-ripgrep
    (kbd "<leader> f o") #'consult-recent-file

    (kbd "<leader> b d") #'+close-current-buffer

    (kbd "<leader> s l") #'split-window-right
    (kbd "<leader> s j") #'split-window-below
    (kbd "<leader> s f") #'toggle-one-window
    )

  
  (evil-define-key 'normal 'global (kbd "C-u") #'+evil-smooth-scroll-half-page-up)
  (evil-define-key 'normal 'global (kbd "C-d") #'+evil-smooth-scroll-half-page-down)
  )


(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :straight t
  :config
  (evil-define-key 'visual 'global
    (kbd "g c") #'evilnc-comment-or-uncomment-lines
    )
  (evil-define-key 'normal 'global
    (kbd "g c c") #'evilnc-comment-or-uncomment-lines
    )
  )

(use-package evil-easymotion
  :straight t
  )

(use-package evil-surround
  :straight t
  :after evil
  :config
  (global-evil-surround-mode 1)
  )


(use-package which-key
  :straight t
  :init
  (which-key-mode)
  :config
  (which-key-setup-side-window-bottom)
  )

(provide 'init-evil)
