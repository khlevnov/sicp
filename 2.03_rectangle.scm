(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-segment start end) (cons start end))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (x-start s) (x-point (start-segment s)))
(define (y-start s) (y-point (start-segment s)))
(define (x-end s) (x-point (end-segment s)))
(define (y-end s) (y-point (end-segment s)))

(define (length s)
    (sqrt (+ (square (- (x-end s) (x-start s)))
             (square (- (y-end s) (y-start s))))))

(define (perpendicular? s1 s2)
    (define (parallel-side-transfer s1 s2)
        (make-segment (start-segment s2)
                      (make-point (- (x-end s1)
                                     (- (x-start s1)
                                        (x-start s2)))
                                  (- (y-end s1)
                                     (- (y-start s1)
                                        (y-start s2))))))
    (let ((s1 (parallel-side-transfer s1 s2))
          (tolerance 0.0001))
         (< (abs (- (+ (square (length s1)) (square (length s2)))
                       (square (length (make-segment (end-segment s1)
                                                     (end-segment s2))))))
            tolerance)))

(define (parallel? s1 s2)
    true)

(define (diagonals? s1 s2)
    true)

(define (make-angle-rectangle s1 s2) (cons s1 s2))
(define (start-side rectangle) (car rectangle))
(define (perpendicular-side rectangle) (cdr rectangle))

(define (rectangle-square rectangle)
    (let ((s1 (start-side rectangle))
          (s2 (perpendicular-side rectangle)))
         (if (perpendicular? s1 s2)
             (* (length s1) (length s2))
             0)))

(define (rectangle-perimeter rectangle)
    (let ((s1 (start-side rectangle))
          (s2 (perpendicular-side rectangle)))
         (if (perpendicular? s1 s2)
             (+ (* 2 (length s1)) (* 2 (length s2)))
             0)))

(define angle-rect (make-angle-rectangle
    (make-segment (make-point 1 1) (make-point 1 9))
    (make-segment (make-point 1 9) (make-point 4 9))))

(rectangle-square angle-rect)
(rectangle-perimeter angle-rect)
