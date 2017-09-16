(define dx 0.0001)

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f reps)
    (define (iter composition i)
        (if (= i 1)
            composition
            (iter (compose composition f) (- i 1))))
    (iter f reps))

(define (smooth f)
    (lambda (x) (/ (+ (f (- x dx))
                      (f x)
                      (f (+ x dx)))
                   3)))

(define (square x) (* x x))

(define (n-fold-smooth f n)
    ((repeated smooth n) f)

((n-fold-smooth square 5) 3)
