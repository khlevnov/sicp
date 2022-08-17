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
    (let ((a (make-wire)) (b (make-wire)) (c (make-wire)))
        (inverter input1 a)
        (inverter input2 b)
        (and-gate a b c)
        (inverter c output)
        'ok))

(define (half-adder a b s c)
    (let ((d (make-wire)) (e (make-wire)))
        (or-gate a b d)
        (and-gate a b c)
        (inverter c e)
        (and-gate d e s)
        'ok))

(define (full-adder a b c-in sum c-out)
    (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
        (half-adder b c-in s c1)
        (half-adder a s sum c2)
        (or-gate c1 c2 c-out)
        'ok))

(define (riple-carry-adder a b s c)
    (if (not (null? a))
        (let ((carry (make-wire)))
            (full-adder (car a) (car b) carry s c)
            (riple-carry-adder (cdr a) (cdr b) (cdr s) carry))))
