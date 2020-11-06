;*=====================================================================*/
;*    serrano/prgm/project/zipi/rts/rts-call.sch                       */
;*    -------------------------------------------------------------    */
;*    Author      :  Manuel Serrano                                    */
;*    Creation    :  Thu Nov  5 10:30:55 2020                          */
;*    Last change :  Thu Nov  5 10:30:56 2020 (serrano)                */
;*    Copyright   :  2020 Manuel Serrano                               */
;*    -------------------------------------------------------------    */
;*    Macros for Python calls                                          */
;*=====================================================================*/

;*---------------------------------------------------------------------*/
;*    signatures                                                       */
;*---------------------------------------------------------------------*/
(define-macro (make-signature args posonlyargs vararg kwonlyargs kw-defaults kwarg defaults)
   
   (define (constantify val)
      (match-case val
	 (((kwote quote) ())
	  '())
	 (else
	  `(constantify ,val))))
   
   (define (constantify* lst)
      (match-case lst
	 (((kwote quote) ())
	  '())
	 (else
	  `#(,@(map constantify lst)))))
   
   (if (or kw-defaults defaults)
       `'#(vector
	   ,(constantify* args)
	   ,(constantify* posonlyargs)
	   ,(and vararg `',(constantify vararg))
	   ,(constantify* kwonlyargs)
	   ,(or kw-defaults '#())
	   ,(and kwarg `',(constantify kwarg))
	   ,(or defaults '#()))
       ;; signature with no default can be optimized to a constant
       `'#(,(constantify* args)
	   ,(constantify* posonlyargs)
	   ,(and vararg (constantify vararg))
	   ,(constantify* kwonlyargs)
	   #()
	   ,(and kwarg (constantify kwarg))
	   #())))

(define-macro (empty-signature)
  ''#(#() #() #f #() #() #f #()))

(define-macro (make-vararg-only-signature vararg)
  `(make-signature '() '() ,vararg '() #f #f #f))

(define-macro (make-posonly-signature posonlyargs)
  `(make-signature '() ,posonlyargs #f '() #f #f #f))

(define-macro (make-posonly-defaults-signature posonlyargs defaults)
  `(make-signature '() ,posonlyargs #f '() #f #f ,defaults))

(define-macro (make-args-defaults-signature args defaults)
  `(make-signature ,args '() #f '() #f #f ,defaults))

(define-macro (register-constants-perfect-hashtable table)
  (vector-map
    (lambda (e) (if (string? e) (get-PyStaticStr e) e))
    table))

;*---------------------------------------------------------------------*/
;*    calls                                                            */
;*---------------------------------------------------------------------*/
(define-macro (py-call f . args)
   `'(py-call ,f ,@args))
