(defun +define-key (keymap &rest bindings)
  "Enhance `define-key' function, to support like evil-define-key mutil keydef."
  (define-key keymap (car bindings) (cadr bindings))
  (when (> (length (cddr bindings)) 0)
    (
     +define-key
     keymap
     (cddr bindings)
     )
    )
  )


(provide 'etc-enhance)
