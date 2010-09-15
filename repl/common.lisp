;;  -*- mode: lisp -*-

#+asdf
(let* ((home (user-homedir-pathname))
       (lib-path (merge-pathnames #P"lib/lisp/systems/" home))
       (src-path (merge-pathnames #P"src/lisp/systems/" home)))
  (pushnew lib-path asdf:*central-registry* :test #'equal)
  (pushnew src-path asdf:*central-registry* :test #'equal))

(unless (fboundp 'asdf)
  (defun asdf (lib)
    "Shortcut for ASDF."
    (asdf:oos 'asdf:load-op lib)))
