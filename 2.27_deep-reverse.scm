(define nil '())

(define (deep-reverse items)
    (define (reverse items)
        (define (reverse-iter reveresed items)
            (if (null? items)
                reveresed
                (reverse-iter (cons (car items) reveresed)
                                    (cdr items))))
        (reverse-iter nil items))
    (reverse items))

(define x (list (list 1 2) (list 3 4) (list 5 6)))
(deep-reverse x)
