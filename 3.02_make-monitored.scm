(define (make-monitored wrappee)
  (define calls-count 0)
  (lambda (arg)
    (cond
      ((eq? arg 'how-many-calls?) calls-count)
      ((eq? arg 'reset-count)
        (begin
          (set! calls-count 0)
          calls-count))
      (else
        (begin
          (set! calls-count (+ calls-count 1))
          (wrappee arg))))))

(define square-monitored (make-monitored square))
(square-monitored 1)
(square-monitored 2)
(square-monitored 3)
(square-monitored 'how-many-calls?)
(square-monitored 4)
(square-monitored 'how-many-calls?)
(square-monitored 'reset-count)
(square-monitored 5)
(square-monitored 6)
(square-monitored 'how-many-calls?)
