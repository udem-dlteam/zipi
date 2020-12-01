;*=====================================================================*/
;*    serrano/prgm/project/hop/hop/hopc/hopc_param.scm                 */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Fri Nov 12 13:20:19 2004                          */
;*    Last change :  Sun May 24 16:25:01 2020 (serrano)                */
;*    Copyright   :  2004-20 Manuel Serrano                            */
;*    -------------------------------------------------------------    */
;*    ZPC global parameters                                            */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    The module                                                       */
;*---------------------------------------------------------------------*/
(module zpc_param

   (include "param.sch")

   (import  zpc_configure)
   
   (export  (zpc-rc-directory::bstring)
	    (zpc-rc-directory-set! ::bstring)
	    
	    (zpc-rc-file::bstring)
	    (zpc-rc-file-set! ::bstring)

	    (zpc-bigloo::bstring)
	    (zpc-bigloo-set! ::bstring)
	    (zpc-bigloo-options::pair-nil)
	    (zpc-bigloo-options-set! ::pair-nil)
	    (zpc-bigloo-O-options::pair-nil)
	    (zpc-bigloo-safe-option::obj)
	    (zpc-bigloo-safe-option-set! ::obj)
	    (zpc-bigloo-profile-options::pair-nil)
	    (zpc-bigloo-profile-options-set! ::pair-nil)

	    (zpc-verbose::int)
	    (zpc-verbose-set! ::int)
	    
	    (zpc-pass::symbol)
	    (zpc-pass-set! ::symbol)

	    (zpc-py-target::symbol)
	    (zpc-py-target-set! ::symbol)

	    (zpc-sources::pair-nil)
	    (zpc-sources-set! ::pair-nil)
	    (zpc-destination::obj)
	    (zpc-destination-set! ::obj)
	    (zpc-temp::obj)
	    (zpc-temp-set! ::obj)

	    (zpc-pipe-filesize-threshold::elong)

	    (zpc-access-file::obj)
	    (zpc-access-file-set! ::obj)

	    (zpc-library-path::bstring)
	    (zpc-library-path-set! ::bstring)
	    
	    (zpc-libs-dir::obj)
	    (zpc-libs-dir-set! ::obj)

	    (zpc-bin-dir::obj)
	    (zpc-bin-dir-set! ::obj)

	    (zpc-sobase::obj)
	    (zpc-sobase-set! ::bstring)

	    (zpc-optim-level::int)
	    (zpc-optim-level-set! ::int)

	    (zpc-main::bool)
	    (zpc-main-set! ::bool)
	    
	    (zpc-py-module-name::obj)
	    (zpc-py-module-name-set! ::obj)
	    
	    (zpc-py-module-path::obj)
	    (zpc-py-module-path-set! ::obj)
	    
	    (zpc-py-module-main::obj)
	    (zpc-py-module-main-set! ::obj)

	    (zpc-source-ast::obj)
	    (zpc-source-ast-set! ::obj)
	    (zpc-source-ast-file::obj)
	    (zpc-source-ast-file-set! ::obj)
	    
	    (zpc-py-libraries::pair-nil)
	    (zpc-py-libraries-set! ::pair-nil)
	    
	    (zpc-py-driver::obj)
	    (zpc-py-driver-set! ::obj)

	    (zpc-py-return-as-exit::bool)
	    (zpc-py-return-as-exit-set! ::bool)

	    (zpc-pyc-flags::pair-nil)
	    (zpc-pyc-flags-set! ::pair-nil)

	    )

   (eval    (export-exports)))

;*---------------------------------------------------------------------*/
;*    zpc-rc-directory ...                                             */
;*---------------------------------------------------------------------*/
(define-parameter zpc-rc-directory
   (make-file-path (getenv "HOME") ".config" "zipi"))

;*---------------------------------------------------------------------*/
;*    zpc-rc-file ...                                                  */
;*---------------------------------------------------------------------*/
(define-parameter zpc-rc-file
   "zpcrc.scm")

;*---------------------------------------------------------------------*/
;*    zpc-bigloo ...                                                   */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bigloo
   "bigloo")

;*---------------------------------------------------------------------*/
;*    zpc-bigloo-options ...                                           */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bigloo-options
   '())

;*---------------------------------------------------------------------*/
;*    zpc-bigloo-O-options ...                                         */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bigloo-O-options
   '((2 . ("-freturn" "-fisa")) (6 . ("-freturn-goto"))))

;*---------------------------------------------------------------------*/
;*    zpc-bigloo-safe-option ...                                       */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bigloo-safe-option
   '())

;*---------------------------------------------------------------------*/
;*    zpc-bigloo-profile-options ...                                   */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bigloo-profile-options
   '())

;*---------------------------------------------------------------------*/
;*    zpc-verbose ...                                                  */
;*---------------------------------------------------------------------*/
(define-parameter zpc-verbose
   0)

;*---------------------------------------------------------------------*/
;*    zpc-pass ...                                                     */
;*---------------------------------------------------------------------*/
(define-parameter zpc-pass
   'link)

;*---------------------------------------------------------------------*/
;*    zpc-py-target ...                                                */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-target
   'es6)

;*---------------------------------------------------------------------*/
;*    zpc-sources ...                                                  */
;*---------------------------------------------------------------------*/
(define-parameter zpc-sources
   '())

;*---------------------------------------------------------------------*/
;*    zpc-destination ...                                              */
;*---------------------------------------------------------------------*/
(define-parameter zpc-destination
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-temp ...                                                     */
;*---------------------------------------------------------------------*/
(define-parameter zpc-temp
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-pipe-filesize-threshold ...                                  */
;*    -------------------------------------------------------------    */
;*    The file size threshold above which ast transmitted via          */
;*    temporary files (otherwise serialized on Bigloo stdin).          */
;*---------------------------------------------------------------------*/
(define-parameter zpc-pipe-filesize-threshold
   #e65536)

;*---------------------------------------------------------------------*/
;*    zpc-access-file ...                                              */
;*---------------------------------------------------------------------*/
(define-parameter zpc-access-file
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-long-size ...                                                */
;*---------------------------------------------------------------------*/
(define-parameter zpc-long-size
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-library-path ...                                             */
;*---------------------------------------------------------------------*/
(define-parameter zpc-library-path
   (make-file-path (zipi-lib-dir) "zipi" (zipi-release)))

;*---------------------------------------------------------------------*/
;*    zpc-libs-dir ...                                                 */
;*---------------------------------------------------------------------*/
(define-parameter zpc-libs-dir
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-bin-dir ...                                                  */
;*---------------------------------------------------------------------*/
(define-parameter zpc-bin-dir
   (zipi-bin-dir))

;*---------------------------------------------------------------------*/
;*    zpc-sobase ...                                                   */
;*---------------------------------------------------------------------*/
(define-parameter zpc-sobase
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-optim-level ...                                              */
;*---------------------------------------------------------------------*/
(define-parameter zpc-optim-level
   0)

;*---------------------------------------------------------------------*/
;*    zpc-main ...                                                     */
;*---------------------------------------------------------------------*/
(define-parameter zpc-main
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-py-module-name ...                                           */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-module-name
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-py-module-path ...                                           */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-module-path
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-py-module-main ...                                           */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-module-main
   #unspecified)

;*---------------------------------------------------------------------*/
;*    zpc-source-ast ...                                               */
;*---------------------------------------------------------------------*/
(define-parameter zpc-source-ast
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-source-ast-file ...                                          */
;*---------------------------------------------------------------------*/
(define-parameter zpc-source-ast-file
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-py-libraries ...                                             */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-libraries
   (cond-expand
      (enable-libuv
       '("-library" "hopscript"
	 "-library" "web"
	 "-library" "nodepy"
	 "-library" "libuv"))
      (else
       '("-library" "hopscript"
	 "-library" "web"
	 "-library" "nodepy"))))

;*---------------------------------------------------------------------*/
;*    zpc-py-driver ...                                                */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-driver
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-py-return-as-exit ...                                        */
;*---------------------------------------------------------------------*/
(define-parameter zpc-py-return-as-exit
   #f)

;*---------------------------------------------------------------------*/
;*    zpc-pyc-flags ...                                                */
;*---------------------------------------------------------------------*/
(define-parameter zpc-pyc-flags
   '())
