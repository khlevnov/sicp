(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (average-damp f)
    (define (average a b) (/ (+ a b) 2))
    (lambda (x) (average x (f x))))

(define (repeated f reps)
    (define (compose f g)
        (lambda (x) (f (g x))))
    (define (iter composition i)
        (if (= i 1)
            composition
            (iter (compose composition f) (- i 1))))
    (iter f reps))

(define (pow initial n)
    (define (iter x n)
        (if (= n 1)
            x
            (iter (* x initial) (- n 1))))
    (iter initial n))

(define (point x n)
    (lambda (y) (/ x (pow y (- n 1)))))

(define (get-reps number)
    (define (iter acc n)
        (if (< number acc)
            (- n 2)
            (iter (pow 2 n) (+ n 1))))
    (iter 0 1))

(define (n-root n x)
    (display "Average-damp repeats ")
    (display (get-reps n))
    (fixed-point ((repeated average-damp (get-reps n)) (point x n))
        1.0))

; до 3 -- одно усреднение
; от 4 до 7 -- два усреднения
; от 8 до 15 -- три усреднения
; от 15 до 31 -- четыре усреднения
; от 32 до 63 -- пять усреднений
; от 64 ...
(n-root 64 65536)
