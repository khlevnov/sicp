(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (max (car interval) (cdr interval)))
(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define interval (make-interval 0.6 0.1))
(upper-bound interval)
(lower-bound interval)
