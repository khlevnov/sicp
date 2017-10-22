(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
    (newline)
    (display (numer x))
    (display "/")
    (display (denom x)))

(define (make-rat n d)
    (define (make-rat n d)
        (let ((g (gcd n d)))
            (cons (/ n g) (/ d g))))
    (if (> d 0)
        (make-rat n d)
        (make-rat (- n) (- d))))

(define (mul-rat x y)
    (make-rat-signed (* (numer x) (numer y))
                     (* (denom x) (denom y))))

Check rational number creation
(print-rat (make-rat-signed 1 2)) ; 1/2
(print-rat (make-rat-signed -1 2)) ; -1/2
(print-rat (make-rat-signed 1 -2)) ; -1/2
(print-rat (make-rat-signed -1 -2)) ; 1/2

(print-rat (mul-rat (make-rat 1 2) (make-rat 1 3))) ; 1/6
(print-rat (mul-rat (make-rat -1 2) (make-rat 1 3))) ; -1/6
(print-rat (mul-rat (make-rat 1 2) (make-rat -1 3))) ; -1/6
(print-rat (mul-rat (make-rat -1 2) (make-rat -1 3))) ; 1/6
