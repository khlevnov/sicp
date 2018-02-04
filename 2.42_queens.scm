(define (flatmap f sequence)
    (fold-right append '() (map f sequence)))

(define (enumerate-interval start n)
    (define (iter n result)
        (if (= n 0)
            result
            (iter (- n 1) (cons n result))))
    (iter n '()))

(define empty-board '())

(define (safe? k positions)
    true)

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter
                (lambda (positions) (safe? k positions))
                (flatmap (lambda (rest-of-queens)
                    (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                         (enumerate-interval 1 board-size)))
                    (queen-cols (- k 1))))))
    ; (queen-cols board-size)
    (queen-cols 2))

(queens 2)

; (((1 1)))
; (((1 1) (1 2) (2 1) (2 2)))
; (((1 1) ()))
