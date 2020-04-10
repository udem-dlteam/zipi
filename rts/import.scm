(define py-import-root (pwd))

(define py-import-cache1 (make-PCache -1 -1))
(define py-import-cache2 (make-PCache -1 -1))
(define py-import-cache3 (make-PCache -1 -1))

;  +----------------------+     fallback for
;  |                      |     sys time and builtins
;  | py-import path depth +----------+
;  |                      |          v
;  +---------+------------+       +---+--------------------+
;            |                    |                        |returns pre-built
;            |                    | py-import-builtin path |Scheme modules
;            |   if not in cache  |                        |
;            | +---------------+  +------------------------+
;            | |               |
;  +---------v-+-----------+   |
;  |                       |   |              from here we will compile .py
;  | py-import-from-sysmod |   |       +----------------------------------+
;  | sysmod key path       |   +-------+                                  |
;  |                       |           | py-import-module sysmod key path |
;  +-----------------------+           |                                  |
;      looks at cache                  +----------------+-----------------+
;                                                       |
;     +------------+                 +------------------v--------------------+
;     |            |                 |                                       |
;     | loadv file +<----------------|  compile-to-scheme root source target |
;     |            |                 |                                       |
;     +------------+                 +---------------------------------------+
;      loads the file                  This compiles .py requires env ZIPIROOT
;                                      to be set otherwise it fallback on ..
;
;                                      Calls py19 -t gambit
;                                      --no-main -d root source > target

(define (py-import path depth)
   ;; (tprint "py-import root=" py-import-root " path=" path)
   (let ((sysmod (object-get (py-sys-mod) (& "modules") #f)))
      (cond
         ((py-import-builtin path)
          =>
          (lambda (mod)
             (sysmod-add-entry! sysmod (py-str-from-scheme path) mod)))
         (else
          (let loop ((paths (string-split path "."))
                     (base py-import-root)
                     (key #f)
                     (depth depth))
             (let ((qpath (make-file-name base (car paths)))
                   (key (py-str-from-scheme
                           (if key
                               (string-append (py-str-to-scheme key) "." (car paths))
                               (car paths)))))
                ;;(tprint "py-import.loop key=" key " paths=" paths " qp=" qpath)
                (cond
                   ((pair? (cdr paths))
                    (let* ((mod (or (py-import-from-sysmod sysmod key qpath)
                                    (py-import-dir sysmod key qpath)))
                           (submod (loop (cdr paths) qpath key (- depth 1))))
                    ;; (tprint "paths=" (cadr paths) " " key)
                    (if (> depth 0)
                        submod
                        (begin
                           (object-put-no-cache! mod
                              (py-string-to-name (cadr paths)) submod)
                           mod))))
                   ((file-exists? (string-append qpath ".py"))
                    (or (py-import-from-sysmod sysmod key qpath)
                        (py-import-module sysmod key qpath)))
                   ((directory? qpath)
                    (or (py-import-from-sysmod sysmod key qpath)
                        (py-import-dir sysmod key qpath)))
                   (else
                    (error "py-import" "ModuleNotFoundError" path)))))))))

(define (py-import-builtin path)
  (cond ((string=? path "builtins")
         (py-builtins-mod))
        ((string=? path "time")
         (py-time-mod))
        ((string=? path "sys")
         (py-sys-mod))
        (else
         #f)))

(define (sysmod-add-entry! sysmod key mod)
   (py-setitem sysmod key mod py-import-cache3)
   mod)

(define (py-import-from-sysmod sysmod key path)
  (if (py-contains sysmod key py-import-cache1)
      (let ((mod (py-getitem sysmod key py-import-cache2)))
        (if (eq? mod py-absent)
            (error "py-import" "ModuleNotFoundError" path)
            mod))
      #f))

(define (py-import-module sysmod key path)
   (let ((file (string-append path ".scm")))
      (compile-to-scheme py-import-root (string-append path ".py") file)
      (if (file-exists? file)
          (let* ((init (loadv file))
                 (mod (init)))
             (sysmod-add-entry! sysmod key mod))
          (error "py-import" "ModuleNotCompileError" path))))

(define (py-import-dir sysmod key path)
   (let ((init (make-file-path path "__init__.py")))
      (if (file-exists? init)
          (py-import-module sysmod key (make-file-path path "__init__"))
          (let ((mod
                 (py-obj-alloc
                  py-module-class
                  (make-HClass
                   (vector py-module-class py-object-class)
                   (vector (& "**class**")
                           (& "__class__")
                           (& "__name__")
                           (& "__file__")
                           )
                   '()))))
            (PyObject-elements-set! mod 1 py-object-class)
            (PyObject-elements-set! mod 2 (py-str-from-scheme path))
            (PyObject-elements-set! mod 3 (py-str-from-scheme path))
            (sysmod-add-entry! sysmod key mod)
            mod))))
