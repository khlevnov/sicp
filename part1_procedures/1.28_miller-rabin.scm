(define (unusual? x n)
    (cond ((= x 1) false)
          ((= x (- n 1)) false)
          (else (= (remainder (square x) n) 1))))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (let ((x (expmod base (/ exp 2) m)))
                (if (unusual? x m)
                    0
                    (remainder (square x) m))))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test x n)
    (cond ((= x 0) true)
          ((= (expmod x (- n 1) n) 1) (miller-rabin-test (- x 1) n))
          (else false)))

(define (miller-rabin n)
    (miller-rabin-test (- n 1) n))

(miller-rabin 5)
(miller-rabin 7)
(miller-rabin 8)
(miller-rabin 16)
(miller-rabin 17)
(miller-rabin 18)

(miller-rabin 561)
(miller-rabin 1105)
(miller-rabin 1729)
(miller-rabin 2465)
(miller-rabin 2821)
(miller-rabin 6601)
