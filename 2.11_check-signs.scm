(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (max (car interval) (cdr interval)))
(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (positive? x) (>= x 0))
(define (negative? x) (< x 0))

(define (mul-interval x y)
    (cond ((and (negative? (upper-bound x))
                (positive? (lower-bound y)))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (upper-bound x) (lower-bound y))))

          ((and (negative? (upper-bound x))
                (negative? (upper-bound y)))
           (make-interval (* (upper-bound x) (upper-bound y))
                          (* (lower-bound x) (lower-bound y))))

          ((and (negative? (upper-bound x))
                (positive? (upper-bound y)))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (lower-bound x) (lower-bound y))))

          ((and (positive? (lower-bound x))
                (positive? (lower-bound y)))
           (make-interval (* (lower-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y))))

          ((and (positive? (lower-bound x))
                (negative? (upper-bound y)))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (lower-bound x) (upper-bound y))))

          ((and (positive? (lower-bound x))
                (positive? (upper-bound y)))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (upper-bound x) (upper-bound y))))

          ((and (positive? (upper-bound x))
                (positive? (lower-bound y)))
           (make-interval (* (lower-bound x) (upper-bound y))
                          (* (upper-bound x) (upper-bound y))))

          ((and (positive? (upper-bound x))
                (negative? (upper-bound y)))
           (make-interval (* (upper-bound x) (lower-bound y))
                          (* (lower-bound x) (lower-bound y))))

          (else (let ((p1 (* (lower-bound x) (lower-bound y)))
                      (p2 (* (lower-bound x) (upper-bound y)))
                      (p3 (* (upper-bound x) (lower-bound y)))
                      (p4 (* (upper-bound x) (upper-bound y))))
                     (make-interval (min p1 p2 p3 p4)
                                    (max p1 p2 p3 p4))))))

(define i1 (make-interval -10 20))
(define i2 (make-interval -10 -2))

(mul-interval i1 i2)
