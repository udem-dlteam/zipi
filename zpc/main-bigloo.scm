;*=====================================================================*/
;*    serrano/prgm/project/zipi/zpc/main-bigloo.scm                    */
;*    -------------------------------------------------------------    */
;*    Author      :  Marc Feeley & Manuel Serrano                      */
;*    Creation    :  Tue Jun  4 12:48:54 2019                          */
;*    Last change :  Mon May 25 11:35:58 2020 (serrano)                */
;*    Copyright   :  2019-20 M. Feeley & M. Serrano                    */
;*    -------------------------------------------------------------    */
;*    python ast interpreter (bigloo prelude)                          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module pyc

   (include "ast/ast.sch")

   (import __pyc_dump
	   __pyc_sexp
	   __pyc_symbol
	   __pyc_locals
	   __pyc_return
	   __pyc_break
	   __pyc_generator
	   __pyc_cps
	   __pyc_beval
	   __pyc_scheme
	   __pyc_javascript
	   __py_hclass
	   __py_object)

   (main main))

;*---------------------------------------------------------------------*/
;*    main ...                                                         */
;*---------------------------------------------------------------------*/
(define (main args)
   (let ((verb 0)
	 (tgt 'scheme)
	 (generate-main #t)
	 (bin-dir (zipi-bin-dir))
	 (dir #f)
	 (src #f)
	 (conf '()))
      (args-parse (cdr args)
	 ((("-h" "--help") (help "This message"))
	  (usage args-parse-usage)
	  (exit 0))
	 ((("-t" "--target") ?target (help "Set target language"))
	  (set! tgt (string->symbol target)))
	 ((("-n" "--no-main") (help "Donot generate main entry point"))
	  (set! generate-main #f))
	 ((("-d" "--dir") ?d (help "Root import directory"))
	  (set! dir d))
	 ((("-b" "--bin-dir") ?d (help "Bin directory"))
	  (set! bin-dir d))
	 (("-v?level" (help "Increase/set verbosity level (-v0 crystal silence)"))
	  (if (string=? level "")
	      (set! verb (+fx 1 verb))
	      (set! verb (string->integer level))))
	 (else
	  (unless (string=? else "--")
	     (set! src else))))
      (pyc (cons*
	      verbose: verb
	      target: tgt
	      dir: (or dir (if src (absolute (dirname src)) (pwd)))
	      src: src
	      bin-dir: bin-dir
	      conf))))

;*---------------------------------------------------------------------*/
;*    usage ...                                                        */
;*---------------------------------------------------------------------*/
(define (usage args-parse-usage)
   (print "zpc")
   (print "usage: zpc [options] -- [bigloo-options]")
   (args-parse-usage #f)
   (newline)
   (print "Shell Variables:")
   (print "   - PYTRACE: zpc internal trace [PYTRACE=\"key1, key2, ...\"]")
   (print "      zpc:dump")
   (newline))
