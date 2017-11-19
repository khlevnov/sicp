(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))

    (define (try guess)
        (display guess)
        (newline)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))

    (try first-guess))

(define (log-without-avegare x) (/ (log 1000) (log x)))
(define (log-with-avegare x) (* (/ 1 2)
                                (+ x (/ (log 1000) (log x)))))

; 50 итераций
(fixed-point log-without-avegare 4.0)
; 6 итераций
(fixed-point log-with-avegare 4.0)
