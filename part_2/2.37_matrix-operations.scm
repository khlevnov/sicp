(define matrix (list (list 1 2 3 4)
                     (list 4 5 6 6)
                     (list 6 7 8 9)))

(define transp (list (list 1 4 6)
                     (list 2 5 7)
                     (list 3 6 8)
                     (list 4 6 9)))

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(dot-product (list 3 4) (list 5 7)) ; (+ (* 3 5) (* 4 7)) ; 15 + 28 = 43

(define (matrix-*-vector m v)
    (map (lambda (row) (dot-product row v)) m))

(matrix-*-vector matrix (list 1 2 3 5))

(define (transpose mat)
    (define (accumulate-n op init seqs)
        (if (null? (car seqs))
            '()
            (cons (accumulate op init (map (lambda (sub-sequence) (car sub-sequence)) seqs))
                  (accumulate-n op init (map (lambda (sub-sequence) (cdr sub-sequence)) seqs)))))

    (accumulate-n cons '() mat))

(transpose matrix)

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
          (map (lambda (row-m) (matrix-*-vector cols row-m)) m)))

(matrix-*-matrix matrix (transpose matrix))
