(define (new-table)
    (let ((table '(*table*)))
        (define (entry tree)
            (car tree))
        (define (left-branch tree)
            (cadr tree))
        (define (right-branch tree)
            (caddr tree))
        (define (new-tree entry left right)
            (list entry left right))
        (define (assoc key tree)
            (cond
                ((null? tree) #f)
                ((= key (car (entry tree))) (entry tree))
                ((< key (car (entry tree))) (assoc key (left-branch tree)))
                ((> key (car (entry tree))) (assoc key (right-branch tree)))))
        (define (lookup key)
            (let ((record (assoc key (cdr table))))
                (if record
                    (cdr record)
                    #f)))
        (define (adjoin-tree key value tree)
            (cond
                ((null? tree) (new-tree (cons key value) '() '()))
                ((= key (car (entry tree)))
                    (begin
                        (set-cdr! (entry tree) value)
                        tree))
                ((< key (car (entry tree)))
                    (new-tree (entry tree)
                        (adjoin-tree key value (left-branch tree))
                        (right-branch tree)))
                ((> key (car (entry tree)))
                    (new-tree (entry tree)
                        (left-branch tree)
                        (adjoin-tree key value (right-branch tree))))))
        (define (insert! key value)
            (set-cdr! table (adjoin-tree key value (cdr table))))
        (define (dispatch m)
            (cond
                ((eq? m 'insert!) insert!)
                ((eq? m 'lookup) lookup)
                ((eq? m 'debug) table)
                (else
                    (error "Failed to dispatch undefined message" m))))
        dispatch))

(define t (new-table))
((t 'insert!) 2 'b)
((t 'insert!) 1 'a)
((t 'insert!) 4 'c)
((t 'insert!) 5 'd)
((t 'lookup) 1)
((t 'lookup) 2)
((t 'lookup) 5)
((t 'lookup) 4)
(t 'debug)
