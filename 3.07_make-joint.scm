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
          (error "Undefined message" message)))))

  dispatch)

(define peter-acc (make-account 100 'open-sesame))
((peter-acc 'open-sesame 'withdraw) 40)
((peter-acc 'something-else 'deposit) 50)

(define (make-joint account account-password joint-password)
  (define (dispatch user-password message)
    (if (not (eq? user-password joint-password))
      (error "Wrong password")
      (cond
        ((eq? message 'withdraw) (account account-password 'withdraw))
        ((eq? message 'deposit) (account account-password 'deposit))
        (else
          (error "Undefined message" message)))))
  dispatch)

(define paul-acc
  (make-joint peter-acc 'invalid-password 'rosebud))

((paul-acc 'rosebud 'withdraw) 40)

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

((paul-acc 'rosebud 'withdraw) 40)
((peter-acc 'open-sesame 'withdraw) 10)
