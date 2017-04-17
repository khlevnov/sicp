(define (sqrt-iter guess x previuos-guess)
    (if (good-enough? guess previuos-guess)
        guess
        (sqrt-iter (improve guess x) x guess)))

(define (improve guess x)
    (average guess (/ x guess)))

(define (average x y)
    (/ (+ x y) 2))

(define (good-enough? guess previuos-guess)
    (< (abs (- previuos-guess guess)) (* previuos-guess 0.001)))

(define (sqrt x)
  (sqrt-iter 1.0 x 2.0))

(sqrt 16)
