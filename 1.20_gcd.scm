(define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

; Для аппликативного порядка
; a = 206, b = 40
(if (= 40 0)
    206
    ; a = 40, b = 6, первое вычисление remainder в аппликативном порядке
    (if (= 6 0)
        40
        ; a = 6, b = 4, второе вычисление remainder в аппликативном порядке
        (if (= 4 0)
            6
            ; a = 4, b = 2, третье вычисление remainder в аппликативном порядке
            (if (= 2 0)
                4
                ; a = 2, b = 0, четвертое вычисление remainder в аппликативном порядке
                (if (= 0 0)
                    2
                    ; ...

; Для аппликативного порядка
; a = 206, b = 40
(if (= 40 0)
    206
    (if (= (remainder 206 40) 0 ; (= 6 0)
        40
        (if (= (remainder 40 (remainder 206 40)) 0) ; (= 4 0)
            ; (remainder 206 40) ; 6
            (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) ; (= 2 0)
                ; (remainder 40 (remainder 206 40)) ; 4
                (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) ; (= 0 0)
                    (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
                    ; ...
