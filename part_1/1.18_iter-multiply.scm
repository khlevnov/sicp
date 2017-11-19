(define (double n) (+ n n))
(define (halve n) (/ n 2))

(define (even? n)
    (= (remainder n 2) 0))

(define (* a b)
    (define (iter a b status)
        (if (= b 0) status
            (if (even? b)
                (iter (double a) (halve b) status)
                (iter a (- b 1) (+ status a))
            )))
    (iter a b 0))

; 2*7
; 2 + 2*6
; 2 + 4*3
; 2 + 4 + 4*2
; 2 + 4 + 8*1
; 2 + 4 + 8 + 8*0
