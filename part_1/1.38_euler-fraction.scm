(define (euler-frac deep)
    (define (cont-frac n d k)
        (define (iter n d i result)
            (if (= i 0)
                result
                (iter n d (- i 1) (if (= i k)
                                      (/ (n i) (d i))
                                      (/ (n i) (+ (d i) result))))))
        (iter n d k 0))

    (define (d i)
        (define (not-one? i)
            (= (remainder (- i 2) 3) 0))
        (define (remove-threes i)
            (- i (/ (- i (remainder i 3)) 3)))
        (if (not-one? i)
            (remove-threes i)
            1))

    (cont-frac (lambda (i) 1.0)
               d
               deep))

(+ 2 (euler-frac 100))
