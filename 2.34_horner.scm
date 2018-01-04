(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (display (* this-coeff 1))
                    (newline)
                    (+ (* this-coeff (expt x (- (length coefficient-sequence) 1)))
                       higher-terms))
                0
                coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1)) ; 79
