(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (fast-prime? n 5)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (search-for-primes start-number)
    (define (iterative-search number found-numbers-count)
        (if (< found-numbers-count 3)
            (if (fast-prime? number 5)
                (and (timed-prime-test number)
                     (iterative-search (+ number 1) (+ found-numbers-count 1)))
                (iterative-search (+ number 1) found-numbers-count))))
    (iterative-search (+ start-number 1) 0))

; With next
(search-for-primes 10000000000) ; 0.
(search-for-primes 100000000000000000000) ; 0.
(search-for-primes 10000000000000000000000000000000000000000) ; 0.
(search-for-primes 100000000000000000000000000000000000000000000000000000000000000000000000000000000) ; 0.
(search-for-primes 10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000) ; 0.
(search-for-primes 100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000) ; 0.
