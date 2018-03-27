(define (adjoin-set x set)
    (let ((head (car set)))
         (cond ((= x head) set)
               ((< x head) (cons x set))
               (else (cons head
                           (adjoin-set x (cdr set)))))))

(adjoin-set 7 '(1 2 3 4 5 6 8 9))
(adjoin-set 6 '(1 2 3 4 5 6 8 9))
