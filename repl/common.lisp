;;  -*- mode: lisp -*-

#+asdf
(pushnew (merge-pathnames "lib/lisp/systems/" (user-homedir-pathname))
         asdf:*central-registry*
         :test #'equal)
(unless (fboundp 'asdf)
  (defun asdf (lib)
    "Shortcut for ASDF."
    (asdf:oos 'asdf:load-op lib)))
