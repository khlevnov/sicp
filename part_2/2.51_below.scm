#lang scheme
(#%require sicp-pict)

(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
        (let ((m (frame-coord-map frame)))
            (let ((new-origin (m origin)))
                (painter
                    (make-frame new-origin
                         (vector-sub (m corner1) new-origin)
                         (vector-sub (m corner2) new-origin)))))))

(define (beside painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let ((paint-left (transform-painter painter1
                    (make-vect 0.0 0.0)
                    split-point
                    (make-vect 0.0 1.0)))
              (paint-right (transform-painter painter2
                    split-point
                    (make-vect 1.0 0.0)
                    (make-vect 0.5 1.0))))
            (lambda (frame)
                (paint-left frame)
                (paint-right frame)))))

(define (below-like-beside painter1 painter2)
    (let ((split-point (make-vect 0.0 0.5)))
        (let ((paint-bottom (transform-painter painter1
                    (make-vect 0.0 0.0)
                    (make-vect 1.0 0.0)
                    split-point))
              (paint-top (transform-painter painter2
                    split-point
                    (make-vect 1.0 0.5)
                    (make-vect 0.0 1.0))))
            (lambda (frame)
                (paint-bottom frame)
                (paint-top frame)))))

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

(define (below painter1 painter2)
    (define (rotate-90 painter)
        (transform-painter painter
            (make-vect 0.0 1.0)
            (make-vect 0.0 0.0)
            (make-vect 1.0 1.0)))
    (define (rotate90 painter)
        (transform-painter painter
            (make-vect 1.0 0.0)
            (make-vect 1.0 1.0)
            (make-vect 0.0 0.0)))
    (rotate90 (beside (rotate-90 painter1) (rotate-90 painter2))))

(paint (below dog dog))
