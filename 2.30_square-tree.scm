(define nil '())

(define (scale-tree tree factor)
    (cond ((null? tree) nil)
          ((not (pair? tree)) (* tree factor))
          (else (cons (scale-tree (car tree) factor)
                      (scale-tree (cdr tree) factor)))))

;(scale-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)) 10)

(define (square-tree tree)
    (cond ((null? tree) nil)
          ((not (pair? tree)) (square tree))
          (else (cons (square-tree (car tree))
                      (square-tree (cdr tree))))))

(square-tree
    (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))
