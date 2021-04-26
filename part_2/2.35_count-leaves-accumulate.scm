(define (count-leaves x)
    (cond ((null? x) 0)
          ((not (pair? x)) 1)
          (else (+ (count-leaves (car x))
                   (count-leaves (cdr x))))))

(define (count-leaves t)
    (accumulate + 0 (map (lambda (x) (if (pair? x) (count-leaves x) 1)) t)))

(count-leaves (list 1 2 3 (list 4 5) (list 6 (list 7 8 9) 10)))
