(define (expmod base exp m)
    (display "expmod ")
    (display base)
    (display " ")
    (display exp)
    (display " ")
    (display m)
    (newline)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(define (expmod base exp m)
    (display "expmod ")
    (display base)
    (display " ")
    (display exp)
    (display " ")
    (display m)
    (newline)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (* (expmod base (/ exp 2) m)
                         (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))

expmod 10 10 50
expmod 10 5 50
expmod 10 4 50
expmod 10 2 50
expmod 10 1 50
expmod 10 0 50

expmod 10 10 50
expmod 10 5 50
expmod 10 4 50
expmod 10 2 50
expmod 10 1 50
expmod 10 0 50
expmod 10 1 50
expmod 10 0 50
expmod 10 2 50
expmod 10 1 50
expmod 10 0 50
expmod 10 1 50
expmod 10 0 50
expmod 10 5 50
expmod 10 4 50
expmod 10 2 50
expmod 10 1 50
expmod 10 0 50
expmod 10 1 50
expmod 10 0 50
expmod 10 2 50
expmod 10 1 50
expmod 10 0 50
expmod 10 1 50
expmod 10 0 50
