(define (double n) (+ n n))
(define (halve n) (/ n 2))

(define (even? n)
    (= (remainder n 2) 0))

(define (* a b)
    (if (= b 0)
        0
        (if (even? b)
            (* (double a) (halve b))
            (+ a (* a (- b 1)))
        )
    )
)

; 2*7
; 2 + 2*6
; 2 + 4*3
; 2 + 4 + 4*2
; 2 + 4 + 8*1
; 2 + 4 + 8 + 8*0
