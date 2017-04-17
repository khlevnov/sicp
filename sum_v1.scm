(define (+ a b)
    (if (= a 0)
        b
        (inc (+ (dec a) b))))

(+ 4 5)

(inc (+ (dec 4) 5))
(inc (inc (+ (dec 3) 5)))
(inc (inc (inc (+ (dec 2) 5))))
(inc (inc (inc (inc (+ (dec 1) 5))))
