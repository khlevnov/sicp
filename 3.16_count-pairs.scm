(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

; Эта процедура считает вхождения пар без учета их уникальности.
; Контрпримеры ниже.

; 3 pairs
(define three-pairs (list 1 2 3))
(count-pairs three-pairs)

; 4 pairs
(define shared (cons 'shared 'pair))
(define four-pairs (cons shared (cons shared '())))
(count-pairs four-pairs)

; 7 pairs
(define shared (cons 'shared 'pair))
(define another-shared (cons shared shared))
(define seven-pairs (cons another-shared another-shared))
(count-pairs seven-pairs)

; Inf pairs
(define shared (cons 'shared 'pair))
(set-cdr! shared shared)
(count-pairs shared)


; Code from July 2022!

(define foo '(a b c))
(count-pairs foo)

(define x '(a))
(define foo (cons x (cons x '())))
(count-pairs foo)

(define x '(a b c))
(define foo (cons x x))
(count-pairs foo)

(define x '(a))
(set-cdr! x x)
(count-pairs x)
