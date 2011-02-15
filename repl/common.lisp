;;  -*- mode: lisp -*-
;; Quicklisp and ASDF

#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

#+asdf
(let* ((homedir (user-homedir-pathname))
       (lib-systems (merge-pathnames #P"lib/lisp/systems/" homedir))
       (src-systems (merge-pathnames #P"src/lisp/systems/" homedir)))
  (pushnew lib-systems asdf:*central-registry* :test #'equal)
  (pushnew src-systems asdf:*central-registry* :test #'equal))

#+asdf
(unless (fboundp 'asdf)
  (defun asdf (lib)
    "Shortcut for ASDF."
    (asdf:oos 'asdf:load-op lib)))
