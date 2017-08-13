(define (sum term a next b)
    (define (iter a result)
        (if ⟨??⟩
            ⟨??⟩
            (iter ⟨??⟩ ⟨??⟩)))
    (iter ⟨??⟩ ⟨??⟩))

(define (sum term a next b)
    (if (> a b)
        0
        (+ (term a) (sum term (next a) next b))))

(define (sum term a next b)
    (define (iter a result)
        (if (> a b)
            0
            (iter (next a) (+ result (term a)))))
    (iter a 0))

(define (sum-integers a b)
    (if (> a b)
        0
        (+ a (sum-integers (+ a 1) b))))

(sum-integers 1 5)
