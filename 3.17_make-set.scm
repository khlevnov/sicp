(define (make-set)
    (define items '())
    (define (add x)
        (if (not (has items x))
            (set! items (cons x items))))
    (define (has items x)
        (cond
            ((null? items) #f)
            ((eq? (car items) x) #t)
            (else
                (has (cdr items) x))))
    (define (dispatch message)
        (cond
            ((eq? message 'debug) items)
            ((eq? message 'add) add)
            ((eq? message 'has)
                (lambda (x) (has items x)))))
    dispatch)

(define foo-set (make-set))
((foo-set 'add) 1)
(foo-set 'debug)
((foo-set 'add) 2)
(foo-set 'debug)
((foo-set 'add) 1)
((foo-set 'add) 1)
((foo-set 'add) 1)
(foo-set 'debug)
((foo-set 'has) 3)
(foo-set 'debug)
((foo-set 'has) 1)
((foo-set 'has) 2)