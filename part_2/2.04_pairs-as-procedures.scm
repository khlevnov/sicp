(define (cons x y)
    (lambda (m) (m x y)))

(define (car z)
    (z (lambda (p q) p)))

(define (cdr z)
    (z (lambda (p q) q)))

;((lambda (p q) q) 1 2)
((lambda (m) (m 1 2)) (lambda (p q) q))
((lambda (p q) q) 1 2)
