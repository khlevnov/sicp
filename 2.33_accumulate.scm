(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

(append (list 4 5) (list 1 2 3 4 5))

(define (map p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(map square (list 5 4 3 2 1))

(define (length sequence)
    (accumulate (lambda (x y) (+ x y)) 0 sequence))

(length (list 1 2 3 4 5 6))
