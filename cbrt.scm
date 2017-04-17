(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cbrt x)
    (define (good-enough? y)
        (< (abs (- (cube y) x)) 0.001))
    (define (improve y)
        (/ (+ (/ x
                 (square y))
              (* 2 y))
           3))
    (define (cbrt-iter guess)
        (if (good-enough? guess)
            guess
            (cbrt-iter (improve guess))))
    (cbrt-iter 1.0))
