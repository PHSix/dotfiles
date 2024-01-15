;; Check the `restart-emacs' command is exist?
;; If not will be install this extension. (In sometime, some emacs release have builtin support, just like `emacs-plus@29' )
(when (fboundp 'restart-emacs)
  (use-package restart-emacs
    :straight t
    )
  )

(use-package highlight-indent-guides
  :straight t
  :hook ((prog-mode text-mode conf-mode) .
	 (lambda ()
	   ( when(not (eq major-mode 'emacs-lisp-mode))
	     (highlight-indent-guides-mode)
	     )
	   ))
  :init
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-auto-character-face-perc 90)
  )

(use-package indent-guide
  :straight t
  :hook (emacs-lisp-mode . indent-guide-mode)
  )


;; (+load-repo
;;  "manateelazycat/blink-search"
;;  (lambda ()
;;    ;; only for blink search dependence
;;    (use-package posframe
;;      :straight t
;;      :after blink-search
;;     )
;;    (use-package blink-search
;;      :commands blink-search
;;      :config
;;      (setq blink-search-enable-posframe t)
;;      (define-key blink-search-mode-map
;; 		     "<escape>" #'blink-search-quit
;; 		     )
;;      (define-key blink-search-mode-map

;; 		     "C-j" #'blink-search-candidate-select-next
;; 		 )
;;      (define-key blink-search-mode-map
;; 		     "C-k" #'blink-search-candidate-select-prev
;; 		 )

;;      )))


(+load-repo
 "manateelazycat/toggle-one-window"
 (lambda ()
   (use-package toggle-one-window
     :config
     )
   )
 )

;; (+load-repo
;;  "manateelazycat/auto-save"
;;  (lambda ()
;;    (use-package auto-save
;;      :defer t
;;      :config
;;      (auto-save-enable)
;;      (setq auto-save-silent t)   ; quietly save
;;      )
;;    )
;;  )

(use-package hl-todo
  :straight t
  :hook (prog-mode-hook . hl-todo-mode)
  )

(provide 'init-tools)

