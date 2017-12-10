(define nil '())

(define (fringe items)
    (define (fringe-iter fringed items)
        (if (null? items)
            fringed
            (fringe-iter (cons (car items) fringed) (cdr items))))
    (fringe-iter nil items))

(define x (list (list 1 2) (list 3 4)))
(fringe x)
