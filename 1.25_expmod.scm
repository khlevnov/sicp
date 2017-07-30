(define (even? n)
    (= (remainder n 2) 0))

(define (square m)
    (display "square ")(display m)(newline)
        (* m m))

(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
    (remainder (fast-expt base exp) m))

(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(expmod 4 4 50) ; 4^4 - 50*5 = 6
(remainder (square (expmod 4 2 50)) 50)
(remainder (square (remainder (square (expmod 4 1 50)) 50)) 50)
(remainder (square (remainder (square (remainder (* 4 (expmod 4 (- 1 1) 50)) 50)) 50)) 50)
(remainder (square (remainder (square (remainder (* 4 (expmod 4 0 50)) 50)) 50)) 50)
(remainder (square (remainder (square (remainder (* 4 1) 50)) 50)) 50)
(remainder (square (remainder (square (remainder 4 50)) 50)) 50)
(remainder (square (remainder (square 4) 50)) 50)
(remainder (square (remainder 16 50)) 50)
(remainder (square 16) 50)
(remainder 256 50)

(expmod 56 755 50) ; 46
(remainder (* 56 (expmod 56 754 50)) 50) ; 56*46
(remainder (* 56 (remainder (square (expmod 56 377 50)) 50)) 50) ; 36^2
(remainder (* 56 (remainder (square (remainder (* 56 (expmod 56 376 50)) 50)) 50)) 50)

(expmod 4 4 50) ; 4^4 - 50*5 = 6
(remainder (fast-expt 4 4) 50)
(remainder (square (fast-expt 4 (/ 4 2))) 50)
(remainder (square (fast-expt 4 2)) 50)
(remainder (square (square (fast-expt 4 (/ 2 2)))) 50)
(remainder (square (square (fast-expt 4 1))) 50)
(remainder (square (square (* 4 (fast-expt 4 (- 1 1))))) 50)
(remainder (square (square (* 4 (fast-expt 4 0)))) 50)
(remainder (square (square (* 4 1))) 50)
(remainder (square (square 4)) 50)
(remainder (square 16) 50)
(remainder 256 50)
