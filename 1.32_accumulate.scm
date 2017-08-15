(define (identity x) x)

(define (inc x) (+ x 1))

(define (accumulate-recursive combiner null-value term a next b)
    (define (process term a next b)
        (if (> a b)
            null-value
            (combiner (term a) (process term (next a) next b))))
    (process term a next b))

(define (accumulate combiner null-value term a next b)
    (define (process term a next b)
        (define (iter a result)
            (if (> a b)
                result
                (iter (next a) (combiner result (term a)))))
        (iter a null-value))
    (process term a next b))

(define (product a b)
    (accumulate * 1 identity a inc b))

(define (sum a b)
    (accumulate + 0 identity a inc b))

(product 1 5)
(sum 1 5)
