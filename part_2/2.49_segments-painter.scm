#lang scheme
(#%require sicp-pict)

(define (right-split painter n)
  (if (= n 0)
      painter
      (beside painter
              (below (right-split painter (- n 1))
                     (right-split painter (- n 1))))))


(define (up-split painter n)
  (if (= n 0)
      painter
      (below painter
             (beside (up-split painter (- n 1))
                     (up-split painter (- n 1))))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define dog
    (segments->painter (list
        (make-segment (make-vect 0.11 0.5) (make-vect 0.1 0.53))
        (make-segment (make-vect 0.1 0.53) (make-vect 0.21 0.53))
        (make-segment (make-vect 0.21 0.53) (make-vect 0.22 0.56))
        (make-segment (make-vect 0.22 0.56) (make-vect 0.30 0.57))
        (make-segment (make-vect 0.30 0.57) (make-vect 0.33 0.68))
        (make-segment (make-vect 0.33 0.68) (make-vect 0.36 0.57))
        (make-segment (make-vect 0.36 0.57) (make-vect 0.42 0.47))
        (make-segment (make-vect 0.42 0.47) (make-vect 0.92 0.47))
        (make-segment (make-vect 0.92 0.47) (make-vect 1 0.27))
        (make-segment (make-vect 1 0.27) (make-vect 0.88 0.4))
        (make-segment (make-vect 0.88 0.4) (make-vect 0.92 0))
        (make-segment (make-vect 0.92 0) (make-vect 0.88 0))
        (make-segment (make-vect 0.88 0) (make-vect 0.84 0.3))
        (make-segment (make-vect 0.84 0.3) (make-vect 0.8 0))
        (make-segment (make-vect 0.8 0) (make-vect 0.76 0))
        (make-segment (make-vect 0.76 0) (make-vect 0.80 0.3))
        (make-segment (make-vect 0.8 0.3) (make-vect 0.5 0.3))
        (make-segment (make-vect 0.5 0.3) (make-vect 0.46 0))
        (make-segment (make-vect 0.46 0) (make-vect 0.42 0))
        (make-segment (make-vect 0.42 0) (make-vect 0.46 0.3))
        (make-segment (make-vect 0.46 0.3) (make-vect 0.42 0.3))
        (make-segment (make-vect 0.42 0.3) (make-vect 0.38 0))
        (make-segment (make-vect 0.38 0) (make-vect 0.34 0))
        (make-segment (make-vect 0.34 0) (make-vect 0.38 0.3))
        (make-segment (make-vect 0.38 0.3) (make-vect 0.28 0.4))
        (make-segment (make-vect 0.28 0.4) (make-vect 0.23 0.45))
        (make-segment (make-vect 0.23 0.45) (make-vect 0.11 0.5)))))

(paint dog)
(paint (corner-split dog 3))

(define square
    (segments->painter (list
        (make-segment (make-vect 0 0) (make-vect 0 1))
        (make-segment (make-vect 0 1) (make-vect 1 1))
        (make-segment (make-vect 1 1) (make-vect 1 0))
        (make-segment (make-vect 1 0) (make-vect 0 0)))))

(define x
    (segments->painter (list
        (make-segment (make-vect 0 0) (make-vect 1 1))
        (make-segment (make-vect 0 1) (make-vect 1 0)))))

(define rhombus
    (segments->painter (list
        (make-segment (make-vect 0 0.5) (make-vect 0.5 1))
        (make-segment (make-vect 0.5 1) (make-vect 1 0.5))
        (make-segment (make-vect 1 0.5) (make-vect 0.5 0))
        (make-segment (make-vect 0.5 0) (make-vect 0 0.5)))))

;(paint square)
;(paint x)
;(paint rhombus)
