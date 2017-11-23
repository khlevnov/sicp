(define (make-interval a b) (cons a b))
(define (upper-bound interval)
    (max (car interval) (cdr interval)))
(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (make-center-width center width)
    (make-interval (- center width) (+ center width)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (lower-bound interval) (upper-bound interval)) 2))

(define (make-center-percent center percent)
    (let ((width (* center (/ percent 100))))
        (make-center-width center width)))

(define (percent interval)
    (* (/ (width interval) (center interval)) 100))

(define i (make-center-width 3.5 0.25))
(upper-bound i)
(lower-bound i)
(center i)
(width i)
(percent i)
