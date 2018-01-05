(define (fold-right op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
    (define (iter result rest)
        (if (null? rest)
            result
            (iter (op result (car rest))
                  (cdr rest))))
    (iter initial sequence))

(define (reverse sequence)
    (fold-left (lambda (result head) (cons head result)) '() sequence))

(reverse (list 1 2 3 4))

(define (reverse sequence)
    (fold-right (lambda (head result) (append result (list head))) '() sequence))

(reverse (list 1 2 3 4))
