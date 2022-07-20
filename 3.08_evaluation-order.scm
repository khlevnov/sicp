(define value '())

(define (f x)
  (begin
    (if (null? value)
      (set! value x))
    (if (= value 0)
      0
      x)))

(+ (f 0) (f 1))

(set! value '())

(+ (f 1) (f 0))
