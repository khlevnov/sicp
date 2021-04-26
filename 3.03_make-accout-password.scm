(define (make-account balance account-password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "You don't have enough money on your account"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch user-password message)
    (if (not (eq? user-password account-password))
      (error "Wrong password")
      (cond
        ((eq? message 'withdraw) withdraw)
        ((eq? message 'deposit) deposit)
        (else
          (error "Undefined message -- make-account:" message)))))
  dispatch)

(define acc (make-account 100 'right-password))
((acc 'right-password 'withdraw) 40)
((acc 'wrong-password 'deposit) 50)
