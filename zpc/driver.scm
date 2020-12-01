;*=====================================================================*/
;*    serrano/prgm/project/zipi/zpc/driver.scm                         */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Mon Apr 14 08:13:05 2014                          */
;*    Last change :  Sun Mar 29 06:47:58 2020 (serrano)                */
;*    Copyright   :  2014-20 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    ZPC compiler driver                                              */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module zpc_driver
   
   (library pyc)

   (import  zpc_parseargs
	    zpc_param)

   (eval    (library pyc))

   (export  (compile-sources::int)))

;*---------------------------------------------------------------------*/
;*    zpc-read ...                                                     */
;*---------------------------------------------------------------------*/
(define (zpc-read p #!key cenv menv)
   (if (=fx (bigloo-debug) 0)
       (begin
	  (bigloo-debug-set! 1)
	  (let ((v (read p)))
	     (bigloo-debug-set! 0)
	     v))
       (read p)))

;*---------------------------------------------------------------------*/
;*    py-driver ...                                                    */
;*---------------------------------------------------------------------*/
(define (py-driver)
   (cond
      ((eq? (zpc-pass) 'javascript)
       (pyc-javascript-driver))
      ((>=fx (zpc-optim-level) 1)
       (pyc-bigloo-driver))
      (else
       (pyc-bigloo-driver))))

;*---------------------------------------------------------------------*/
;*    compile-sources ...                                              */
;*---------------------------------------------------------------------*/
(define (compile-sources::int)
   
   (define (input-file->module-name path)
      (let* ((dir (dirname path))
	     (mod (prefix (basename path))))
	 (if (string=? dir ".")
	     mod
	     (format "%%~a_~a" dir mod))))
   
   (define (generate-javascript::int fname in)
      '(call-with-input-file fname
	 (lambda (in) (compile p in))))
   
   (define (generate-bigloo::int fname in)
      
      (define (generate out::output-port)
	 (for-each (lambda (exp) (pp exp out))
	    (pyc (py-driver)
	       (cons*
		  :optim (zpc-optim-level)
		  :debug (bigloo-debug)
		  :verbose (zpc-verbose)
		  :src in
		  :main (zpc-main)
		  :module-name (or (zpc-py-module-name) 
				   (input-file->module-name fname))
		  :src fname
		  :bin-dir (zpc-bin-dir)
		  (zpc-pyc-flags)))))
      
      (if (string? (zpc-destination))
	  (call-with-output-file (zpc-destination)
	     (lambda (out) (generate out)))
	  (generate (current-output-port)))
      0)
   
   (define (compile-bigloo::int fname in)

      (define (srfi-opts)
	 '("-srfi" "zpc"))

      0)

;*       (define (compile-file opts file)                              */
;*          (let* ((opts (append (cons file (srfi-opts)) opts))        */
;*                 (proc (apply run-process (zpc-bigloo) opts))        */
;*                 (cmd (format "~a ~l" (zpc-bigloo) opts)))           */
;*             (signal sigterm                                         */
;*                (lambda (sig)                                        */
;*                   (process-kill proc)                               */
;*                   (exit 1)))                                        */
;* 	    (when (>=fx (zpc-verbose) 4) (print cmd))                  */
;* 	    (process-wait proc)                                        */
;*             (process-exit-status proc)))                            */
;*                                                                     */
;*       (define (compile-temp opts comp file temp)                    */
;* 	 (call-with-output-file temp comp)                             */
;* 	 (compile-file opts temp))                                     */
;*                                                                     */
;*       (define (compile-temp-ast opts comp file temp)                */
;* 	 (call-with-output-file temp comp)                             */
;* 	 (let* ((baseopts (cons "-fread-internal-src"                  */
;* 			     (append (srfi-opts) opts)))               */
;* 		(opts (if (string? file)                               */
;* 			  (cons* "-fread-internal-src-file-name" file baseopts) */
;* 			  baseopts))                                   */
;* 		(proc (apply run-process (zpc-bigloo)                  */
;* 			 "-suffix" "ast" temp                          */
;* 			 opts))                                        */
;* 		(cmd (format "~a -suffix ast ~a ~l" (zpc-bigloo) temp opts)) */
;* 		(out (process-input-port proc)))                       */
;* 	    (signal sigterm                                            */
;* 	       (lambda (sig)                                           */
;* 		  (process-kill proc)                                  */
;* 		  (exit 1)))                                           */
;* 	    (when (>=fx (zpc-verbose) 4) (print cmd))                  */
;* 	    (unwind-protect                                            */
;* 	       (begin                                                  */
;* 		  (process-wait proc)                                  */
;* 		  (process-exit-status proc))                          */
;* 	       (delete-file temp))))                                   */
;*                                                                     */
;*       (define (compile-pipe opts comp file)                         */
;*          (let* ((baseopts (cons "-fread-internal-src"               */
;* 			     (append (srfi-opts) opts)))               */
;*                 (opts (if (string? file)                            */
;*                           (cons* "-fread-internal-src-file-name" file baseopts) */
;*                           baseopts))                                */
;*                 (proc (apply run-process (zpc-bigloo)               */
;*                          input: pipe: "-"                           */
;*                          opts))                                     */
;*                 (cmd (format "~a - ~l" (zpc-bigloo) opts))          */
;*                 (out (process-input-port proc)))                    */
;*             (signal sigterm                                         */
;*                (lambda (sig)                                        */
;*                   (process-kill proc)                               */
;*                   (exit 1)))                                        */
;*             (unwind-protect                                         */
;*                (comp out)                                           */
;*                (begin                                               */
;* 		  (when (>=fx (zpc-verbose) 4) (print cmd))            */
;*                   (close-output-port out)))                         */
;*             (process-wait proc)                                     */
;* 	    (process-exit-status proc)))                               */
;*                                                                     */
;*       (define (compiler opts comp file temp)                        */
;* 	 (cond                                                         */
;* 	    ((not comp)                                                */
;* 	     (compile-file opts file))                                 */
;* 	    ((string? temp)                                            */
;* 	     (compile-temp opts comp file temp))                       */
;* 	    ((> (file-size file) (zpc-pipe-filesize-threshold))        */
;* 	     (compile-temp-ast opts comp file                          */
;* 		(make-file-name (os-tmp)                               */
;* 		   (string-append (basename file) ".ast"))))           */
;* 	    (else                                                      */
;* 	     (compile-pipe opts comp file))))                          */
;*                                                                     */
;*       (define (compile-scheme in opts file temp)                    */
;* 	 (compiler                                                     */
;* 	    (append `("-fread-internal-src"                            */
;* 			"--force-cc-o"                                 */
;* 			"-rpath" ,(zpc-library-path)                   */
;* 			"-I" ,(dirname file))                          */
;* 	       opts)                                                   */
;* 	    (lambda (out)                                              */
;* 	       (let loop ()                                            */
;* 		  (let ((exp (zpc-read in)))                           */
;* 		     (unless (eof-object? exp)                         */
;* 			(write (obj->string exp) out)                  */
;* 			(loop)))))                                     */
;* 	    file                                                       */
;* 	    temp))                                                     */
;*                                                                     */
;*       (define (compile-python in opts file exec temp)               */
;* 	 (let ((mmap (when (and (string? fname) (file-exists? fname))  */
;* 			(open-mmap fname :read #t :write #f))))        */
;* 	    (compiler                                                  */
;* 	       (append (zpc-py-libraries)                              */
;* 		  `("--force-cc-o"                                     */
;* 		      "-rpath" ,(zpc-library-path))                    */
;* 		  opts)                                                */
;* 	       (lambda (out)                                           */
;* 		  (when (string? temp)                                 */
;* 		     (display ";; " out)                               */
;* 		     (display (format "~( )" (command-line)) out)      */
;* 		     (newline out))                                    */
;* 		  ;; compile                                           */
;* 		  (map (lambda (e)                                     */
;* 			  (if (string? temp)                           */
;* 			      (pp e out)                               */
;* 			      (write (obj->string e) out)))            */
;* 		     (apply pyc-compile in                             */
;* 			:return-as-exit (zpc-py-return-as-exit)        */
;* 			:mmap-src mmap                                 */
;* 			:filename fname                                */
;* 			:driver (py-driver)                            */
;* 			:module-main (if (boolean? (zpc-py-module-main)) */
;* 					 (zpc-py-module-main)          */
;* 					 (not (memq (zpc-pass) '(object so)))) */
;* 			:module-name (or (zpc-py-module-name)          */
;* 					 (input-file->module-name fname)) */
;* 			:module-path (zpc-py-module-path)              */
;* 			:optim (zpc-optim-level)                       */
;* 			:verbose (zpc-verbose)                         */
;* 			:libs-dir (zpc-libs-dir)                       */
;* 			:debug (bigloo-debug)                          */
;* 			:function-nice-name (string? temp)             */
;* 			(zpc-pyc-flags))))                             */
;* 	       file                                                    */
;* 	       temp)))                                                 */
;*                                                                     */
;*       (define (bigloo-options)                                      */
;* 	 (let ((l (zpc-optim-level)))                                  */
;* 	    (let loop ((opts (zpc-bigloo-O-options))                   */
;* 		       (o '()))                                        */
;* 	       (cond                                                   */
;* 		  ((null? opts)                                        */
;* 		   (let ((opts (append (zpc-bigloo-options)            */
;* 				  (zpc-bigloo-profile-options)         */
;* 				  (reverse! o))))                      */
;* 		      (cond                                            */
;* 			 ((pair? (zpc-bigloo-safe-option))             */
;* 			  (append (zpc-bigloo-safe-option) opts))      */
;* 			 ((and (>=fx (zpc-optim-level) 1)              */
;* 			       (=fx (bigloo-debug) 0)                  */
;* 			       (cond-expand                            */
;* 				  ((not devel) #t)                     */
;* 				  (else (>=fx (zpc-optim-level) 100)))) */
;* 			  (cons "-unsafe" opts))                       */
;* 			 (else                                         */
;* 			  opts))))                                     */
;* 		  ((>=fx l (caar opts))                                */
;* 		   (loop (cdr opts) (append (cdar opts) o)))           */
;* 		  (else                                                */
;* 		   (loop (cdr opts) o))))))                            */
;*                                                                     */
;*       (define (dest-opts dest opts)                                 */
;* 	 (cons* "-o" dest opts))                                       */
;*                                                                     */
;*       (let* ((opts (bigloo-options))                                */
;* 	     (file (when (and (pair? (zpc-sources))                    */
;* 			      (string? (car (zpc-sources))))           */
;* 		      (car (zpc-sources))))                            */
;* 	     (opts (cond                                               */
;* 		      ((string? (zpc-destination))                     */
;* 		       (when (file-exists? (zpc-destination))          */
;* 			  (delete-file (zpc-destination)))             */
;* 		       (case (zpc-pass)                                */
;* 			  ((object)                                    */
;* 			   (cons "-c" (dest-opts (zpc-destination) opts))) */
;* 			  ((so)                                        */
;* 			   (cons* "-dload-sym" "-y"                    */
;* 			      (dest-opts (zpc-destination) opts)))     */
;* 			  (else                                        */
;* 			   (cons* "-o" (zpc-destination) opts))))      */
;* 		      ((string? file)                                  */
;* 		       (case (zpc-pass)                                */
;* 			  ((object)                                    */
;* 			   (let* ((base (prefix file))                 */
;* 				  (dest (string-append base ".o")))    */
;* 			      (cons* "-c" (dest-opts dest opts))))     */
;* 			  ((so)                                        */
;* 			   (let* ((base (prefix file))                 */
;* 				  (dest (string-append base "."        */
;* 					   (bigloo-config 'shared-lib-suffix)))) */
;* 			      (cons* "-dload-sym" "-y" (dest-opts dest opts)))) */
;* 			  (else                                        */
;* 			   (dest-opts "a.out" opts))))                 */
;* 		      (else                                            */
;* 		       (cons "--to-stdout" opts))))                    */
;* 	     (exec (not (eq? (zpc-pass) 'object))))                    */
;* 	 (unwind-protect                                               */
;* 	    (compile-python in opts file exec (zpc-temp))              */
;* 	    (when (and (string? file) (eq? (zpc-pass) 'so))            */
;* 	       (let ((obj (string-append (prefix file) ".o")))         */
;* 		  (when (file-exists? obj)                             */
;* 		     (delete-file obj)))))))                           */
;*                                                                     */
   (define (compile::int filename::obj in::obj)
      (cond
	 ((eq? (zpc-pass) 'javascript)
	  (generate-javascript filename in))
	 ((eq? (zpc-pass) 'bigloo)
	  (generate-bigloo filename in))
	 (else
	  '(compile-bigloo filename in))))
   
   (cond
      ((and (zpc-source-ast) (pair? (zpc-sources)))
       (compile (car (zpc-sources))
	  (string->obj (string-as-read (zpc-source-ast)))))
      ((and (zpc-source-ast-file) (pair? (zpc-sources)))
       (compile (car (zpc-sources))
	  (call-with-input-file (zpc-source-ast-file)
	     (lambda (in)
		(string->obj (read-string in))))))
      (else
       (let ((srcs (zpc-sources)))
	  (cond
	     ((null? srcs)
	      0)
	     ((null? (cdr srcs))
	      (compile (car srcs) (car srcs)))
	     (else
	      (error "zpc" "too many sources" srcs)))))))
				 
;*---------------------------------------------------------------------*/
;*    sobase-path ...                                                  */
;*    -------------------------------------------------------------    */
;*    Compute the file name relative to the sobase directory.          */
;*---------------------------------------------------------------------*/
(define (sobase-path path)
   (if (zpc-sobase)
       (make-file-name (relative-file-name (zpc-sobase) (pwd)) path)
       path))
