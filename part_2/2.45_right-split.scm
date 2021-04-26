#lang sicp
(#%require sicp-pict)

(define (split transform1 transform2)
    (define (splitter painter n)
        (if (= n 0)
            painter
            (transform1 painter
                (transform2 ((split transform1 transform2) painter (- n 1))
                            ((split transform1 transform2) painter (- n 1))))))
    splitter)

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 3))
(paint (up-split einstein 3))
