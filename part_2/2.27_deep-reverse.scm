(define nil '())

(define (deep-reverse items)
    (define (reverse-iter reveresed items)
        (if (null? items)
            reveresed
            (reverse-iter (cons (if (pair? (car items))
                                    (reverse-iter nil (car items))
                                    (car items)) reveresed)
                                (cdr items))))
    (reverse-iter nil items))

(define x (list (list 1 2 (list 4 1) 5) (list 3 4 (list 7 8 9) 10 11) (list 5 6)))
(deep-reverse x)
