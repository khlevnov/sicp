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

(add-interval (make-interval 1.6 1.8)
              (make-interval 1.2 1.4))
              
(sub-interval (make-interval 1.6 1.8)
              (make-interval 1.2 1.4))
