;;  -*- mode: lisp -*-
;; ccl(1)

(let ((lisp-init (merge-pathnames ".common.lisp" (user-homedir-pathname))))
  (when (probe-file lisp-init)
    (load lisp-init)))
