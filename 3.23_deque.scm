(define (new-node value)
    (let ((prev '())
          (next '()))
        (define (dispatch m)
            (cond
                ((eq? m 'prev) prev)
                ((eq? m 'next) next)
                ((eq? m 'set-prev!) (lambda (x) (set! prev x)))
                ((eq? m 'set-next!) (lambda (x) (set! next x)))
                ((eq? m 'value) value)
                (else
                    (error "Failed to dispatch undefined message" m))))
        dispatch))

(define (new-deque)
    (let ((dummy (new-node 'dummy)))
        (define (empty?)
            (eq? (dummy 'next) dummy))
        (define (debug)
            (define items '())
            (define (collect x)
                (if (eq? x dummy)
                    items
                    (begin
                        (set! items (cons (x 'value) items))
                        (collect (x 'next)))))
            (collect (dummy 'next)))
        (define (insert-front! value)
            (let ((new-head (new-node value))
                  (prev-head (dummy 'next)))
                ((dummy 'set-next!) new-head)
                ((new-head 'set-next!) prev-head)
                ((prev-head 'set-prev!) new-head)
                ((new-head 'set-prev!) dummy)
                dispatch))
        (define (delete-front!)
            (let ((next-head ((dummy 'next) 'next)))
                ((dummy 'set-next!) next-head)
                ((next-head 'set-prev!) dummy)
                dispatch))
        (define (insert-back! value)
            (let ((new-tail (new-node value))
                  (prev-tail (dummy 'prev)))
                ((dummy 'set-prev!) new-tail)
                ((new-tail 'set-prev!) prev-tail)
                ((prev-tail 'set-next!) new-tail)
                ((new-tail 'set-next!) dummy)
                dispatch))
        (define (delete-back!)
            (let ((prev-tail ((dummy 'prev) 'prev)))
                ((dummy 'set-prev!) prev-tail)
                ((prev-tail 'set-next!) dummy)
                dispatch))
        (define (front)
            (if (empty?)
                (error "Failed to get front item from empty deque")
                ((dummy 'next) 'value)))
        (define (back)
            (if (empty?)
                (error "Failed to get back item from empty deque")
                ((dummy 'prev) 'value)))
        (define (dispatch m)
            (cond
                ((eq? m 'empty?) (empty?))
                ((eq? m 'dummy) dummy)
                ((eq? m 'front) (front))
                ((eq? m 'back) (back))
                ((eq? m 'delete-front!) delete-front!)
                ((eq? m 'insert-front!) insert-front!)
                ((eq? m 'delete-front!) delete-front!)
                ((eq? m 'insert-back!) insert-back!)
                ((eq? m 'delete-back!) delete-back!)
                ((eq? m 'debug) (debug))
                (else
                    (error "Failed to dispatch undefined message" m))))
        ((dummy 'set-prev!) dummy)
        ((dummy 'set-next!) dummy)
        dispatch))

(define d (new-deque))
(d 'empty?)
((d 'insert-front!) 1)
((d 'insert-front!) 2)
((d 'insert-front!) 3)
((d 'insert-back!) 4)
((d 'insert-back!) 5)
((d 'insert-back!) 6)
((d 'delete-front!))
((d 'insert-front!) 7)
((d 'delete-back!))
((d 'insert-back!) 8)
(d 'empty?)
(d 'debug)
(d 'front)
(d 'back)
