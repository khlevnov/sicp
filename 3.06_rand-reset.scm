(define (make-rand seed)
  (define (rand-update x)
    (define a 7)
    (define c 7)
    (define m 10)
    (remainder (+ (* a x) c) m))

  (define (dispatch message)
    (cond
      ((eq? message 'generate)
        (begin
          (set! seed (rand-update seed))
          seed))
      ((eq? message 'reset)
        (lambda (initial-value)
          (set! seed initial-value)))
      (else
        (error "Undefined message" message))))
        
  dispatch)

(define rand (make-rand 0))
(rand 'generate)
(rand 'generate)
(rand 'generate)

((rand 'reset) 0)
(rand 'generate)
(rand 'generate)
(rand 'generate)
