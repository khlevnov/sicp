#lang sicp
(#%require sicp-pict)

(define (make-vect x y) (cons x y))
(define (xcor-vect v) (car v))
(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
    (cons (+ (xcor-vect v1) (xcor-vect v2))
          (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
    (cons (- (xcor-vect v1) (xcor-vect v2))
          (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v s)
    (cons (* (xcor-vect v) s)
          (* (ycor-vect v) s)))

(add-vect (make-vect 0 4)
          (make-vect 4 0))

(sub-vect (make-vect 0 4)
          (make-vect 4 0))

(scale-vect (make-vect 2 3) 2)
