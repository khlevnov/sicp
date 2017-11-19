(define zero (lambda (f) (lambda (x) x)))

(define (inc n)
    (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (inc zero))
((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))

(define two (inc one))
((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) (f x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))

(define three (inc two))
((lambda (f) (lambda (x) (f ((n f) x)))) (lambda (f) (lambda (x) (f (f x)))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f (f x)))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f (f x))) x))))
(lambda (f) (lambda (x) (f (f (f x)))))

(define four (lambda (f) (lambda (x) (f (f (f (f x)))))))
(define five (lambda (f) (lambda (x) (f (f (f (f (f x))))))))

(define (sum n1 n2)
    (lambda (f) (lambda (x) ((n1 f) ((n2 f) x)))))

(define (mul n1 n2)
    (lambda (x) (n1 (n2 x))))

(define (expt n exp)
    (exp n))

(define (church-to-number church-number)
    (define (inc x) (+ x 1))
    ((church-number inc) 0))

(church-to-number (sum two five))
