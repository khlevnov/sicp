(define (cons n m)
    (* (expt 2 n) (expt 3 m)))

(define (logx n base)
    (if (= n base)
        1
        (+ 1 (logx (/ n base) base))))

(define (car z)
    (if (not (= (remainder z 3) 0))
        (logx z 2)
        (car (/ z 3))))

(define (cdr z)
    (if (not (= (remainder z 2) 0))
        (logx z 3)
        (cdr (/ z 2))))

(car (cons 4 7))
(cdr (cons 4 7))
