;*=====================================================================*/
;*    serrano/prgm/project/hop/hop/zpc/parseargs.scm                   */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri Nov 12 13:32:52 2004                          */
;*    Last change :  Tue Jun  2 08:19:42 2020 (serrano)                */
;*    Copyright   :  2004-21 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    Hop command line parsing                                         */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module zpc_parseargs

   (import  zpc_param
	    zpc_driver
	    zpc_libdir
	    zpc_configure)
   
   (export  (parse-args ::pair-nil)))

;*---------------------------------------------------------------------*/
;*    usage ...                                                        */
;*---------------------------------------------------------------------*/
(define (usage args-parse-usage)
   (print "Zpc v" (zipi-release))
   (print "usage: zpc [options] -- [bigloo-options]")
   (args-parse-usage #f)
   (newline)
   (print "Shell Variables:")
   (print "   - ZIPITRACE: zipi internal trace [ZIPITRACE=\"key1, key2, ...\"]")
   (print "      zpc:stage, zpc:type, zpc:type+, zpc:hint, zpc:range, zpc:usage, zpc:key,")
   (print "      zpc:loc, zpc:cache, zpc:dump, zpc:info, zpc:size, zpc:tail")
   (print "      zpc:profid, nodejs:compile,")
   (print "      zipi:cache[num] (*), zipi:uncache,")
   (print "      zipi:alloc[num], zipi:call, zipi:hint[num] (*)")
   (print "      zipi:function[num] zipi:symtable")
   (print "      zipi:fprofile (alias of \"zipi:cache zipi:call format:fprofile\")")
   (print "      format:json, format:fprofile, format:memviz, srcfile=path, logfile=path")
   (print "   - ZPCFLAGS: zpc compilation flags")
   (print " (*) Need both compile and runtime variable and need to be compiled")
   (print " in profile mode: --profile")
   (newline))

;*---------------------------------------------------------------------*/
;*    parse-args ...                                                   */
;*---------------------------------------------------------------------*/
(define (parse-args args)
   (let ((rc-file #unspecified)
	 (loadp #t)
	 (exprs '())
	 (login #f)
	 (command-string #f)
	 (source-map #t)
	 (lib-dir (zpc-library-path))
	 (configs '()))
      (bind-exit (stop)
	 (args-parse (cdr args)
	    ((("-h" "--help") (help "This message"))
	     (usage args-parse-usage)
	     (exit 0))
	    (("--version" (help "Print the version and exit"))
	     (print "zpc-" (zipi-release))
	     (exit 0))
	    (("-q" (help "Do not load an init file"))
	     (set! loadp #f))
	    (("--rc-file" ?file (help "Load alternate rc file"))
	     (set! rc-file file))
	    (("--rc-dir" ?dir (help "Set rc directory"))
	     (zpc-rc-directory-set! dir))
	    (("--lib-dir=?dir" (help "Set zipi lib-dir"))
	     (set! lib-dir dir))
	    (("--bin-dir=?dir" (help "Set zipi bin-dir"))
	     (zpc-bin-dir-set! dir))
	    (("-L" ?dir (help "Add Zipi library path"))
	     (bigloo-library-path-set! (cons dir (bigloo-library-path))))
	    (("-v?level" (help "Increase/set verbosity level (-v0 crystal silence)"))
	     (if (string=? level "")
		 (zpc-verbose-set! (+fx 1 (zpc-verbose)))
		 (zpc-verbose-set! (string->integer level))))
	    (("-O?level" (help "Optimization level"))
	     (cond
		((string=? level "")
		 (zpc-optim-level-set! 1))
		((string=? level "x")
		 (zpc-optim-level-set! 1000)
		 (zpc-pyc-flags-set! (cons* :optim-ccall #t (zpc-pyc-flags))))
		((string=? level "s")
		 (zpc-optim-level-set! 2)
		 (zpc-pyc-flags-set! (cons* :optim-size 1 (zpc-pyc-flags))))
		((string=? level "2s")
		 (zpc-optim-level-set! 2)
		 (zpc-pyc-flags-set! (cons* :optim-size 2 (zpc-pyc-flags))))
		(else
		 (zpc-optim-level-set! (string->integer level))))
	     (zpc-bigloo-options-set!
		(cons (format "-O~a" (min (zpc-optim-level) 6))
		   (zpc-bigloo-options))))
	    (("-g?level" (help "Increase or set debug level"))
	     (bigloo-warning-set! (string->integer level))
	     (if (string=? level "")
		 (bigloo-debug-set! (+fx 1 (bigloo-debug)))
		 (bigloo-debug-set! (string->integer level)))
	     (zpc-bigloo-options-set!
		(cons (format "-g~a" level) (zpc-bigloo-options))))
	    (("-w?level" (help "Increase or set warning level (-w0 no warning)"))
	     (if (string=? level "")
		 (bigloo-warning-set! (+fx 1 (bigloo-warning)))
		 (bigloo-warning-set! (string->integer level))))
	    (("--no-color" (help "Disable colored traces"))
	     (bigloo-trace-color-set! #f))
	    (("--eval" ?string (help "Evaluate string"))
	     (set! exprs (cons string exprs)))
	    (("-o" ?file (help "Name the output file"))
	     (zpc-destination-set! file))
	    ((("-m" "--module-name") ?name (help "Bigloo module name"))
	     (zpc-py-module-name-set! name))
	    ((("--py-module-main") (help "Generate a main module clause"))
	     (zpc-main-set! #t))
	    ((("--no-py-module-main") (help "Do not generate a main module clause"))
	     (zpc-main-set! #f))
	    ((("--bootstrap") (help "Generate a bootstrap module"))
	     (zpc-main-set! #f)
	     (zpc-pyc-flags-set! (cons* :bootstrap #t (zpc-pyc-flags))))
	    (("-t" ?file (help "Name the temporary file"))
	     (zpc-temp-set! file))
	    (("-s" (help "Stop after Bigloo code generation"))
	     (zpc-pass-set! 'bigloo))
	    (("-c" (help "Stop after code object generation"))
	     (zpc-pass-set! 'object)
	     (zpc-bigloo-options-set!
		(append (zpc-bigloo-options) (list "-c"))))
	    (("-y" (help "Generate a shared library"))
	     (zpc-pass-set! 'so))
	    ((("-j" "--client-js") (help "Generate a client-side JavaScript file"))
	     (zpc-pass-set! 'client-js))
	    (("--ast" ?ast (help "The source is an abstract syntax tree"))
	     (zpc-source-ast-set! ast))
	    (("--ast-file" ?ast (help "The source is an abstract syntax tree in a file"))
	     (zpc-source-ast-file-set! ast))
	    (section "Configuration and devkit")
	    (("--safe" (help "Compile and link in safe mode"))
	     (zpc-bigloo-safe-option-set! '("-unsafe" "-safel")))
	    (("--safe-debug" (help "Compile and link in safe mode"))
	     (zpc-bigloo-safe-option-set! '("-safe")))
	    (("--unsafe" (help "Compile and link in safe mode"))
	     (zpc-bigloo-safe-option-set! '("-unsafe")))
	    (("--bigloo=?bigloo" (help "Set the Bigloo binary file path"))
	     (zpc-bigloo-set! bigloo))
	    (("--bigloo-lib-dir=?dir" (help "Set the Bigloo library path"))
	     (bigloo-override-config! dir)
	     (zpc-bigloo-options-set!
		(cons* "-lib-dir" dir (zpc-bigloo-options))))
	    (("--reset-bigloo-options" (help "Reset all Bigloo options"))
	     (zpc-bigloo-options-set! '()))
	    ((("-a" "--afile") ?file (help "Set access file"))
	     (zpc-access-file-set! file))
	    (("--configure" ?config (help "Report zpc configuration"))
	     (set! configs (cons config configs)))
	    (section "Code generation")
	    (("--libs-dir" ?DIR (help "Generate libs-dir directive (main only)"))
	     (zpc-libs-dir-set! DIR))
	    (("--sobase" ?DIR (help "Set the base directory for shared libs (default (pwd))"))
	     (zpc-sobase-set! DIR))
	    (section "Optimization, profiling, and Debugging")
	    (("-fglobals" (help "Enable global variables optimization (-Ox)"))
	     (zpc-pyc-flags-set! (cons* :optim-globals #t (zpc-pyc-flags))))
	    (("-fno-globals" (help "Disable global variables optimization"))
	     (zpc-pyc-flags-set! (cons* :optim-globals #f (zpc-pyc-flags))))
	    (("--profile" (help "Profiling mode (see HOPTRACE)"))
	     (zpc-bigloo-profile-options-set! '("-srfi" "profile"))
	     (zpc-pyc-flags-set! (cons* :profile #t (zpc-pyc-flags))))
	    (("--profile-cache" (help "Cache profiling mode (see HOPTRACE)"))
	     (zpc-bigloo-profile-options-set! '("-srfi" "profile"))
	     (zpc-pyc-flags-set! (cons* :profile-cache #t (zpc-pyc-flags))))
	    (("--profile-location" (help "Location profiling mode"))
	     (zpc-pyc-flags-set! (cons* :profile-location #t (zpc-pyc-flags))))
	    (("--profile-hint" (help "Hint profiling mode (see HOPTRACE)"))
	     (zpc-pyc-flags-set! (cons* :profile-hint #t (zpc-pyc-flags))))
	    (("--profile-call" (help "Call profiling mode (see HOPTRACE)"))
	     (zpc-pyc-flags-set! (cons* :profile-call #t (zpc-pyc-flags))))
	    (("--profile-method" (help "Method profiling mode (see HOPTRACE)"))
	     (zpc-pyc-flags-set! (cons* :profile-method #t (zpc-pyc-flags))))
	    (("--profile-alloc" (help "Alloc profiling mode (see HOPTRACE)"))
	     (zpc-bigloo-profile-options-set! '("-srfi" "profile"))
	     (zpc-pyc-flags-set! (cons* :profile-alloc #t (zpc-pyc-flags))))
	    (("--profile-symbols" (help "Profile with a symbol table"))
	     (zpc-pyc-flags-set! (cons* :profile-symbols #t (zpc-pyc-flags))))
	    (("--profile-mem?level" (help "Memory profiling mode (see bmem)"))
	     (zpc-pyc-flags-set! (cons* :profile-mem level (zpc-pyc-flags)))
	     (if (string=? level "")
		 (zpc-bigloo-profile-options-set! '("-gtraceall"))
		 (let ((gtrace (string-append "-gtrace" level)))
		    (zpc-bigloo-profile-options-set! `(,gtrace)))))
	    (else
	     (if (string=? else "--")
		 (begin
		    (zpc-bigloo-options-set!
		       (append (zpc-bigloo-options) (cdr rest)))
		    (stop #t))
		 (zpc-sources-set! (append (zpc-sources) (list else)))))))
      ;; hop-lib-dir
      (zpc-bigloo-options-set!
	 (append `("-L" ,lib-dir) (zpc-bigloo-options)))
      (zpc-library-path-set! lib-dir)
      (when loadp
	 (zpc-load-rc
	    (if (string? rc-file)
		rc-file
		(let ((path (make-file-name (zpc-rc-directory) (zpc-rc-file))))
		   (if (file-exists? path)
		       path
		       (make-file-name (zipi-etc-dir) (zpc-rc-file)))))))
      ;; config report
      (when (pair? configs)
	 (zpc-configure configs lib-dir)
	 (exit 0))
      
      exprs))

;*---------------------------------------------------------------------*/
;*    zpc-load-rc ...                                                  */
;*---------------------------------------------------------------------*/
(define (zpc-load-rc path)
   (if (string? path)
       (when (file-exists? path)
	  (when (>=fx (zpc-verbose) 2)
	     (print "Loading `" path "'...\n"))
	  (loadq path))))      

;*---------------------------------------------------------------------*/
;*    zpc-configure ...                                                */
;*---------------------------------------------------------------------*/
(define (zpc-configure keys lib-dir)
   (call-with-input-file (make-file-name lib-dir "zpc_config.sch")
      (lambda (ip)
	 (let ((version (eval (read ip)))
	       (configs (eval (read ip))))
	    (for-each (lambda (s)
			 (let* ((k (string->symbol s))
				(c (assq k configs)))
			    (cond
			       ((pair? c)
				(print (cdr c)))
			       ((eq? k '--so-dirname)
				(print
				   (make-file-path
				      (cdr (assq '--version configs))
				      (cdr (assq '--build-id configs))
				      (cdr (assq '--build-arch configs)))))
			       (else
				(error "zpc"
				   (format "Unknown key \"~a\"" k)
				   configs)))))
	       keys)))))
