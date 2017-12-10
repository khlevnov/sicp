(define nil '())

; Во fringed должен собираться только результат от (cons simple fringed)
(define (fringe items)
    (define (fringe-iter fringed items)
        (if (pair? items)
            (append (fringe-iter fringed (car items))
                    (fringe-iter fringed (cdr items)))
            (if (null? items)
                fringed
                (cons items fringed))))
    (fringe-iter nil items))

(fringe (list 1 (list 2 (list 3 4))))
(fringe (list (list 1 2) (list 3 4)))

;  *
; / \
;1   *
;   / \
;  2   *
;     / \
;    3   4
