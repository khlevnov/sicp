(define nil '())

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things) (cons (square (car things)) answer))))
    (iter items nil))

(define (square-list items)
    (define (iter things answer)
        (if (null? things)
            answer
            (iter (cdr things) (cons answer (square (car things))))))
    (iter items nil))

(square-list (list 1 2 3 4))
