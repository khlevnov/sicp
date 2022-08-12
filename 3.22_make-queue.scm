(define (make-queue)
    (define queue (cons '() '()))
    (define (front-ptr) (car queue))
    (define (rear-ptr) (cdr queue))
    (define (set-front-ptr! item) (set-car! queue item))
    (define (set-rear-ptr! item) (set-cdr! queue item))
    (define (empty?) (null? (front-ptr)))
    (define (front)
        (if (empty?)
            (error "Failed to take front element: queue is empty" queue))
            (car (front-ptr)))
    (define (insert! item)
        (let ((new-pair (cons item '())))
            (cond
                ((empty?)
                    (set-front-ptr! new-pair)
                    (set-rear-ptr! new-pair)
                    queue)
                (else
                    (set-cdr! (rear-ptr) new-pair)
                    (set-rear-ptr! new-pair)
                    queue))))
    (define (delete!)
        (cond
            ((empty?)
                (error "Failed to delete from queue: queue is empty"))
            (else
                (set-front-ptr! (cdr (front-ptr)))
                queue)))
    (define (print)
        (front-ptr))
    (define (dispatch m)
        (cond
            ((eq? m 'front) front)
            ((eq? m 'insert) insert!)
            ((eq? m 'delete) delete!)
            ((eq? m 'print) print)
            (else
                (error "Failed to send message:" m))))
    dispatch)

(define q1 (make-queue))
((q1 'insert) 'a)
((q1 'print))
((q1 'insert) 'b)
((q1 'print))
((q1 'delete))
((q1 'print))
((q1 'delete))
((q1 'print))


; Simplify it!

(define (make-queue)
    (let ((front-ptr '())
          (rear-ptr '()))
        (define (empty?)
            (null? front-ptr))
        (define (front)
            (if (empty?)
                (error "Failed to take front element: queue is empty" queue))
                (car front-ptr))
        (define (insert! item)
            (let ((new-pair (cons item '())))
                (cond
                    ((empty?)
                        (set! front-ptr new-pair)
                        (set! rear-ptr new-pair)
                        dispatch)
                    (else
                        (set-cdr! rear-ptr new-pair)
                        (set! rear-ptr new-pair)
                        dispatch))))
        (define (delete!)
            (cond
                ((empty?)
                    (error "Failed to delete from queue: queue is empty"))
                (else
                    (set! front-ptr (cdr front-ptr))
                    dispatch)))
        (define (print)
            front-ptr)
        (define (dispatch m)
            (cond
                ((eq? m 'front) front)
                ((eq? m 'insert) insert!)
                ((eq? m 'delete) delete!)
                ((eq? m 'print) print)
                (else
                    (error "Failed to send message:" m))))
        dispatch))

(define q1 (make-queue))
((q1 'insert) 'a)
((q1 'print))
((q1 'insert) 'b)
((q1 'print))
((q1 'delete))
((q1 'print))
((q1 'delete))
((q1 'print))
