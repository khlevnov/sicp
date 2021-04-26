(define (length items)
    (define (length-iter items length)
        (if (null? items)
            length
            (length-iter (cdr items) (+ length 1))))
    (length-iter items 0))

(define (length items)
    (if (null? items)
        0
        (+ 1 (length (cdr items)))))

(define odds (list 1 3 5 7))
(define squares (list 1 4 9 16 25))

(define (append list1 list2)
    (if (null? list1)
        list2
        (cons (car list1) (append (cdr list1) list2))))

(append odds squares)
(cons 1 (append (list 3 5 7) squares))
(cons 1 (cons 3 (append (list 5 7) squares)))
(cons 1 (cons 3 (cons 5 (append (list 7) squares))))
(cons 1 (cons 3 (cons 5 (cons 7 (append '() squares)))))
(cons 1 (cons 3 (cons 5 (cons 7 squares))))
(cons 1 (cons 3 (cons 5 (list 7 1 4 9 16 25))))
(cons 1 (cons 3 (list 5 7 1 4 9 16 25)))
(cons 1 (list 3 5 7 1 4 9 16 25))
(list 1 3 5 7 1 4 9 16 25)
