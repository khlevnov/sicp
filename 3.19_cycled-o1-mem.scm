(define (cycled? x)
  (define (iter one two)
    (cond
      ((null? one) #f)
      ((null? two) #f)
      ((eq? one two) #t)
      (else
        (iter (cdr one) (cddr two)))))
  (cond
    ((null? x) #f)
    ((null? (cdr x)) #f)
    (else
      (iter x (cdr x)))))

(define finite-list (list 1 2 3 4 5 6 7 8 9))
(cycled? finite-list)

(set-cdr! (cddr finite-list) finite-list)
(cycled? finite-list)


; Code from July 2022!

(define (cycled? x)
    (define (iter left right)
        (cond
            ((null? left) #f)
            ((null? right) #f)
            ((eq? left right) #t)
            (else
                (iter (cdr left) (cddr right)))))
    (if (or (null? x) (null? (cdr x)))
        #f
        (iter x (cdr x))))

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

(define finite-list (list 1 2 3 4 5 6 7 8 9))
(cycled? finite-list)

(set-cdr! (cddr finite-list) finite-list)
(cycled? finite-list)
