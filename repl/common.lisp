;;  -*- mode: lisp -*-

(let* ((lisp-path (merge-pathnames #P"lib/lisp/" (user-homedir-pathname)))
       (site-path (merge-pathnames #P"site/" lisp-path))
       (asdf-path (merge-pathnames #P"systems/" lisp-path)))
  #+asdf
  (pushnew asdf-path asdf:*central-registry* :test #'equal)
  #+asdf-install
  (let* ((description "Local installation")
         (location (list site-path asdf-path description)))
    (pushnew location asdf-install:*locations* :test #'equal)
    (setf asdf-install:*preferred-location* description)))

(unless (fboundp 'asdf)
  (defun asdf (lib)
    "Shortcut for ASDF."
    (asdf:oos 'asdf:load-op lib)))
