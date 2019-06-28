(define py-import-root (pwd))

(define (py-import path depth)
   ;; (tprint "py-import root=" py-import-root " path=" path)
   (let ((sysmod (object-get-no-cache (py-sys-mod) (& "modules"))))
      (cond
	 ((py-import-builtin path)
	  =>
	  (lambda (mod)
	     (sysmod-add-entry! sysmod (py-string-to-name path) mod)))
	 (else
	  (let loop ((paths (string-split path "."))
		     (base py-import-root)
		     (key #f)
		     (depth depth))
	     (let ((qpath (make-file-name base (car paths)))
		   (key (py-string-to-name
			   (if key
			       (string-append (symbol->string! key) "." (car paths))
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
   (cond
      ((string=? path "builtins")
       py-builtins-mod)
      ((string=? path "time")
       py-time-mod)
      ((string=? path "sys")
       (py-sys-mod))
      (else
       #f)))
   
(define (sysmod-add-entry! sysmod key mod)
   (object-put-no-cache! sysmod key mod)
   mod)

(define (py-import-from-sysmod sysmod key path)
   (when (object-has sysmod key)
      (let ((mod (object-get-no-cache sysmod key)))
	 (if (eq? mod (py-none))
	     (error "py-import" "ModuleNotFoundError" path)
	     mod))))

(define (py-import-module sysmod key path)
   (let ((file (string-append path ".scm")))
      (compile py-import-root (string-append path ".py") file)
      (if (file-exists? file)
	  (let* ((init (loadv file))
		 (mod (init)))
	     (sysmod-add-entry! sysmod key mod))
	  (error "py-import" "ModuleNotCompileError" path))))

(define (py-import-dir sysmod key path)
   (let ((init (make-file-path path "__init__.py")))
      (if (file-exists? init)
	  (py-import-module sysmod key (make-file-path path "__init__"))
	  (let ((mod (make-PyObject
			(make-HClass (vector (& "__name__")) '())
			(vector (py-str-from-scheme path)))))
	     (sysmod-add-entry! sysmod key mod)
	     mod))))
		    
