(define (identity x) x)
(define (inc x) (+ x 1))

(define (next-inc i)
    (if (= (remainder i 2) 0)
        i
        (+ i 1)))

(define (next-dec i)
    (if (= (remainder i 2) 0)
        (- i 1)
        i))

; recursive process
(define (product term a next b)
    (if (> a b)
        1.0
        (* (term a) (product term (next a) next b))))

; iterative process
(define (product term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (* result (term a)))))
    (iter a 1))

(define (factorial n)
    (product identity 1 inc n))

(define (pi iterations)
    (* 4.0 (/ (product next-inc 2 inc iterations)
              (product next-dec 3 inc (+ iterations 1)))))

(factorial 6)
(pi 10000)
