(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
    (and (number? exp) (= exp num)))

(define (sum? x)
    (and (pair? x) (eq? (car x) '+)))
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
(define (addend s) (cadr s))
(define (augend s)
    (if (null? (cdddr s))
        (caddr s)
        (cons '+ (cddr s))))

(define (product? x)
    (and (pair? x) (eq? (car x) '*)))
(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
(define (multiplier p) (cadr p))
(define (multiplicand p)
    (if (null? (cdddr p))
        (caddr p)
        (cons '* (cddr p))))

(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '^)))
(define (base p) (cadr p))
(define (exponent p) (caddr p))
(define (make-exponentiation b e)
    (cond ((= e 0) 1)
          ((= e 1) b)
          (else (list '^ b e))))

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
                (if (same-variable? exp var) 1 0))
          ((sum? exp)
                (make-sum (deriv (addend exp) var)
                          (deriv (augend exp) var)))
          ((product? exp)
                (make-sum
                    (make-product (multiplier exp)
                                  (deriv (multiplicand exp) var))
                    (make-product (deriv (multiplier exp) var)
                                  (multiplicand exp))))
          ((exponentiation? exp)
                (make-product
                    (exponent exp)
                    (make-exponentiation var (- (exponent exp) 1))))
          (else
                (error "неизвестный тип выражения -- DERIV" exp))))

;(deriv '(+ x 4 x 4 (* 3 x) 4) 'x) ; 5
;(deriv '(+ x x x) 'x); 3
;(deriv '(+ x x) 'x); 2
;(deriv '(+ x 4 x 3 (* x 2) 1 x) 'x); 2
;(deriv '(* x x x) 'x)
(deriv '(* x y (* 3 x)) 'x)
(deriv '(* (* x y) (* 3 x)) 'x)
