(define (for-each callback items)
    (if (null? items)
        true
        (and (callback (car items))
             (for-each callback (cdr items)))))

(for-each (lambda (x) (newline) (display x))
    (list 57 321 88))
