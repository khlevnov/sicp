#lang sicp
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

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (beside (below (flip-vert (flip-horiz quarter)) (flip-horiz quarter))
            (below (flip-vert quarter) quarter))))

(paint (square-limit einstein 2))
