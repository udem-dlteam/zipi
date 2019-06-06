(cond-expand
  (gambit
   (declare (standard-bindings) (extended-bindings) (not safe) (block))
   (namespace ("##" import))
   (import hclass)
   (implement-PCache)
   (implement-HClass)))

(define (hclass-transition-add! hc tran target)
  (HClass-transitions-set!
   hc
   (cons (cons tran target) (HClass-transitions hc))))

(define (vector-extend vec el)
   (let* ((len (vector-length vec))
	  (nvec (make-vector (+ len 1))))
      (vector-copy! nvec 0 vec)
      (vector-set! nvec len el)
      nvec))

(define (hclass-next hc name op)
   (let* ((key (cons name op))
	  (tran (assoc key (hclass-transitions hc))))
      (if (pair? tran)
	  (cdr tran)
	  (let ((nhclass (make-hclass (vector-extend (hclass-names hc) name))))
	     (hclass-transition-add! hc key nhclass)
	     nhclass))))
