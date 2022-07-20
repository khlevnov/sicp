(define (make-set)
  (define set '())
  (define (add x)
    (set! set (cons x set)))
  (define (contains? set x)
    (cond
      ((null? set) #f)
      ((eq? (car set) x) #t)
      (else
        (contains? (cdr set) x))))
  (define (dispatch message)
    (cond
      ((eq? message 'add) add)
      ((eq? message 'has)
        (lambda (x) (contains? set x)))
      (else
        (error "undefined message"))))
  dispatch)

(define pair-set (make-pair-set))
(define a (cons 1 2))
(define b (cons 3 4))
((pair-set 'add) a)
((pair-set 'add) b)
((pair-set 'add) (cons 5 6))
((pair-set 'has) a)
((pair-set 'has) b)
((pair-set 'has) (cons 1 1))

(define existing-pairs (make-set))

(define (count-pairs x)
  (cond
    ((not (pair? x)) 0)
    (((existing-pairs 'has) x) 0)
    (else
      (begin
        ((existing-pairs 'add) x)
        (+
          (count-pairs (car x))
          (count-pairs (cdr x))
          1)))))

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

(define (count-pairs x)
    (define pairs-set '())
    (define (add x)
        (if (not (has pairs-set x))
            (set! pairs-set (cons x pairs-set))))
    (define (has pairs-set x)
        (cond
            ((null? pairs-set) #f)
            ((eq? (car pairs-set) x) #t)
            (else
                (has (cdr pairs-set) x))))
    (define (count x)
        (cond
            ((not (pair? x)) 0)
            ((has pairs-set x) 0)
            (else
                (begin
                    (add x)
                    (+ 1
                        (count (car x))
                        (count (cdr x)))))))
    (count x))

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
