(define (py-import root path)
   ;;(tprint "py-import root=" root " path=" path)
   (let ((sysmod (object-get-no-cache (py-sys-mod) (& "modules"))))
      (cond
	 ((py-import-builtin path)
	  =>
	  (lambda (mod)
	     (sysmod-add-entry! sysmod (py-string-to-name path) mod)))
	 (else
	  (let loop ((paths (string-split path "."))
		     (base root)
		     (key #f)
		     (mod0 #f))
	     (let ((qpath (make-file-name base (car paths)))
		   (key (py-string-to-name
			   (if key
			       (string-append (symbol->string! key) "." (car paths))
			       (car paths)))))
		;;(tprint "py-import.loop key=" key " paths=" paths " " qpath)
		(cond
		   ((pair? (cdr paths))
		    (let ((mod (or (py-import-from-sysmod sysmod key path)
				   (py-import-dir base sysmod key qpath))))
		       (loop (cdr paths) qpath key mod)))
		   ((file-exists? (string-append qpath ".py"))
		    (let ((mod (or (py-import-from-sysmod sysmod key path)
				   (py-import-module root sysmod key qpath))))
		       (or mod0 mod)))
		   ((directory? qpath)
		    (let ((mod (py-import-dir root sysmod key qpath)))
		       (or mod0 mod)))
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
   ;; (tprint "*** sysmod-add-entry key=" key)
   (object-put-no-cache! sysmod key mod)
   mod)

(define (py-import-from-sysmod sysmod key path)
   (when (object-has sysmod key)
      (let ((mod (object-get-no-cache sysmod key)))
	 (if (eq? mod (py-none))
	     (error "py-import" "ModuleNotFoundError" path)
	     mod))))

(define (py-import-module root sysmod key path)
   (let ((file (string-append path ".scm")))
      (compile root (string-append path ".py") file)
      (if (file-exists? file)
	  (let* ((init (loadv file))
		 (mod (init)))
	     (sysmod-add-entry! sysmod key mod))
	  (error "py-import" "ModuleNotCompileError" path))))

(define (py-import-dir root sysmod key path)
   (let ((init (make-file-path path "__init__.py")))
      (if (file-exists? init)
	  (py-import-module root sysmod key (make-file-path path "__init__"))
	  (let ((mod (make-PyObject
			(make-HClass (vector (& "__name__")) '())
			(vector (py-str-from-scheme path)))))
	     (sysmod-add-entry! sysmod key mod)
	     mod))))
		    
