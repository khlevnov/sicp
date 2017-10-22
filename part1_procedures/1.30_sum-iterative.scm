;(define (sum term a next b)
;    (define (iter a result)
;        (if ⟨??⟩
;            ⟨??⟩
;            (iter ⟨??⟩ ⟨??⟩)))
;    (iter ⟨??⟩ ⟨??⟩))

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            result
            (iter (next a) (+ result (term a)))))
    (iter a 0))

(define (identity x) x)

(define (inc x) (+ x 1))

(define (sum-integers a b)
    (define (identity x) x)
    (define (inc x) (+ x 1))
    (sum identity a inc b))

(sum-integers 1 7)
