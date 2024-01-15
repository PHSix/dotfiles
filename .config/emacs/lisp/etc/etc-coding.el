(defcustom initial-projects-table
  (let ((projects-table (make-hash-table :test 'equal)))
    (progn
      (puthash "nodejs" '("pnpm init") projects-table)
      (puthash "go" '("go mod init %s" "Input go mod module path: ") projects-table)

      projects-table
      )
    )
  ;; `(("nodejs(use npm init for a folder)" . "npm init") ("go mod()" "go mod init" t))
  "Custom enum of coding projects."
  )

(defun +init-project ()
  (interactive)
  (let
      (
       (project-localtion
	(read-file-name "New project location: " "~/")
	)
       (project-template
	(gethash
	 (completing-read
	  "Choose a template: " (hash-table-keys initial-projects-table)
	  )
	 initial-projects-table)
	)
       init-command
       shell-buffer
       )

    (setq init-command (car project-template))

      (setq init-command (format init-command (read-string argument-tip)))
      )


    (setq shell-buffer (generate-new-buffer "*init-project-process*"))
    (select-window (split-window-below 10))
    (switch-to-buffer shell-buffer)
    (async-shell-command (format "mkdir %s && cd %s && %s" project-location project-location init-command) shell-buffer)
    )


(provide 'etc-coding)
