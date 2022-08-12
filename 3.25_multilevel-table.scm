(define (new-table)
    (let ((table '(*table*)))
        (define (assoc key records)
            (cond
                ((null? records) #f)
                ((eq? key (caar records)) (car records))
                (else (assoc key (cdr records)))))
        (define (assoc-deep keys records)
            (cond
                ((null? records) #f)
                ((eq? (car keys) (caar records))
                    (if (null? (cdr keys))
                        (car records)
                        (assoc-deep (cdr keys) (cdar records))))
                (else (assoc-deep keys (cdr records)))))
        (define (lookup keys)
            (let ((record (assoc-deep keys (cdr table))))
                (if (and record (not (list? (cdr record))))
                    (cdr record)
                    #f)))
        (define (insert! table key value)
            (let ((record (assoc key (cdr table))))
                (if record
                    (set-cdr! record value)
                    (set-cdr! table (cons (cons key value) (cdr table))))))
        (define (insert-deep! table keys value)
            (if (not (null? keys))
                (if (not (null? (cdr keys)))
                    (let ((subtable (assoc (car keys) (cdr table))))
                        (if subtable
                            (insert-deep! subtable (cdr keys) value)
                            (begin
                                (insert! table (car keys) '())
                                (insert-deep!
                                    (assoc (car keys) (cdr table))
                                    (cdr keys)
                                    value))))
                    (insert! table (car keys) value))))
        (define (dispatch m)
            (cond
                ((eq? m 'insert!) (lambda (keys value) (insert-deep! table keys value)))
                ((eq? m 'lookup) lookup)
                ((eq? m 'debug) table)
                (else
                    (error "Failed to dispatch undefined message" m))))

        (define math
            (list 'math (cons '+ 43) (cons '- 45) (cons '* 42)))
        (define letters
            (list 'letters (cons 'a 97) (cons 'b 98)))
        (set-cdr! table (list math letters))

        dispatch))

(define t (new-table))
(t 'debug)
((t 'lookup) '(math +))
((t 'lookup) '(math -))
((t 'lookup) '(math *))
((t 'lookup) '(letters a))
((t 'lookup) '(letters b))
((t 'lookup) '(math))
((t 'lookup) '(a b c d))
((t 'insert!) '(foo a b) '11)
((t 'insert!) '(foo a c) '12)
((t 'insert!) '(foo d) '10)
((t 'lookup) '(foo a c))
((t 'lookup) '(foo d))
(t 'debug)
