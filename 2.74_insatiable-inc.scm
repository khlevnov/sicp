(define (add-division type file) (cons type file))
(define (get-division typed-file) (car typed-file))
(define (get-content typed-file) (cdr typed-file))

(define (get-record file employee-name)
    (add-division (get-division file)
        ((get 'get-record (get-division file)) file employee-name)))

(define (get-salary record)
    ((get 'get-salary (car record)) (cdr record)))

(define (find-employee-record files employee-name)
    (if (null? files)
        #f
        (let ((file (car files)))
             (if (get-record file employee-name)
                 (get-record file employee-name)
                 (find-employee-name (cdr files) employee-name)))))
