(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (max (car interval) (cdr interval)))
(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (div-interval x y)
    (define (zero-intersection? interval)
        (and (> (upper-bound interval) 0)
                 (< (lower-bound interval) 0)))
    (if (or (zero-intersection? x)
            (zero-intersection? y))
        (error "Interval is intersecting zero"))
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))

(div-interval (make-interval 10 20)
              (make-interval 5 5))
