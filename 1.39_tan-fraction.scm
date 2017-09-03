(define (tan-frac x deep)
    (define (cont-frac n d k)
        (define (iter n d i result)
            (if (= i 0)
                result
                (iter n d (- i 1) (if (= i k)
                                      (/ (n i) (d i))
                                      (/ (n i) (- (d i) result))))))
        (iter n d k 0))

    (define (d i)
        (+ i (- i 1)))
    ; 1 3 5 7 9

    (cont-frac (lambda (i) (square x))
               d
               deep))

(tan-frac (/ 3.14159265359 4) 1000)
; -1
