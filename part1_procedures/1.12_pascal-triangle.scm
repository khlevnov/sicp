(define (pascal row column)
    (cond ((< row 2) 1)
          ((< column 2) 1)
          ((= column row) 1)
          (else (+
            (pascal (- row 1) (- column 1))
            (pascal (- row 1) column)
          ))
    )
)

(pascal 3 2)
