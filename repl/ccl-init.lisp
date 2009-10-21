;;  -*- mode: lisp -*-

#-asdf
(require :asdf)

#-asdf-install
(progn
  (pushnew #P"ccl:tools;asdf-install;"
           asdf:*central-registry*
           :test #'equal)
  (asdf:oos 'asdf:load-op :asdf-install))

(load (merge-pathnames ".common.lisp" (user-homedir-pathname)))
