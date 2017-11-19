(define (get-reps n)
    (cond ((< n 4) 1) ; <2^2, 2-1=1
          ((and (> n 3) (< n 8)) 2) ; <2^3, 3-1=2
          ((and (> n 7) (< n 16)) 3) ; <2^4, 4-1=3
          ((and (> n 15) (< n 32)) 4) ; <2^5, 5-1=4
          ((and (> n 31) (< n 64)) 5)
          ((and (> n 63) (< n 128)) 6)
          ((and (> n 127) (< n 256)) 7)))

(define (get-reps number)
    (define (iter acc n)
        (if (< number acc)
            (- n 2)
            (iter (pow 2 n) (+ n 1))))
    (iter 0 1))

(get-reps 5)
