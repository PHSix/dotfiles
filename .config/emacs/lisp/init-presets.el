;; preset optimize
(when (display-graphic-p)
    (tool-bar-mode -1)

    (menu-bar-mode -1)
    (scroll-bar-mode -1)
  )

(defalias 'yes-or-no-p 'y-or-n-p)

;; disable system ring bell
(setq ring-bell-function 'ignore)

(mapc (lambda (hook) 
	(add-hook hook 
		  (lambda ()
		    (display-line-numbers-mode t)
		    (hl-line-mode t)
		    )))
      `(prog-mode-hook text-mode-hook conf-mode-hook))

;; disable the blink cursor (which I haif effect)
(blink-cursor-mode 0)
;; enable auto pair
(add-hook 'prog-mode-hook #'electric-pair-local-mode t)
(setq make-backup-files nil)
(setq scroll-step 1)

;; initial defualt indent size setting, use 4 space and tab mode
(setq tab-width 4)
(setq go-ts-mode-indent-offset 4)
(setq indent-tabs-mode t)

(setq inhibit-startup-screen t)

;; recentf files
(recentf-mode t)
(setq recentf-max-saved-items 200)
(setq c-basic-offset 4)

;; smooth scroll
(setq scroll-step            1
      scroll-conservatively  10000)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; map command key to meta (only on macos)
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'none)
  )

(add-hook 'after-init-hook #'toggle-frame-fullscreen)

(defun presets/tab-indent ()
  (setq-local tab-width 4)
  (indent-tabs-mode 1)
  )

;; disable default cut to clipboard behavior.
;; in many time cut will break the prepended system cliboard content.
(setq x-select-enable-clipboard nil)

(provide 'init-presets)
