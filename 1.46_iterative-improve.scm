(define tolerance 0.00001);

(define (iterative-improve good? improve)
    (lambda (guess)
        (define (try previuos-guess)
            (let ((guess (improve previuos-guess)))
                (if (good? guess previuos-guess)
                    guess
                    (try guess))))
        (try guess)))

(define (fixed-point f first-guess)
    (define (fixed-point-good? guess previuos-guess)
        (< (abs (- previuos-guess guess)) tolerance))
    ((iterative-improve fixed-point-good? f) first-guess))

(define (sqrt number)
    (define (sqrt-good? guess previuos-guess)
        (< (abs (- previuos-guess guess)) (* previuos-guess tolerance)))
    (define (improve guess)
        (define (average x y)
            (/ (+ x y) 2))
        (average guess (/ number guess)))
    ((iterative-improve sqrt-good? improve) 1.0))

(sqrt 16)
(fixed-point cos 1.0)
