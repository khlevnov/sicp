(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (fib n)
    (define (fib-iter a b count)
        (if (= count 0)
            b
            (fib-iter (+ a b) a (- count 1))))
    (fib-iter 1 0 n))

; 1.11
(define (f-recursive n)
    (if (< n 3)
        n
        (+ (f-recursive (- n 1)) (f-recursive (- n 2)) (f-recursive (- n 3)))))

; 3 -> 2 1 0 = 3
; 4 -> 3 2 1 = 3 2 1 = 6
; 5 -> 4 3 2 = 6 3 2 = 11
; 6 -> 5 4 3 = 11 6 3 = 20
; 7 -> 6 5 4 = 20 11 6 = 37

; накопить предыдущие значения от трех итераций
; a <- f-iter от предыдущей итерации

(define (f-iterative n)
    (define (f-iter a b c count)
        (if (< count 3)
        c
        (f-iter (+ a b c) a b (- count 1))))
    (f-iter 2 1 0 (+ n 2)))

(f-iterative 5)
