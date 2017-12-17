(define nil '())

(define (subsets s)
    (if (null? s)
        (list nil)
        (let ((rest (subsets (cdr s))))
            (append rest (map (lambda (x) (cons (car s) x)) rest)))))

(subsets '(3))
; rest (3)
; (() (3))

(subsets '(2 3))
; rest (3)
; rest (2 3)
; (() (3) (2) (2 3))

(subsets '(1 2 3 4))
