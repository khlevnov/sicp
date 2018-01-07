(define (prime? n)
    (define (smallest-divisor n)
        (find-divisor n 2))
    (define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
              ((divides? test-divisor n) test-divisor)
              (else (find-divisor n (+ test-divisor 1)))))
    (define (divides? a b)
        (= (remainder b a) 0))
    (= n (smallest-divisor n)))

(define (unique-pairs n)
    (define (enumerate-interval n)
        (define (iter n result)
            (if (= n 0)
                result
                (iter (- n 1) (cons n result))))
        (iter n '()))

    (fold-right append
                '()
                (map (lambda (x)
                        (map (lambda (y) (list y x))
                            (enumerate-interval (- x 1))))
                     (enumerate-interval n))))

(define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? list)
    (define (prime? n)
        (define (smallest-divisor n)
            (find-divisor n 2))
        (define (find-divisor n test-divisor)
            (cond ((> (square test-divisor) n) n)
                  ((divides? test-divisor n) test-divisor)
                  (else (find-divisor n (+ test-divisor 1)))))
        (define (divides? a b)
            (= (remainder b a) 0))
        (= n (smallest-divisor n)))
    (prime? (+ (car list) (cadr list))))

(define (prime-sum-pairs n)
    (map make-pair-sum
        (filter prime-sum? (unique-pairs 4))))

(prime-sum-pairs 5)
