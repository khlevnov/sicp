(define (make-accumulator acc)
  (lambda (x)
    (begin
      (set! acc (+ acc x))
      acc)))

(define A (make-accumulator 5))
(A 10)
(A 10)
