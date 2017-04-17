(define (+ a b)
    (if (= a 0)
        b
        (+ (dec a) (inc b))))

(+ 4 5)

(+ (dec 4) (inc 5))
(+ (dec 3) (inc 6))
(+ (dec 2) (inc 7))
(+ (dec 1) (inc 8))
