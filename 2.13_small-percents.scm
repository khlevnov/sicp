(define (make-interval a b)
    (cons a b))

(define (upper-bound interval)
    (max (car interval) (cdr interval)))

(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (make-center-width center width)
    (make-interval (- center width) (+ center width)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (make-center-percent center percent)
    (let ((width (* center (/ percent 100.0))))
        (make-center-width center width)))

(define (percent interval)
    (* (/ (width interval) (center interval)) 100.0))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define i1 (make-center-percent 10 4))
(define i2 (make-center-percent 20 4))
(percent (mul-interval i1 i2))

(define (mul-interval-percent i1 i2)
    (+ (percent i1) (percent i2)))
(mul-interval-percent i1 i2)
