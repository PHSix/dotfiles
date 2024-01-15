(defun +load-repo (repo fn)
  "Load some local extension from `local-user-emacs-config-directory/repos/xxx' to `load-path'"
  (let (
	(repo-path (+expand-repo repo))
	)

    (when (eq nil (file-exists-p repo-path))
      (message (format "Clone %s repo..." repo))
      (shell-command (format "git clone https://github.com/%s %s" repo repo-path) "*Message*")
      )
    (add-to-list 'load-path repo-path)
    (funcall fn)
    )
  )

(defun +expand-repo (repo)
  (expand-file-name
   (format
    "repos/%s"
    (car (last (split-string repo "/"))))
   user-emacs-directory)
  )

(defun +define-key (keymap key def &rest bindings)
  (define-key keymap (if (stringp key) (kbd key) key) def)
  (let ((rest-bindings bindings))
    (while (> (length rest-bindings) 1)
      (setq key (car rest-bindings))
      (setq def (cadr rest-bindings))
      (define-key keymap (if (stringp key) (kbd key) key) def)
      (setq rest-bindings (cdr (cdr rest-bindings)))
      )
    )
  )

(defun +require (module &optional error-message)
  "A more safely require call method, do not stop after work when meet catch a error."
  (condition-case nil
      (progn
	(require module)
	)

    (progn
      (message (or error-message (format "require load module %s failed." module)))
      )
    )
  )


(defconst sys/linuxp
  (and (eq system-type 'gnu/linux)
       (not (string-match "-[Mm]icrosoft" operating-system-release)))
  "Are we running on a GNU/Linux system?")

(defconst sys/WSL
  (and (eq system-type 'gnu/linux)
       (string-match "-[Mm]icrosoft" operating-system-release))
  "Are we running on a GNU/Linux system?")

(defconst sys/win32p
  (eq system-type 'windows-nt)
  "Are we running on a WinTel system?")

(provide 'etc-lib)
