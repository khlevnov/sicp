(define (reverse items)
    (define (tail items)
        (if (null? (cdr items))
            (cdr items)
            (cons (car items) (tail (cdr items)))))

    (define (last-item items)
        (let ((tail (cdr items)))
            (if (null? tail)
                (car items)
                (last-item tail))))

    (if (null? (tail items))
        items
        (cons (last-item items) (reverse (tail items)))))

(define (reverse items)
    (define (reverse-iter reveresed items)
        (if (null? items)
            reveresed
            (reverse-iter (cons (car items) reveresed) (cdr items))))
    (reverse-iter nil items))

(reverse (list 1 4 9 16 25))

;(cons 25 (reverse (list 1 4 9 16)))
;(cons 25 (cons 16 (reverse (list 1 4 9))))
;(cons 25 (cons 16 (cons 9 (reverse (list 1 4)))))
;(cons 25 (cons 16 (cons 9 (cons 4 (reverse (list 1))))))
;(cons 25 (cons 16 (cons 9 (cons 4 (list 1)))))
;(cons 25 (cons 16 (cons 9 (list 4 1))))
;(cons 25 (cons 16 (list 9 4 1)))
;(cons 25 (list 16 9 4 1))
;(list 25 16 9 4 1)
