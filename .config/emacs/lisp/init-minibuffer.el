(use-package vertico
  :straight  (vertico :files (:defaults "extensions/*")
                      :includes (vertico-multiform))
  :init
  (vertico-mode t)
  (setq vertico-cycle t)
  (setq vertico-count 25)
  :config
  :bind
  (:map vertico-map
	("C-j" . 'vertico-next)
	("C-k" . 'vertico-previous)
	("<escape>" . 'abort-recursive-edit)))

;; for save command history, in `emacs@29' has builtin support.
(if (fboundp savehist-mode)
    (savehist-mode 1)
  (progn
    (use-package savehist
      :straight t
      :config
      (savehist-mode 1)
      )
    )
  )


(use-package orderless
  :straight t
  :after vertico
  :config
  (setq completion-styles '(orderless substring basic))
  (setq orderless-matching-styles '(orderless-regexp orderless-literal)
	)

  (use-package consult
    :straight t
    :config
    (setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator / --smart-case --with-filename --line-number --search-zip")
    (when (executable-find "fd")
      (defun consult--fd-builder (input)
	(let ((fd-command
               (if (eq 0 (process-file-shell-command "fdfind"))
		   "fdfind"
		 "fd")))
	  (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                       (`(,re . ,hl) (funcall consult--regexp-compiler
                                              arg 'extended t)))
	    (when re
              (cons (append
		     (list fd-command
			   "--color=never" "--full-path"
			   (consult--join-regexps re 'extended))
		     opts)
		    hl)))))

      (defun consult-fd (&optional dir initial)
	(interactive "P")
	(pcase-let* ((`(,prompt ,paths ,dir) (consult--directory-prompt "Fd" dir))
		     (default-directory dir))
	  (find-file (consult--find prompt #'consult--fd-builder initial))))
      )
    :bind (
	   ;; C-c bindings in `mode-specific-map'
           ("C-c M-x" . consult-mode-command)
           ("C-c h" . consult-history)
           ("C-c k" . consult-kmacro)
           ("C-c m" . consult-man)
           ("C-c i" . consult-info)
           ([remap Info-search] . consult-info)
           ;; C-x bindings in `ctl-x-map'
           ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
           ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
           ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
           ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
           ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
           ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
           ;; Custom M-# bindings for fast register access
           ("M-#" . consult-register-load)
           ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
           ("C-M-#" . consult-register)
           ;; Other custom bindings
           ("M-y" . consult-yank-pop)                ;; orig. yank-pop
           ;; M-g bindings in `goto-map'
           ("M-g e" . consult-compile-error)
           ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
           ("M-g g" . consult-goto-line)             ;; orig. goto-line
           ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
           ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
           ("M-g m" . consult-mark)
           ("M-g k" . consult-global-mark)
           ("M-g i" . consult-imenu)
           ("M-g I" . consult-imenu-multi)
           ;; M-s bindings in `search-map'
           ("M-s d" . consult-find)
           ("M-s D" . consult-locate)
           ("M-s g" . consult-grep)
           ("M-s G" . consult-git-grep)
           ("M-s r" . consult-ripgrep)
           ("M-s l" . consult-line)
           ("M-s L" . consult-line-multi)
           ("M-s k" . consult-keep-lines)
           ("M-s u" . consult-focus-lines)
           ;; Isearch integration
           ("M-s e" . consult-isearch-history)
           :map isearch-mode-map
           ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
           ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
           ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
           ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
           ;; Minibuffer history

           ("M-s" . consult-history)                 ;; orig. next-matching-history-element
           ("M-r" . consult-history))                ;; orig. previous-matching-history-element
    ))

(use-package vertico-posframe
  :straight t
  :after vertico
  :config
  (setq vertico-posframe-border-width 3)
  (vertico-posframe-mode t)
  )

(provide 'init-minibuffer)
