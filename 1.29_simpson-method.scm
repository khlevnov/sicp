(define (cube x) (* x x x))

(define (simpsons f a b n)
    (define (h a b n)
        (/ (- b a) n))

    (define (y k)
        (f (+ a (* k (h a b n)))))

    (define (next-y y i)
        (cond (= i 0) y
              (= i n) y
              (= (remainder i 2) 0) (* 2 y)
              (= (remainder i 2) 1) (* 4 y)))

    (define (sum y i)
        (if (> i n)
            0
            (+ (next-y y i) (sum y (+ i 1)))))

    (* (/ h 3) (sum (y 0 0))))

(simpsons cube 0 1 100)

; h/3 [y0 + 4y1 + 2y2 + 4y3 + 2y4 ... + yn]
