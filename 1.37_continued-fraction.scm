(define (cont-frac n d k)
    (if (= k 0)
        (/ (n k) (d k))
        (/ (n k)
           (+ (d k) (cont-frac n d (- k 1))))))

(/ 1 (cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11))
