(define *op-table* (make-hash-table))
(define (put op type proc)
    (hash-table/put! *op-table* (list op type) proc))
(define (get op type)
    (hash-table/get *op-table* (list op type) false))

(define *coercion-table* (make-hash-table))
(define (put-coercion from to coercion)
    (hash-table/put! *coercion-table* (list from to) coercion))
(define (get-coercion from to)
    (hash-table/get *coercion-table* (list from to) false))

(define (attach-tag type-tag contents)
    (if (number? contents)
        contents
        (cons type-tag contents)))
(define (type-tag datum)
    (cond ((pair? datum) (car datum))
          ((exact-integer? datum) 'integer)
          ((real? datum) 'real)
          (else (error "Некорректные помеченные данные -- TYPE-TAG" datum))))
(define (contents datum)
    (cond ((pair? datum) (cdr datum))
          ((number? datum) datum)
          (else (error "Некорректные помеченные данные -- CONTENTS" datum))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2)))

(define (add x y) (apply-generic 'add x y))
(define (add3 x y z) (apply-generic 'add3 x y z))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (exp x y) (apply-generic 'exp x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (square x) (apply-generic 'square x))
(define (sqrte x) (apply-generic 'sqrte x))
(define (convert-sign x) (apply-generic 'convert-sign x))

; Scheme numbers package
(define (install-integer-package)
    (define (tag x) (attach-tag 'integer x))
    (put 'add '(integer integer) (lambda (x y) (tag (+ x y))))
    (put 'add3 '(integer integer integer) (lambda (x y z) (tag (+ x y z))))
    (put 'sub '(integer integer) (lambda (x y) (tag (- x y))))
    (put 'mul '(integer integer) (lambda (x y) (tag (* x y))))
    (put 'div '(integer integer) (lambda (x y) (tag (/ x y))))
    (put 'exp '(integer integer) (lambda (x y) (tag (expt x y))))
    (put 'equ? '(integer integer) (lambda (x y) (= x y)))
    (put 'equ? '(integer integer) (lambda (x y) (= x y)))
    (put '=zero? '(integer) (lambda (x) (= x 0)))
    (put 'sine '(integer) (lambda (x) (sin x)))
    (put 'cosine '(integer) (lambda (x) (cos x)))
    (put 'square '(integer) (lambda (x) (* x x)))
    (put 'sqrte '(integer) (lambda (x) (sqrt x)))
    (put 'convert-sign '(integer) (lambda (x) (- x)))
    (put 'make 'integer (lambda (x) (tag x)))
    'done)
(define (make-integer n)
    ((get 'make 'integer) n))

; Scheme reals package
(define (install-real-package)
    (define (tag x) (attach-tag 'real x))
    (put 'add '(real real) (lambda (x y) (tag (+ x y))))
    (put 'add3 '(real real real) (lambda (x y z) (tag (+ x y z))))
    (put 'sub '(real real) (lambda (x y) (tag (- x y))))
    (put 'mul '(real real) (lambda (x y) (tag (* x y))))
    (put 'div '(real real) (lambda (x y) (tag (/ x y))))
    (put 'exp '(real real) (lambda (x y) (tag (expt x y))))
    (put 'equ? '(real real) (lambda (x y) (= x y)))
    (put '=zero? '(real) (lambda (x) (= x 0)))
    (put 'sine '(real) (lambda (x) (sin x)))
    (put 'cosine '(real) (lambda (x) (cos x)))
    (put 'square '(real) (lambda (x) (* x x)))
    (put 'sqrte '(real) (lambda (x) (sqrt x)))
    (put 'convert-sign '(real) (lambda (x) (- x)))
    (put 'make 'real (lambda (x) (tag (* x 1.0))))
    'done)
(define (make-real n)
    ((get 'make 'real) n))

; Rational number package
(define (install-rational-package)
    (define (numer x) (car x))
    (define (denom x) (cdr x))
    (define (make-rat n d)
        (let ((g (gcd n d)))
             (cons (/ n g) (/ d g))))
    (define (add-rat x y)
        (make-rat (+ (* (numer x) (denom y))
                     (* (numer y) (denom x)))
                  (* (denom x) (denom y))))
    (define (sub-rat x y)
        (make-rat (- (* (numer x) (denom y))
                     (* (numer y) (denom x)))
                  (* (denom x) (denom y))))
    (define (mul-rat x y)
        (make-rat (* (numer x) (numer y))
                  (* (denom x) (denom y))))
    (define (div-rat x y)
        (make-rat (* (numer x) (denom y))
                  (* (denom x) (numer y))))

    (define (tag x) (attach-tag 'rational x))
    (put 'numer '(rational) numer)
    (put 'denom '(rational) denom)
    (put 'add '(rational rational) (lambda (x y) (tag (add-rat x y))))
    (put 'sub '(rational rational) (lambda (x y) (tag (sub-rat x y))))
    (put 'mul '(rational rational) (lambda (x y) (tag (mul-rat x y))))
    (put 'div '(rational rational) (lambda (x y) (tag (div-rat x y))))
    (put 'equ? '(rational rational)
        (lambda (x y) (and (= (numer x) (numer y))
                           (= (denom x) (denom y)))))
    (put '=zero? '(rational) (lambda (x) (= (numer x) 0)))
    (put 'sine '(rational) (lambda (x) (sin (/ (numer x) (denom x)))))
    (put 'cosine '(rational) (lambda (x) (cos (/ (numer x) (denom x)))))
    (put 'square '(rational) (lambda (x)
        (tag (make-rat (* (numer x) (numer x))
                       (* (denom x) (denom x))))))
    (put 'sqrte '(rational) (lambda (x)
        (/ (sqrt (numer x)) (sqrt (denom x)))))
    (put 'convert-sign '(rational)
        (lambda (x)
            (make-rat (- (numer x))
                      (denom x))))
    (put 'make 'rational (lambda (n d) (tag (make-rat n d))))
    'done)
(define (make-rational n d)
    ((get 'make 'rational) n d))
(define (numer r) (apply-generic 'numer r))
(define (denom r) (apply-generic 'denom r))

; Rectangular complex number package
(define (install-rectangular-package)
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
        (sqrte (add (square (real-part z)) (square (imag-part z)))))
    (define (angle z) (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a) (cons (* r (cosine a)) (* r (sine a))))

    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'equ? '(rectangular rectangular) (lambda (x y) (and (= (real-part x) (real-part y))
                                                 (= (imag-part x) (imag-part y)))))
    (put '=zero? '(rectangular) (lambda (x) (and (= (real-part x) 0)
                                                 (= (imag-part x) 0))))
    (put 'make-from-real-imag 'rectangular (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

; Polar complex number package
(define (install-polar-package)
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z) (* (magnitude z) (cosine (angle z))))
    (define (imag-part z) (* (magnitude z) (sine (angle z))))
    (define (make-from-real-imag x y)
        (cons (sqrt (+ (square x) (square y)))
        (atan y x)))

    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'equ? '(polar polar) (lambda (x y) (and (= (magnitude x) (magnitude y))
                                                 (= (angle x) (angle y)))))
    (put '=zero? '(polar) (lambda (x) (and (= (magnitude x) 0)
                                           (= (angle x) 0))))
    (put 'make-from-real-imag 'polar (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

; Complex number package
(define (install-complex-package)
    (define (make-from-real-imag x y)
        ((get 'make-from-real-imag 'rectangular) x y))
    (define (make-from-mag-ang r a)
        ((get 'make-from-mag-ang 'polar) r a))

    (define (add-complex z1 z2)
        (make-from-real-imag (add (real-part z1) (real-part z2))
                             (add (imag-part z1) (imag-part z2))))
    (define (sub-complex z1 z2)
        (make-from-real-imag (sub (real-part z1) (real-part z2))
                             (sub (imag-part z1) (imag-part z2))))
    (define (mul-complex z1 z2)
        (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                           (add (angle z1) (angle z2))))
    (define (div-complex z1 z2)
        (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                           (sub (angle z1) (angle z2))))

    (define (tag z) (attach-tag 'complex z))
    (put 'add '(complex complex) (lambda (z1 z2) (tag (add-complex z1 z2))))
    (put 'add3 '(complex complex complex)
        (lambda (z1 z2 z3) (tag (add-complex z1 (add-complex z2 z3)))))
    (put 'sub '(complex complex) (lambda (z1 z2) (tag (sub-complex z1 z2))))
    (put 'mul '(complex complex) (lambda (z1 z2) (tag (mul-complex z1 z2))))
    (put 'div '(complex complex) (lambda (z1 z2) (tag (div-complex z1 z2))))
    (put 'equ? '(complex complex) equ?)
    (put '=zero? '(complex) =zero?)
    (put 'make-from-real-imag 'complex (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'complex (lambda (r a) (tag (make-from-mag-ang r a))))

    (put 'real-part '(complex) real-part)
    (put 'imag-part '(complex) imag-part)
    (put 'magnitude '(complex) magnitude)
    (put 'angle '(complex) angle)
    'done)
(define (make-complex-from-real-imag x y)
    ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
    ((get 'make-from-mag-ang 'complex) r a))


(define (same-types? args)
    (if (= (length args) 1)
        true
        (let ((first-type (type-tag (car args)))
              (second-type (type-tag (cadr args))))
             (if (not (equal? first-type second-type))
                 false
                 (if (= (length args) 2)
                     true
                     (same-types? (cdr args)))))))

(define (raise-args args)
    (define (raise-pair a b)
        (define (raise-first a b)
            (if (same-types? (list a b))
                (list a b)
                (let ((raised-a (raise a)))
                     (if raised-a
                         (raise-first raised-a b)
                         false))))
        (define (raise-second a b)
            (if (same-types? (list a b))
                (list a b)
                (let ((raised-b (raise b)))
                     (if raised-b
                         (raise-second a raised-b)
                         false))))
        (if (same-types? (list a b))
            (list a b)
            (let ((raised-first (raise-first a b))
                  (raised-second (raise-second a b)))
                 (cond (raised-first raised-first)
                       (raised-second raised-second)
                       (else '())))))

    (if (same-types? args)
        args
        (let ((raised-pair (raise-pair (car args) (cadr args))))
             (if (= (length args) 2)
                 raised-pair
                 (raise-args (cons (car raised-pair)
                                   (raise-args (cons (cadr raised-pair)
                                                     (cddr args)))))))))

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
        (let ((proc (get op type-tags)))
             (if proc
                 (let ((result (apply proc (map contents args))))
                      (if (and (> (length args) 1)
                               (not (boolean? result)))
                          (drop result)
                          result))
                 (let ((same-type-args (raise-args args)))
                      (let ((same-type-tags (map type-tag same-type-args)))
                           (let ((same-type-proc (get op same-type-tags)))
                                (if same-type-proc
                                    (drop (apply same-type-proc (map contents same-type-args)))
                                    (error "Нет функции после преобразований" (list op same-type-tags))
                                    ))))))))

(install-integer-package)
(install-real-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define (raise x) (apply-generic 'raise x))
(put 'raise '(integer) (lambda (x) (make-rational x 1)))
(put 'raise '(rational) (lambda (x)
    (make-real (/ (numer (attach-tag 'rational x))
                  (denom (attach-tag 'rational x))))))
(put 'raise '(real) (lambda (x) (make-complex-from-real-imag x 0)))
(put 'raise '(complex) (lambda (x) false))

(define (project x) (apply-generic 'project x))
(put 'project '(complex)
    (lambda (x)
        (cond ((and (equal? (type-tag x) 'polar)
                    (equal? (type-tag (magnitude x)) 'rational))
               false)
              ((and (equal? (type-tag x) 'rectangular)
                    (equal? (type-tag (real-part x)) 'rational))
               false)
               (else (make-real (real-part x))))))
(put 'project '(real) (lambda (x) (make-rational (inexact->exact (round x)) 1)))
(put 'project '(rational) (lambda (x) (numer (attach-tag 'rational x))))
(put 'project '(integer) (lambda (x) false))
(put 'project '(polynomial) (lambda (x) false))

(define (indentity x) x)
(define (drop x)
    (let ((dropped (project x)))
         (if dropped
             (if (equ? x (raise dropped))
                 (drop dropped)
                 x)
             x)))

; **************
;
; Dense package
;
; **************

(define (install-dense-polynomial-package)
    (define (make-polynomial variable term-list) (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))
    (define (first-term term-list)
        (list (car term-list)
              (- (length term-list) 1)))
    (define (rest-terms term-list) (cdr term-list))
    (define (the-empty-termlist) '())
    (define (empty-termlist? term-list) (null? term-list))
    (define (make-term coeff order) (list coeff order))
    (define (coeff term) (car term))
    (define (order term) (cadr term))
    (define (adjoin-term term-list)
        (lambda (term)
            (if (= (order term) (length term-list))
                (cons (coeff term) term-list)
                (adjoin-term term (cons 0 term-list)))))

    (define (tag term-list) (attach-tag 'dense term-list))
    (put 'make-polynomial 'dense (lambda (variable term-list)
        (tag (make-polynomial variable term-list))))
    (put 'variable '(dense) variable)
    (put 'term-list '(dense) (lambda (p) (tag (term-list p))))
    (put 'first-term '(dense) first-term)
    (put 'rest-terms '(dense) (lambda (term-list) (tag (rest-terms term-list))))
    (put 'the-empty-termlist '() (lambda () (tag (the-empty-termlist))))
    (put 'empty-termlist? '(dense) empty-termlist?)
    (put 'adjoin-term '(dense)
        (lambda (term-list)
            (lambda (term)
                (tag ((adjoin-term term-list) term)))))
    (put 'raise '(dense) (lambda (x) false))
    (put 'project '(dense) (lambda (x) false))
    'done)

; **************
;
; Sparse package
;
; **************

(define (install-sparse-polynomial-package)
    (define (make-polynomial variable term-list) (cons variable term-list))
    (define (variable p) (car p))
    (define (term-list p) (cdr p))
    (define (first-term term-list) (car term-list))
    (define (rest-terms term-list) (cdr term-list))
    (define (the-empty-termlist) '())
    (define (empty-termlist? term-list) (null? term-list))
    (define (make-term coeff order) (list coeff order))
    (define (coeff term) (car term))
    (define (order term) (cadr term))
    (define (adjoin-term term-list)
        (lambda (term)
            (if (=zero? (coeff term))
                term-list
                (cons term term-list))))

    (define (tag term-list) (attach-tag 'sparse term-list))
    (put 'make-polynomial 'sparse (lambda (variable term-list)
        (tag (make-polynomial variable term-list))))
    (put 'variable '(sparse) variable)
    (put 'term-list '(sparse) (lambda (p) (tag (term-list p))))
    (put 'first-term '(sparse) first-term)
    (put 'rest-terms '(sparse) (lambda (term-list) (tag (rest-terms term-list))))
    (put 'the-empty-termlist '() (lambda () (tag (the-empty-termlist))))
    (put 'empty-termlist? '(sparse) empty-termlist?)
    (put 'adjoin-term '(sparse)
        (lambda (term-list)
            (lambda (term)
                (tag ((adjoin-term term-list) term)))))
    (put 'raise '(sparse) (lambda (x) false))
    (put 'project '(sparse) (lambda (x) false))
    'done)

(define (variable polynomial) (apply-generic 'variable polynomial))
(define (term-list polynomial) (apply-generic 'term-list polynomial))
(define (first-term term-list) (apply-generic 'first-term term-list))
(define (rest-terms term-list) (apply-generic 'rest-terms term-list))
(define (the-empty-termlist) (apply-generic 'the-empty-termlist))
(define (empty-termlist? term-list) (apply-generic 'empty-termlist? term-list))
(define (adjoin-term term-list) (apply-generic 'adjoin-term term-list))

; ******************
;
; Polynomial package
;
; ******************

(define (install-polynomial-package)
    (define (make-sparse-polynomial variable term-list)
        ((get 'make-polynomial 'sparse) variable term-list))
    (define (make-dense-polynomial variable term-list)
        ((get 'make-polynomial 'dense) variable term-list))
    (define (make-poly variable term-list)
        (make-sparse-polynomial variable (contents term-list)))

    (define (make-term coeff order) (list coeff order))
    (define (coeff term) (car term))
    (define (order term) (cadr term))
    (define (=zero? p)
        (define (zero-termlist? term-list)
            (define (sum-of-coeffs term-list sum)
                (if (empty-termlist? term-list)
                    sum
                    (sum-of-coeffs (rest-terms term-list)
                                   (add (coeff (first-term term-list)) sum))))
            (=zero? (sum-of-coeffs term-list 0)))
        (let ((term-list (term-list p)))
             (cond ((empty-termlist? term-list) true)
                   ((zero-termlist? term-list) true)
                   (else false))))

    (define (add-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly
                (variable p1)
                (add-terms (term-list p1)
                           (term-list p2)))
            (error "Многочлены от разных переменных -- ADD-POLY"
                (list p1 p2))))

    (define (add-terms L1 L2)
        (cond ((empty-termlist? L1) L2)
              ((empty-termlist? L2) L1)
              (else
                  (let ((t1 (first-term L1))
                        (t2 (first-term L2)))
                       (cond ((> (order t1) (order t2))
                              ((adjoin-term
                                  (add-terms (rest-terms L1) L2))
                                    t1))
                             ((< (order t1) (order t2))
                              ((adjoin-term
                                  (add-terms L1 (rest-terms L2)))
                                    t2))
                             (else
                              ((adjoin-term
                                  (add-terms (rest-terms L1)
                                             (rest-terms L2)))
                                  (make-term (add (coeff t1) (coeff t2))
                                             (order t1)))))))))

    (define (sub-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly
                (variable p1)
                (sub-terms (term-list p1)
                           (term-list p2)))
            (error "Многочлены от разных переменных -- SUB-POLY"
                (list p1 p2))))

    (define (sub-terms L1 L2)
        (cond ((empty-termlist? L2) L1)
              ((empty-termlist? L1)
                    ((adjoin-term (sub-terms L1 (rest-terms L2)))
                        (make-term (- (coeff (first-term L2)))
                                   (order (first-term L2)))))
              (else
                  (let ((t1 (first-term L1))
                        (t2 (first-term L2)))
                       (cond ((> (order t1) (order t2))
                              ((adjoin-term
                                  (sub-terms (rest-terms L1) L2))
                                    t1))
                             ((< (order t1) (order t2))
                              ((adjoin-term
                                  (sub-terms L1 (rest-terms L2)))
                                    (make-term (convert-sign (coeff t2))
                                               (order t2))))
                             (else
                              ((adjoin-term
                                  (sub-terms (rest-terms L1)
                                             (rest-terms L2)))
                                    (make-term (sub (coeff t1) (coeff t2))
                                               (order t1)))))))))

    (define (mul-poly p1 p2)
        (if (same-variable? (variable p1) (variable p2))
            (make-poly (variable p1)
                       (mul-terms (term-list p1)
                                  (term-list p2)))
            (error "Многочлены от разных переменных -- MUL-POLY"
                (list p1 p2))))

    (define (mul-terms L1 L2)
        (if (empty-termlist? L1)
            L1
            (add-terms (mul-term-by-all-terms (first-term L1) L2)
                       (mul-terms (rest-terms L1) L2))))

    (define (mul-term-by-all-terms t1 L)
        (if (empty-termlist? L)
            L
            (let ((t2 (first-term L)))
                 ((adjoin-term
                     (mul-term-by-all-terms t1 (rest-terms L)))
                         (make-term (mul (coeff t1) (coeff t2))
                                    (+ (order t1) (order t2)))))))

    (define (tag p) (attach-tag 'polynomial p))
    (put 'make-sparse-polynomial 'polynomial (lambda (variable term-list)
        (tag (make-sparse-polynomial variable term-list))))
    (put 'make-dense-polynomial 'polynomial (lambda (variable term-list)
        (tag (make-dense-polynomial variable term-list))))

    (put 'variable '(polynomial) variable)
    (put 'term-list '(polynomial) term-list)
    (put 'first-term '(polynomial) first-term)
    (put 'rest-terms '(polynomial) rest-terms)
    (put 'empty-termlist? '(polynomial) empty-termlist?)

    (put 'add '(polynomial polynomial) (lambda (p1 p2) (tag (add-poly p1 p2))))
    (put 'sub '(polynomial polynomial) (lambda (p1 p2) (tag (sub-poly p1 p2))))
    (put 'mul '(polynomial polynomial) (lambda (p1 p2) (tag (mul-poly p1 p2))))
    (put '=zero? '(polynomial) =zero?)

    (put 'raise '(polynomial) (lambda (x) false))
    (put 'project '(polynomial) (lambda (x) false))
    'done)

(define (make-sparse-polynomial variable term-list)
    ((get 'make-sparse-polynomial 'polynomial) variable term-list))
(define (make-dense-polynomial variable term-list)
    ((get 'make-dense-polynomial 'polynomial) variable term-list))

(install-sparse-polynomial-package)
(install-dense-polynomial-package)
(install-polynomial-package)

(define sparse1 (make-sparse-polynomial 'x (list '(2 4) '(7 3) '(4 2) '(1 1) '(42 0))))
(define sparse2 (make-sparse-polynomial 'x (list '(7 2) '(3 1))))
(define empty-sparse (make-sparse-polynomial 'x '()))
(define dense1 (make-dense-polynomial 'x (list 2 7 4 3 42)))
(define dense2 (make-dense-polynomial 'x (list 7 3 0)))
(mul sparse1 sparse1)
