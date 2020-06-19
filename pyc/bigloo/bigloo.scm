(define (bigloo#bit-and x y) (bitwise-and x y))
(define (bigloo#bit-or  x y) (bitwise-ior x y))
(define (bigloo#bit-xor x y) (bitwise-xor x y))
(define (bigloo#bit-not x)   (bitwise-not x))
(define (bigloo#bit-lsh x y) (arithmetic-shift x y))
(define (bigloo#bit-rsh x y) (arithmetic-shift x (- y)))

(define bigloo#print println)

(define (bigloo#tprint . args)
  (for-each display args)
  (newline))

(define (bigloo#string->integer str) (string->number str))

(define (bigloo#string-index string char #!optional (start 0) (count (- (string-length string) start)))
  ;; Index of first occurrence of char in string
  (let ((end (+ start count)))
    (let loop ((i start))
      (if (fx< i end)
          (if (char=? (string-ref string i) char)
              i
              (loop (fx+ i 1)))
          #f))))

(define (bigloo#string-split string #!optional (delimiters " \n\t"))
  ;; Index of first occurrence of char in string
  (let loop ((start 0) (i 0) (rev-parts '()))
    (if (fx< i (string-length string))
        (let ((c (string-ref string i)))
          (if (bigloo#string-index delimiters c)
              (loop (fx+ i 1)
                    (fx+ i 1)
                    (cons (substring string start i) rev-parts))
              (loop start
                    (fx+ i 1)
                    rev-parts)))
        (reverse (cons (substring string start i) rev-parts)))))

(define (bigloo#substring string start #!optional (end (string-length string)))
  (namespace ("" substring))
  (substring string start end))

(define (bigloo#copy-vector v len)
  (let ((x (make-vector len)))
    (subvector-move! v 0 (vector-length v) x 0)
    x))

(define (bigloo#isa? obj class)
  (and (##structure? obj)
       (let ((t0 (##structure-type obj))
             (type-id (##type-id class)))
         (or (##eq? (##type-id t0) type-id)
             (let ((t1 (##type-super t0)))
               (and t1
                    (or (##eq? (##type-id t1) type-id)
                        (##structure-instance-of? obj type-id))))))))

(define (bigloo#correct-arity? f nargs)
  #t)

(define (bigloo#make-cell val)
  (box val))

(define (bigloo#cell-ref cell)
  (unbox cell))

(define (bigloo#cell-set! cell val)
  (set-box! cell val))

(define (bigloo#make-file-path file path)
  (path-expand path file))

(define (bigloo#filter pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          (cons (car lst) (bigloo#filter pred (cdr lst)))
          (bigloo#filter pred (cdr lst)))
      '()))

(define (bigloo#filter-map f lst)
  (if (pair? lst)
      (let ((x (f (car lst))))
        (if x
            (cons x (bigloo#filter-map f (cdr lst)))
            (bigloo#filter-map f (cdr lst))))
      '()))

(define (bigloo#any pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          #t
          (bigloo#any pred (cdr lst)))
      #f))

(define (bigloo#find pred lst)
  (if (pair? lst)
      (if (pred (car lst))
          (car lst)
          (bigloo#find pred (cdr lst)))
      #f))

(define (bigloo#remq! obj lst)

  (define (rem lst prev)
    (if (pair? lst)
        (if (eq? (car lst) obj)
            (begin
              (if prev
                  (set-cdr! prev (cdr lst)))
              (rem (cdr lst) prev))
            (begin
              (rem (cdr lst) lst)
              lst))
        prev))

  (or (rem lst #f) '()))

(define (bigloo#delete-duplicates lst #!optional (eq equal?))

  (define (del lst seen)
    (if (pair? lst)
        (let ((x (car lst)))
          (if (member x seen eq)
              (del (cdr lst) seen)
              (cons (car lst) (del (cdr lst) (cons x seen)))))
        '()))

  (del lst '()))

(define (bigloo#current-microseconds)
  (* 1000000 (time->seconds (current-time))))

(define (bigloo#fprint format-string . objects)
  (print (apply format (cons format-string objects))))

(define (bigloo#make-directories dir)
  (create-directory dir))

(define (bigloo#map! f lst)
  (let loop ((lst lst))
    (if (pair? lst)
        (begin
          (set-car! lst (f (car lst)))
          (loop (cdr lst)))))
  lst)

(define (bigloo#typeof obj)
  (symbol->string (##type-name (##structure-type obj))))

(define (bigloo#econs a b c)
  (cons a b))

(define (bigloo#format format-string . objects)
  (let ((buffer (open-output-string)))
    (let loop ((format-list (string->list format-string))
               (objects objects))
      (cond ((null? format-list)
             (get-output-string buffer))
            ((char=? (car format-list) #\~)
             (if (null? (cdr format-list))
                 (error "Incomplete escape sequence")
                 (case (cadr format-list)
                   ((#\a)
                    (if (null? objects)
                        (error "No value for escape sequence")
                        (begin
                          (display (car objects) buffer)
                          (loop (cddr format-list) (cdr objects)))))
	           ((#\s)
                    (if (null? objects)
                        (error "No value for escape sequence")
                        (begin
                          (write (car objects) buffer)
                          (loop (cddr format-list) (cdr objects)))))
                   ((#\%)
                    (newline buffer)
                    (loop (cddr format-list) objects))
                   ((#\~)
                    (write-char #\~ buffer)
                    (loop (cddr format-list) objects))
                   (else
                    (error "Unrecognized escape sequence")))))
            (else
             (write-char (car format-list) buffer)
             (loop (cdr format-list) objects))))))

(define (bigloo#getenv name)
  (##getenv name #f))

(define (bigloo#make-file-name dir file)
  (path-expand file dir))

(define (bigloo#make-file-path x . y)
  (let loop ((path x) (lst y))
    (if (null? lst)
        path
        (loop (bigloo#make-file-name path (car lst)) (cdr lst)))))

(define (bigloo#directory? path)
  (and (file-exists? path)
       (eq? (file-type path) 'directory)))

(define (bigloo#absolute path)
  (path-normalize  path))

(define (bigloo#dirname path)
  (path-directory path))

(define (bigloo#basename path)
  (path-strip-directory path))

(define (bigloo#prefix path)
  (path-strip-extension path))

(define (bigloo#pwd)
  (current-directory))

(define (bigloo#os-tmp)
  "/tmp")

(define (bigloo#append-map f . lists)
  (apply append (apply map (cons f lists))))

(define (bigloo#write-circle obj)
  (write-shared obj))
