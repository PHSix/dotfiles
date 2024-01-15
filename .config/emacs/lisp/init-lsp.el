(use-package yasnippet
  :straight t
  :config
  (yas-global-mode 1)
  )


(use-package yasnippet-snippets
  :straight t
  )

(setq emacs-lsp-type 'lsp-mode)

;; preset check `lsp-bridge' has clone in local and `python3' are executable.
(when (eq emacs-lsp-type 'lsp-bridge)
  (+load-repo
   "manateelazycat/lsp-bridge"
   (lambda ()
     (use-package lsp-bridge
       :after yasnippet
       :init
       (setq lsp-bridge-user-langserver-dir (expand-file-name "langserver" user-emacs-directory)
	     lsp-bridge-enable-hover-diagnostic t
	     )
       
       :config
       (require 'lsp-bridge)
       
       (evil-define-key 'normal lsp-bridge-mode-map
	 (kbd "g d") 'lsp-bridge-find-def
	 (kbd "g r") 'lsp-bridge-find-references
	 (kbd "g y") 'lsp-bridge-find-type-def-other-window
	 (kbd "K") 'lsp-bridge-popup-documentation
	 
	 (kbd "<leader> j") 'lsp-bridge-diagnostic-jump-next
	 (kbd "<leader> k") 'lsp-bridge-diagnostic-jump-prev
	 
	 (kbd "<leader> d l") 'lsp-bridge-diagnostic-list
	 
	 (kbd "<leader> c a") 'lsp-bridge-code-action
	 (kbd "<leader> r n") 'lsp-bridge-rename
	 
	 (kbd "<leader> f s") 'lsp-bridge-workspace-list-symbols
	 )
       
       (evil-define-key 'normal lsp-bridge-ref-mode-map
	 (kbd "RET") 'lsp-bridge-ref-open-file-and-stay
	 (kbd "q") 'lsp-bridge-ref-quit
	 (kbd "j") 'lsp-bridge-ref-jump-next-keyword
	 (kbd "k") 'lsp-bridge-ref-jump-prev-keyword
	 )
       
       ;; (evil-define-key 'normal 'lsp-bridge-peek-keymap
       ;;   (kbd "<escape>") #'lsp-bridge-peek-abort
       ;;   (kbd "j") #'lsp-bridge-peek-tree-next-node
       ;;   (kbd "k") #'lsp-bridge-peek-tree-previous-node
       ;;   )
       
       ;; to map key of acm-mode-map in evil insert mode.
       (evil-define-key 'insert acm-mode-map
	 (kbd "C-n") #'acm-select-next
	 (kbd "C-p") #'acm-select-prev
	 )
       ;; more detail message please see: https://github.com/manateelazycat/lsp-bridge/issues/516#issuecomment-1445094558
       (add-hook 'acm-mode-hook #'evil-normalize-keymaps)
       
       (add-hook 'lsp-bridge-peek-mode-hook #'evil-normalize-keymaps)
       
       ;; manual add vue file lsp-bridge-mode detect
       (add-to-list 'lsp-bridge-single-lang-server-extension-list '(("vue") . "volar"))
       
       (dolist (hook `(
		       web-mode-hook
		       typescript-mode-hook
		       emacs-lisp-mode-hook
		       lisp-interaction-mode-hook
		       go-mode-hook
		       rust-mode-hook
		       ))
	 (add-hook hook 'lsp-bridge-mode)
	 )
       ))))

(when (eq emacs-lsp-type 'lsp-mode)
  (use-package lsp-mode
    :straight t
    :config
    (setq lsp-headerline-breadcrumb-enable nil
	  lsp-modeline-code-actions-mode nil
	  lsp-enable-symbol-highlighting nil
	  lsp-lens-enable nil
	  lsp-enable-indentation nil
	  lsp-completion-show-detail nil
    )
    (dolist (hook '(
 		    web-mode-hook
 		    go-mode-hook
 		    rust-mode-hook
		    typescript-mode-hook
		    scss-mode-hook
 		    ))
      (add-hook hook #'lsp-mode)
      )
    (evil-define-key 'normal 'lsp-mode-map
      (kbd "gd") #'lsp-ui-peek-find-definitions
      (kbd "gt") #'lsp-find-type-definition
      (kbd "gr") #'lsp-ui-peek-find-references
      (kbd "<leader>fs") #'consult-lsp-symbols
      (kbd "<leader>fd") #'consult-lsp-diagnostics
      (kbd "<leader>rn") #'lsp-rename
      (kbd "<leader>ca") #'lsp-code-action?
      
      (kbd "<leader>j") #'flymake-goto-next-error
      (kbd "<leader>k") #'flymake-goto-prev-error
      )
    )

  (use-package consult-lsp
    :straight t
    )

  (use-package lsp-ui
    :straight t
    :config
    (setq lsp-ui-doc-use-webkit t
	  lsp-ui-doc-position 'at-point
	  lsp-ui-doc-show-with-cursor nil
	  lsp-ui-sideline-enable nil
	  ))
  
  ;; https://github.com/company-mode/company-mode
  ;; 在 buffer 中提供美化的补全界面
  (use-package company
    :straight t
    :hook (prog-mode . company-mode)
    :config
    ;; We follow a suggestion by company maintainer u/hvis:
    ;; https://www.reddit.com/r/emacs/comments/nichkl/comment/gz1jr3s/
    (defun company-completion-styles (capf-fn &rest args)
      (let ((completion-styles '(basic partial-completion)))
	(apply capf-fn args)))
      
    (advice-add 'company-capf :around #'company-completion-styles)

    
    :custom
    (company-idle-delay 0)
    (company-require-match nil)
    
    (company-minimum-prefix-length 3)
    (company-tooltip-width-grow-only t)
    (company-tooltip-align-annotations t)
    (company-dabbrev-code-everywhere t)
    (company-tempo-expand t)
    
    (company-frontends
     '(company-preview-frontend
       company-echo-metadata-frontend))
    
    (company-backends
     '(company-capf
       company-files
       company-dabbrev)))

  ;; https://github.com/sebastiencs/company-box
  ;; 美化补全
  (use-package company-box
    :straight t
    :hook (company-mode . company-box-mode)
    :custom
    (company-box-icons-alist 'company-box-icons-all-the-icons))
  )

(provide 'init-lsp)
