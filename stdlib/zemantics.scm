(define (py-add x2 y3)
  (letrec* ((magic_method87 py-absent)
            (result88 py-absent)
            (magic_method89 py-absent)
            (result90 py-absent)
            (reflected92 py-absent)
            (err93 py-absent))
    (letrec* ((normal91
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method87
                            (getattribute-from-obj-mro x2 (& "__add__")))
                      (if (eq? magic_method87 py-absent)
                          (py-call0 reflected92)
                          (begin
                            (set! result88 (py-call2 magic_method87 x2 y3))
                            (if (eq? result88 py-NotImplemented)
                                (py-call0 reflected92)
                                result88))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected92
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method87
                           (getattribute-from-obj-mro y3 (& "__radd__")))
                     (if (eq? magic_method87 py-absent)
                         (py-call0 err93)
                         (begin
                           (set! result88 (py-call2 magic_method87 y3 x2))
                           (if (eq? result88 py-NotImplemented)
                               (py-call0 err93)
                               result88))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err93
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal91)))))
(define (py-sub x8 y9)
  (letrec* ((magic_method98 py-absent)
            (result99 py-absent)
            (magic_method100 py-absent)
            (result101 py-absent)
            (reflected103 py-absent)
            (err104 py-absent))
    (letrec* ((normal102
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method98
                            (getattribute-from-obj-mro x8 (& "__sub__")))
                      (if (eq? magic_method98 py-absent)
                          (py-call0 reflected103)
                          (begin
                            (set! result99 (py-call2 magic_method98 x8 y9))
                            (if (eq? result99 py-NotImplemented)
                                (py-call0 reflected103)
                                result99))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected103
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method98
                           (getattribute-from-obj-mro y9 (& "__rsub__")))
                     (if (eq? magic_method98 py-absent)
                         (py-call0 err104)
                         (begin
                           (set! result99 (py-call2 magic_method98 y9 x8))
                           (if (eq? result99 py-NotImplemented)
                               (py-call0 err104)
                               result99))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err104
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal102)))))
(define (py-mul x14 y15)
  (letrec* ((magic_method109 py-absent)
            (result110 py-absent)
            (magic_method111 py-absent)
            (result112 py-absent)
            (reflected114 py-absent)
            (err115 py-absent))
    (letrec* ((normal113
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method109
                            (getattribute-from-obj-mro x14 (& "__mul__")))
                      (if (eq? magic_method109 py-absent)
                          (py-call0 reflected114)
                          (begin
                            (set! result110 (py-call2 magic_method109 x14 y15))
                            (if (eq? result110 py-NotImplemented)
                                (py-call0 reflected114)
                                result110))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected114
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method109
                           (getattribute-from-obj-mro y15 (& "__rmul__")))
                     (if (eq? magic_method109 py-absent)
                         (py-call0 err115)
                         (begin
                           (set! result110 (py-call2 magic_method109 y15 x14))
                           (if (eq? result110 py-NotImplemented)
                               (py-call0 err115)
                               result110))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err115
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal113)))))
(define (py-truediv x20 y21)
  (letrec* ((magic_method120 py-absent)
            (result121 py-absent)
            (magic_method122 py-absent)
            (result123 py-absent)
            (reflected125 py-absent)
            (err126 py-absent))
    (letrec* ((normal124
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method120
                            (getattribute-from-obj-mro x20 (& "__truediv__")))
                      (if (eq? magic_method120 py-absent)
                          (py-call0 reflected125)
                          (begin
                            (set! result121 (py-call2 magic_method120 x20 y21))
                            (if (eq? result121 py-NotImplemented)
                                (py-call0 reflected125)
                                result121))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected125
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method120
                           (getattribute-from-obj-mro y21 (& "__rtruediv__")))
                     (if (eq? magic_method120 py-absent)
                         (py-call0 err126)
                         (begin
                           (set! result121 (py-call2 magic_method120 y21 x20))
                           (if (eq? result121 py-NotImplemented)
                               (py-call0 err126)
                               result121))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err126
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal124)))))
(define (py-floordiv x26 y27)
  (letrec* ((magic_method131 py-absent)
            (result132 py-absent)
            (magic_method133 py-absent)
            (result134 py-absent)
            (reflected136 py-absent)
            (err137 py-absent))
    (letrec* ((normal135
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method131
                            (getattribute-from-obj-mro x26 (& "__floordiv__")))
                      (if (eq? magic_method131 py-absent)
                          (py-call0 reflected136)
                          (begin
                            (set! result132 (py-call2 magic_method131 x26 y27))
                            (if (eq? result132 py-NotImplemented)
                                (py-call0 reflected136)
                                result132))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected136
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method131
                           (getattribute-from-obj-mro y27 (& "__rfloordiv__")))
                     (if (eq? magic_method131 py-absent)
                         (py-call0 err137)
                         (begin
                           (set! result132 (py-call2 magic_method131 y27 x26))
                           (if (eq? result132 py-NotImplemented)
                               (py-call0 err137)
                               result132))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err137
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal135)))))
(define (py-mod x32 y33)
  (letrec* ((magic_method142 py-absent)
            (result143 py-absent)
            (magic_method144 py-absent)
            (result145 py-absent)
            (reflected147 py-absent)
            (err148 py-absent))
    (letrec* ((normal146
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method142
                            (getattribute-from-obj-mro x32 (& "__mod__")))
                      (if (eq? magic_method142 py-absent)
                          (py-call0 reflected147)
                          (begin
                            (set! result143 (py-call2 magic_method142 x32 y33))
                            (if (eq? result143 py-NotImplemented)
                                (py-call0 reflected147)
                                result143))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected147
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method142
                           (getattribute-from-obj-mro y33 (& "__rmod__")))
                     (if (eq? magic_method142 py-absent)
                         (py-call0 err148)
                         (begin
                           (set! result143 (py-call2 magic_method142 y33 x32))
                           (if (eq? result143 py-NotImplemented)
                               (py-call0 err148)
                               result143))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err148
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal146)))))
(define (py-pow x38 y39)
  (letrec* ((magic_method153 py-absent)
            (result154 py-absent)
            (magic_method155 py-absent)
            (result156 py-absent)
            (reflected158 py-absent)
            (err159 py-absent))
    (letrec* ((normal157
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method153
                            (getattribute-from-obj-mro x38 (& "__pow__")))
                      (if (eq? magic_method153 py-absent)
                          (py-call0 reflected158)
                          (begin
                            (set! result154 (py-call2 magic_method153 x38 y39))
                            (if (eq? result154 py-NotImplemented)
                                (py-call0 reflected158)
                                result154))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected158
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method153
                           (getattribute-from-obj-mro y39 (& "__rpow__")))
                     (if (eq? magic_method153 py-absent)
                         (py-call0 err159)
                         (begin
                           (set! result154 (py-call2 magic_method153 y39 x38))
                           (if (eq? result154 py-NotImplemented)
                               (py-call0 err159)
                               result154))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err159
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal157)))))
(define (py-lshift x44 y45)
  (letrec* ((magic_method164 py-absent)
            (result165 py-absent)
            (magic_method166 py-absent)
            (result167 py-absent)
            (reflected169 py-absent)
            (err170 py-absent))
    (letrec* ((normal168
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method164
                            (getattribute-from-obj-mro x44 (& "__lshift__")))
                      (if (eq? magic_method164 py-absent)
                          (py-call0 reflected169)
                          (begin
                            (set! result165 (py-call2 magic_method164 x44 y45))
                            (if (eq? result165 py-NotImplemented)
                                (py-call0 reflected169)
                                result165))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected169
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method164
                           (getattribute-from-obj-mro y45 (& "__rlshift__")))
                     (if (eq? magic_method164 py-absent)
                         (py-call0 err170)
                         (begin
                           (set! result165 (py-call2 magic_method164 y45 x44))
                           (if (eq? result165 py-NotImplemented)
                               (py-call0 err170)
                               result165))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err170
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal168)))))
(define (py-rshift x50 y51)
  (letrec* ((magic_method175 py-absent)
            (result176 py-absent)
            (magic_method177 py-absent)
            (result178 py-absent)
            (reflected180 py-absent)
            (err181 py-absent))
    (letrec* ((normal179
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method175
                            (getattribute-from-obj-mro x50 (& "__rshift__")))
                      (if (eq? magic_method175 py-absent)
                          (py-call0 reflected180)
                          (begin
                            (set! result176 (py-call2 magic_method175 x50 y51))
                            (if (eq? result176 py-NotImplemented)
                                (py-call0 reflected180)
                                result176))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected180
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method175
                           (getattribute-from-obj-mro y51 (& "__rrshift__")))
                     (if (eq? magic_method175 py-absent)
                         (py-call0 err181)
                         (begin
                           (set! result176 (py-call2 magic_method175 y51 x50))
                           (if (eq? result176 py-NotImplemented)
                               (py-call0 err181)
                               result176))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err181
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal179)))))
(define (py-bitand x56 y57)
  (letrec* ((magic_method186 py-absent)
            (result187 py-absent)
            (magic_method188 py-absent)
            (result189 py-absent)
            (reflected191 py-absent)
            (err192 py-absent))
    (letrec* ((normal190
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method186
                            (getattribute-from-obj-mro x56 (& "__and__")))
                      (if (eq? magic_method186 py-absent)
                          (py-call0 reflected191)
                          (begin
                            (set! result187 (py-call2 magic_method186 x56 y57))
                            (if (eq? result187 py-NotImplemented)
                                (py-call0 reflected191)
                                result187))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected191
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method186
                           (getattribute-from-obj-mro y57 (& "__rand__")))
                     (if (eq? magic_method186 py-absent)
                         (py-call0 err192)
                         (begin
                           (set! result187 (py-call2 magic_method186 y57 x56))
                           (if (eq? result187 py-NotImplemented)
                               (py-call0 err192)
                               result187))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err192
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal190)))))
(define (py-bitor x62 y63)
  (letrec* ((magic_method197 py-absent)
            (result198 py-absent)
            (magic_method199 py-absent)
            (result200 py-absent)
            (reflected202 py-absent)
            (err203 py-absent))
    (letrec* ((normal201
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method197
                            (getattribute-from-obj-mro x62 (& "__or__")))
                      (if (eq? magic_method197 py-absent)
                          (py-call0 reflected202)
                          (begin
                            (set! result198 (py-call2 magic_method197 x62 y63))
                            (if (eq? result198 py-NotImplemented)
                                (py-call0 reflected202)
                                result198))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected202
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method197
                           (getattribute-from-obj-mro y63 (& "__ror__")))
                     (if (eq? magic_method197 py-absent)
                         (py-call0 err203)
                         (begin
                           (set! result198 (py-call2 magic_method197 y63 x62))
                           (if (eq? result198 py-NotImplemented)
                               (py-call0 err203)
                               result198))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err203
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal201)))))
(define (py-xor x68 y69)
  (letrec* ((magic_method208 py-absent)
            (result209 py-absent)
            (magic_method210 py-absent)
            (result211 py-absent)
            (reflected213 py-absent)
            (err214 py-absent))
    (letrec* ((normal212
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method208
                            (getattribute-from-obj-mro x68 (& "__xor__")))
                      (if (eq? magic_method208 py-absent)
                          (py-call0 reflected213)
                          (begin
                            (set! result209 (py-call2 magic_method208 x68 y69))
                            (if (eq? result209 py-NotImplemented)
                                (py-call0 reflected213)
                                result209))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected213
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method208
                           (getattribute-from-obj-mro y69 (& "__rxor__")))
                     (if (eq? magic_method208 py-absent)
                         (py-call0 err214)
                         (begin
                           (set! result209 (py-call2 magic_method208 y69 x68))
                           (if (eq? result209 py-NotImplemented)
                               (py-call0 err214)
                               result209))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err214
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal212)))))
(define (py-matmul x74 y75)
  (letrec* ((magic_method219 py-absent)
            (result220 py-absent)
            (magic_method221 py-absent)
            (result222 py-absent)
            (reflected224 py-absent)
            (err225 py-absent))
    (letrec* ((normal223
               (procedure->py-function
                (lambda ()
                  (let ((%frame (make-cell #f)) (%names '()))
                    (begin
                      (set! magic_method219
                            (getattribute-from-obj-mro x74 (& "__matmul__")))
                      (if (eq? magic_method219 py-absent)
                          (py-call0 reflected224)
                          (begin
                            (set! result220 (py-call2 magic_method219 x74 y75))
                            (if (eq? result220 py-NotImplemented)
                                (py-call0 reflected224)
                                result220))))))
                (vector '#() '#() #f '#() (vector) #f (vector)))))
      (begin
        (set! reflected224
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (begin
                     (set! magic_method219
                           (getattribute-from-obj-mro y75 (& "__rmatmul__")))
                     (if (eq? magic_method219 py-absent)
                         (py-call0 err225)
                         (begin
                           (set! result220 (py-call2 magic_method219 y75 x74))
                           (if (eq? result220 py-NotImplemented)
                               (py-call0 err225)
                               result220))))))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (set! err225
              (procedure->py-function
               (lambda ()
                 (let ((%frame (make-cell #f)) (%names '()))
                   (py-throw py-builtin-ValueError)))
               (vector '#() '#() #f '#() (vector) #f (vector))))
        (py-call0 normal223)))))
(define (py-getattribute obj80 attr81)
  (letrec* ((__getattribute__228
             (getattribute-from-obj-mro obj80 (& "__getattribute__"))))
    (with-handler
     (lambda ($%current-exc_0)
       (cond ((py-isinstance? $%current-exc_0 py-builtin-AttributeError)
              (letrec* ((__getattr__229
                         (getattribute-from-obj-mro obj80 (& "__getattr__"))))
                (if (eq? __getattr__229 py-absent)
                    (py-throw $%current-exc_0)
                    (py-call2 __getattr__229 obj80 attr81))))
             (else (raise $%current-exc_0))))
     (py-call2 __getattribute__228 obj80 attr81))))
