(define (identity x) x)

(define (inc x) (+ x 1))

(define (accumulate combiner null-value term a next b)
    (define (process term a next b)
        (display a)
        (if (> a b)
            null-value
            (combiner (term a) (process term (next a) next b))))
    (process term a next b))

(define (product a b)
    (accumulate * 1 identity a inc b))

(define (sum a b)
    (accumulate + 0 identity a inc b))

(product 4 5)
(sum 4 5)
