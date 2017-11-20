(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (max (car interval) (cdr interval)))
(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
                   (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
         (make-interval (min p1 p2 p3 p4)
                        (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y)))))

(define i1 (make-interval 0 200)) ; r1 = 200
(define i2 (make-interval 50 100)) ; r2 = 50
;(define i2 (make-interval 20 100)) ; r2' = 80, multiplication gives the same result
; For division
(define i1 (make-interval 10 20)) ; r1 = 10
(define i2 (make-interval 5 5)) ; r2 = 0
(define i1 (make-interval 20 40)) ; r1 = 20
(define i2 (make-interval 10 10)) ; r2' = 0, division gives the same result

(add-interval i1 i2) ; r1 + r2
(sub-interval i1 i2) ; r1 + r2
(mul-interval i1 i2)
(div-interval i1 i2)
