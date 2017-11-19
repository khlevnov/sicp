(define (filtered-accumulate filter? combiner null-value term a next b)
    (define (process term a next b)
        (define (iter a result)
            (if (> a b)
                result
                (if (filter? a)
                    (iter (next a) (combiner result (term a)))
                    (iter (next a) result))))
        (iter a null-value))
    (process term a next b))

(define (always-true? x) #t)
(define (always-false? x) #f)
(define (identity x) x)
(define (inc x) (+ x 1))

(define (sum a b)
    (filtered-accumulate always-true? + 0 identity a inc b))

(define (product a b)
    (filtered-accumulate always-true? * 1 identity a inc b))

(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))

(define (prime? n)
    (if (= n 1)
        #f
        (= n (smallest-divisor n))))

(define (primes-squares-sum from to)
    (filtered-accumulate prime? + 0 square from inc to))

(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

(define (product-of-relative-primes n)
    (define (filter? i)
        (if (< i n)
            (= (gcd n i) 1)
            #f))
    (filtered-accumulate filter? * 1 identity 1 inc n))

(primes-squares-sum 1 5)
(product-of-relative-primes 10)
