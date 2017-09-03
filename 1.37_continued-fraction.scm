(define (cont-frac-recursive n d k)
    (if (= k 0)
        (/ (n k) (d k))
        (/ (n k)
           (+ (d k) (cont-frac n d (- k 1))))))

(/ 1 (cont-frac-recursive (lambda (i) 1.0)
    (lambda (i) 1.0)
    12))

(define (cont-frac n d k)
    (define (iter n d i result)
        (if (= i 0)
            result
            (iter n d (- i 1) (if (= i k)
                                  (/ (n i) (d i))
                                  (/ (n i) (+ (d i) result))))))
    (iter n d k 0))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)
