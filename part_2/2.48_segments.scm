#lang scheme
(#%require sicp-pict)

(define (make-segment origin vect) (cons origin vect))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))
