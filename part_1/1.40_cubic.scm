(define dx 0.00001)

(define (deriv g)
    (lambda (x)
        (/ (- (g (+ x dx)) (g x))
           dx)))

(define (newton-transform g)
    (lambda (x)
        (- x (/ (g x) ((deriv g) x)))))

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

(define (newtons-method g guess)
    (fixed-point (newton-transform g) guess))

(define (sqrt x)
    (newtons-method (lambda (y) (- (square y) x)) 1.0))

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cubic a b c)
    (lambda (x)
        (+ (cube x)
           (* a (square x))
           (* b x)
           c)))

((cubic 1 1 1) 2)
; 8 + 1*4 + 1*2 + 1 = 15
((cubic 1 1 3) 2)
; 8 + 1*4 + 1*2 + 3 = 17
((cubic 5 1 3) 2)
; 8 + 5*4 + 1*2 + 3 = 33
((cubic 5 7 3) 2)
; 8 + 5*4 + 7*2 + 3 = 45
