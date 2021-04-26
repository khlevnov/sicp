(define (equal? list1 list2)
    (cond ((and (null? list1) (null? list2)) #t)
          ((and (null? list1) (not (null? list2))) #f)
          ((and (not (null? list1)) (null? list2)) #f)
          ((and (list? (car list1)) (not (list? (car list1)))) #f)
          ((and (not (list? (car list1))) (list? (car list1))) #f)
          ((and (list? (car list1)) (list? (car list1))) (equal? (cdr list1) (cdr list2)))
          (else (if (eq? (car list1) (car list2))
                    (equal? (cdr list1) (cdr list2))
                    #f))))

(equal? '(this is a list) '(this is a list))   ; #t
(equal? '(this is a list) '(this (is a) list)) ; #f

(car ''abracadabra)
(car '(quote abracadabra))
