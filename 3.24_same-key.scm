(define (new-table same-key?)
    (let ((table '(*table*)))
        (define (assoc key records)
            (cond
                ((null? records) #f)
                ((same-key? key (caar records)) (car records))
                (else (assoc key (cdr records)))))
        (define (lookup key)
            (let ((record (assoc key (cdr table))))
                (if record
                    (cdr record)
                    #f)))
        (define (insert! key value)
            (let ((record (assoc key (cdr table))))
                (if record
                    (set-cdr! record value)
                    (set-cdr! table (cons (cons key value) (cdr table))))))
        (define (dispatch m)
            (cond
                ((eq? m 'insert!) insert!)
                ((eq? m 'lookup) lookup)
                ((eq? m 'debug) table)
                (else
                    (error "Failed to dispatch undefined message" m))))
        dispatch))

(define t (new-table (lambda (x y) (< (abs (- x y)) 0.1))))
((t 'insert!) 1.2 1)
((t 'insert!) 2.3 2)
((t 'insert!) 10.0 3)
((t 'lookup) 1.21)
((t 'lookup) 2.32)
((t 'lookup) 20.0)
(t 'debug)
