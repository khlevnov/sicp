(define (make-interval a b)
    (cons a b))

(define (upper-bound interval)
    (max (car interval) (cdr interval)))

(define (lower-bound interval)
    (min (car interval) (cdr interval)))

(define (make-center-width center width)
    (make-interval (- center width) (+ center width)))

(define (center interval)
    (/ (+ (lower-bound interval) (upper-bound interval)) 2))

(define (width interval)
    (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (make-center-percent center percent)
    (let ((width (* center (/ percent 100.0))))
        (make-center-width center width)))

(define (percent interval)
    (* (/ (width interval) (center interval)) 100.0))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
        (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (upper-bound y))
        (- (upper-bound x) (lower-bound y))))

(define (div-interval x y)
    (mul-interval x
        (make-interval (/ 1.0 (upper-bound y))
             (/ 1.0 (lower-bound y)))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4) (max p1 p2 p3 p4))))

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2)
        (add-interval r1 r2)))

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval one
            (add-interval (div-interval one r1)
                (div-interval one r2)))))

(define i1 (make-center-percent 200 1))
(define i2 (make-center-percent 100 2))

; add-interval усредняет погрешность в сторону большего значения
(define (percent-of-add i1 i2)
    (let ((sum (+ (center i1) (center i2))))
        (+ (* (/ (center i1) sum) (percent i1))
           (* (/ (center i2) sum) (percent i2)))))

; mul-interval складывает погрешности
(define (percent-of-mul i1 i2)
    (+ (percent i1) (percent i2)))

; div-interval складывает погрешности
(define (percent-of-div i1 i2)
    (+ (percent i1) (percent i2)))

(center (sub-interval i1 i2))
(percent (sub-interval i1 i2))
;(percent-of-sub i1 i2)
