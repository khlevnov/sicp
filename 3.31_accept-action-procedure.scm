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

(define (make-wire)
    (let ((signal-value 0) (action-procedures '()))
        (define (set-my-signal! new-value)
            (if (not (= signal-value new-value))
                (begin
                    (set! signal-value new-value)
                    (call-each action-procedures))
                'done))
        (define (accept-action-procedure! proc)
            (set! action-procedures (cons proc action-procedures))
            (proc))
        (define (dispatch m)
            (cond
                ((eq? m 'get-signal) signal-value)
                ((eq? m 'set-signal!) set-my-signal!)
                ((eq? m 'add-action!) accept-action-procedure!)
                (else (error "Undefined operation -- WIRE" m))))
        dispatch))

(define (call-each procedures)
    (if (null? procedures)
        'done
        (begin
            ((car procedures))
            (call-each (cdr procedures)))))

(define (get-signal wire)
    (wire 'get-signal))

(define (set-signal! wire new-value)
    ((wire 'set-signal!) new-value))

(define (add-action! wire action-procedure)
    ((wire 'add-action!) action-procedure))

(define (after-delay delay action)
    (add-to-agenda!
        (+ delay (current-time the-agenda))
        action
        the-agenda))

(define (propagate)
    (if (empty-agenda? the-agenda)
        'done
        (let ((first-item (first-agenda-item the-agenda)))
            (first-item)
            (remove-first-agenda-item! the-agenda)
            (propagate))))

(define (probe name wire)
    (add-action!
        wire
        (lambda ()
            (newline)
            (display name)
            (display " ")
            (display (current-time the-agenda))
            (display " New-value = ")
            (display (get-signal wire)))))

; Agenda definitions, TODO

(define (make-agenda)
    'foo)

(define (empty-agenda? agenda)
    'foo)

(define (first-agenda-item agenda)
    'foo)

(define (remove-first-agenda-item! agenda)
    'foo)

(define (add-to-agenda! time action agenda)
    'foo)

(define (current-time agenda)
    'foo)

; Plan!

(define (half-adder a b s c)
    (let ((d (make-wire)) (e (make-wire)))
        (or-gate a b d)
        (and-gate a b c)
        (inverter c e)
        (and-gate d e s)
        'ok))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)
(propagate)

(set-signal! input-2 1)
(propagate)

; with (proc) call
; input-1 = 0, nothing updated
; input-2 = 0, nothing updated
; d = 0, nothing updated
; e = 0, nothing updated
; c = 0
    ; update e = 1 immediate
; s = 0, nothing updated
; end of prepare stage

; set input-1 = 1
    ; update d = 1 in 5 time
        ; update s = 1 in 8 time, probe called
; set input-2 = 1
    ; update c = 1 in 11 time, probe called
        ; update e = 0 in 13 time
            ; update s = 0 in 16 time, probe called


; without (proc) call
; input-1 = 0, nothing updated
; input-2 = 0, nothing updated
; d = 0, nothing updated
; e = 0, nothing updated
; c = 0, nothing updated
; s = 0, nothing updated
; end of prepare stage

; set input-1 = 1
    ; update d = 1 in 5 time
        ; while e is 0, s should not be updated
; set input-2 = 1
    ; update c = 1 in 8 time, probe called
        ; while e is 0, e should not be updated
