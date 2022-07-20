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

(define (cycled? x)
  (define pairs (make-set))
  (define (iter x)
    (cond
      ((null? x) #f)
      (((pairs 'has) x) #t)
      (else
        (begin
          ((pairs 'add) x)
          (iter (cdr x))))))
  (iter x))

(define finite-list (list 1 2 3))
(set-cdr! (cddr finite-list) finite-list)

(car finite-list)
(cadr finite-list)
(caddr finite-list)
(cadddr finite-list)

(define finite-list (list 1 2 3))
(cycled? finite-list)

(set-cdr! (cddr finite-list) finite-list)
(cycled? finite-list)


; Code from July 2022!

(define (cycled? x)
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
    (define (cycled? x)
        (cond
            ((null? x) #f)
            ((has pairs-set x) #t)
            (else
                (begin
                    (add x)
                    (cycled? (cdr x))))))
    (cycled? x))

(define foo '(a b c))
(cycled? foo)

(define x '(a))
(define foo (cons x (cons x '())))
(cycled? foo)

(define x '(a b c))
(define foo (cons x x))
(cycled? foo)

(define x '(a))
(set-cdr! x x)
(cycled? x)

(define finite-list (list 1 2 3))
(set-cdr! (cddr finite-list) finite-list)

(car finite-list)
(cadr finite-list)
(caddr finite-list)
(cadddr finite-list)

(define finite-list (list 1 2 3))
(cycled? finite-list)

(set-cdr! (cddr finite-list) finite-list)
(cycled? finite-list)
