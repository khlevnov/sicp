(define *op-table* (make-hash-table))
(define (put op type proc)
    (hash-table/put! *op-table* (list op type) proc))
(define (get op type)
    (hash-table/get *op-table* (list op type) false))

(define (attach-tag type-tag contents)
    (if (number? contents)
        contents
        (cons type-tag contents)))
(define (type-tag datum)
    (cond ((pair? datum) (car datum))
          ((number? datum) 'scheme-number)
          (else (error "Некорректные помеченные данные -- TYPE-TAG" datum))))
(define (contents datum)
    (cond ((pair? datum) (cdr datum))
          ((number? datum) datum)
          (else (error "Некорректные помеченные данные -- CONTENTS" datum))))

(define (apply-generic op . args)
    (let ((type-tags (map type-tag args)))
         (let ((proc (get op type-tags)))
            (if proc
                (apply proc (map contents args))
                (error "Нет метода для этих типов -- APPLY-GENERIC" (list op type-tags))))))

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

; Scheme numbers package
(define (install-scheme-number-package)
    (define (tag x) (attach-tag 'scheme-number x))
    (put 'add '(scheme-number scheme-number) (lambda (x y) (tag (+ x y))))
    (put 'sub '(scheme-number scheme-number) (lambda (x y) (tag (- x y))))
    (put 'mul '(scheme-number scheme-number) (lambda (x y) (tag (* x y))))
    (put 'div '(scheme-number scheme-number) (lambda (x y) (tag (/ x y))))
    (put 'make 'scheme-number (lambda (x) (tag x)))
    'done)
(define (make-scheme-number n)
    ((get 'make 'scheme-number) n))

(install-scheme-number-package)

(mul 3 2)
