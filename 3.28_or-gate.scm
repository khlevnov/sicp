(define (logical-not s)
    (cond
        ((= s 0) 1)
        ((= s 1) 0)
        (else (error "wrong signal" s))))

(define (logical-and s1 s2)
    (cond
        ((not (or (= s1 0) (= s1 1))) (error "wrong signal" s1))
        ((not (or (= s2 0) (= s2 1))) (error "wrong signal" s2))
        ((and (= s1 1) (= s2 1)) 1)
        (else 0)))

(define (logical-or s1 s2)
    (cond
        ((not (or (= s1 0) (= s1 1))) (error "wrong signal" s1))
        ((not (or (= s2 0) (= s2 1))) (error "wrong signal" s2))
        ((or (= s1 1) (= s2 1)) 1)
        (else 0)))

(define (inverter input output)
    (define (callback)
        (let ((new-value (logical-not (get-signal input))))
            (after-delay
                inverter-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! input callback)
    'ok)

(define (and-gate input1 input2 output)
    (define (callback)
        (let ((new-value (logical-and (get-signal input1) (get-signal input2))))
            (after-delay
                and-gate-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! input1 callback)
    (add-action! input2 callback)
    'ok)

(define (or-gate input1 input2 output)
    (define (callback)
        (let ((new-value (logical-or (get-signal input1) (get-signal input2))))
            (after-delay
                and-gate-delay
                (lambda () (set-signal! output new-value)))))
    (add-action! input1 callback)
    (add-action! input2 callback)
    'ok)
