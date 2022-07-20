(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond
      ((= trials-remaining 0)
        (/ trials-passed trials))
      ((experiment)
        (iter (- trials-remaining 1) (+ trials-passed 1)))
      (else
        (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral p rect trials)
  (define (experiment)
    (let (
      (x1 (car rect))
      (y1 (car (cdr rect)))
      (x2 (car (cdr (cdr rect))))
      (y2 (car (cdr (cdr (cdr rect))))))
      (p
        (random-in-range x1 x2)
        (random-in-range y2 y1))))
  (monte-carlo trials experiment))

(define square-rect '(-1.0 1.0 1.0 -1.0))

(define (in-circle? x y)
  (< (+ (* x x) (* y y)) 1))

(* (estimate-integral in-circle? square-rect 10) 4.0)
(* (estimate-integral in-circle? square-rect 100) 4.0)
(* (estimate-integral in-circle? square-rect 1000) 4.0)
(* (estimate-integral in-circle? square-rect 10000) 4.0)
(* (estimate-integral in-circle? square-rect 100000) 4.0)
