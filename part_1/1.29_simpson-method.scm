(define (cube x) (* x x x))

(define (square x) (* x x))

(define (simpsons f a b n)
    (define (h a b n)
        (/ (- b a) n))

    (define (y k)
        (f (+ a (* k (h a b n)))))

    (define (next k)
        (cond ((= k 0) (y k))
              ((= k n) (y k))
              ((= (remainder k 2) 0) (* 2 (y k)))
              ((= (remainder k 2) 1) (* 4 (y k)))))

    (define (sum item i)
        (if (> i n)
            0
            (+ (next i) (sum (next i) (+ i 1)))))

    (* (/ (h a b n) 3) (sum (next 0) 0)))

; (simpsons cube 0 1 1000)
(simpsons square 2 4 1000)
