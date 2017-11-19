(define (smallest-divisor n)
    (find-divisor n 2))

(define (next number)
    (if (= number 2)
        3
        (+ number 2)))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
    (= (remainder b a) 0))

(define (prime? n)
    (= n (smallest-divisor n)))

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (search-for-primes start-number)
    (define (iterative-search number found-numbers-count)
        (if (< found-numbers-count 3)
            (if (prime? number)
                (and (timed-prime-test number)
                     (iterative-search (+ number 1) (+ found-numbers-count 1)))
                (iterative-search (+ number 1) found-numbers-count))))
    (iterative-search (+ start-number 1) 0))

; With next
(search-for-primes 1000000000) ; 0.02
(search-for-primes 10000000000) ; 0.06
(search-for-primes 100000000000) ; 0.18
(search-for-primes 1000000000000) ; 0.59
