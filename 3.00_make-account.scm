(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "You don't have enough money on your account"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch message)
    (cond
      ((eq? message 'withdraw) withdraw)
      ((eq? message 'deposit) deposit)
      (else
        (error "Undefined message -- make-account:" message))))
  dispatch)

(define acc (make-account 100))
((acc 'wrong-message) 60)
((acc 'withdraw) 50)
((acc 'withdraw) 60)
((acc 'deposit) 40)
((acc 'withdraw) 60)
