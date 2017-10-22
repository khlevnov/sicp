(define (square x) (* x x))

(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))

(define (even? n)
    (= (remainder n 2) 0))

(define (expt b n)
    (define (expt-iter b n a)
        (cond ((= n 0) a)
              ((even? n) (expt-iter (square b) (/ n 2) a))
              (else (expt-iter b (- n 1) (* a b)))))
    (expt-iter b n 1))
