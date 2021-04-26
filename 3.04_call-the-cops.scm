(define (call-the-cops)
  (display "Cops will be here soon"))

(define (make-account balance account-password)
  (define wrong-password-trials 0)
    
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
      (begin
        (set! wrong-password-trials (+ wrong-password-trials 1))
        (if (> wrong-password-trials 7)
          (call-the-cops))
        (lambda (amount) "Wrong password"))

      (begin
        (set! wrong-password-trials 0)
        (cond
          ((eq? message 'withdraw) withdraw)
          ((eq? message 'deposit) deposit)
          (else
            (error "Undefined message -- make-account:" message))))))
  dispatch)

(define acc (make-account 100 'strong-password))
((acc 'strong-password 'deposit) 40)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'strong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
((acc 'wrong-password 'withdraw) 50)
