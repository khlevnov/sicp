(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f reps)
    (define (iter composition i)
        (if (= i 1)
            composition
            (iter (compose composition f) (- i 1))))
    (iter f reps))

; Дважды применить квадрат к пяти
((repeated square 2) 5) ; 625
; Трижды применить квадрат к пяти
((repeated square 3) 5) ; 390625

; Дважды применить инкремент к пяти
((repeated inc 2) 5) ; 7
; Трижды применить инкремент к пяти
((repeated inc 3) 5) ; 12
; Трижды применить инкремент к пяти
((repeated inc 4) 5) ; 9
