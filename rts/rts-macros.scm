;; Macros to enable/disable various implementation strategies.

;; Should the Python int type be represented using fixnums and bignums?
(define-macro (py-if-specialized-int-representation yes no) yes)

;; Should the Python float type be represented using flonums?
(define-macro (py-if-specialized-float-representation yes no) no)
