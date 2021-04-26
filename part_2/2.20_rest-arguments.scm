(define (reverse items)
    (define (tail items)
        (if (null? (cdr items))
            (cdr items)
            (cons (car items) (tail (cdr items)))))

    (define (last-item items)
        (let ((tail (cdr items)))
            (if (null? tail)
                (car items)
                (last-item tail))))

    (if (null? (tail items))
        items
        (cons (last-item items) (reverse (tail items)))))

(define (same-parity first-number . numbers)
    (define (append same-parity-list number numbers)
        (if (null? numbers)
            (reverse (if (same-parity? number)
                        (cons number same-parity-list)
                        same-parity-list))
            (append
                (if (same-parity? number)
                    (cons number same-parity-list)
                    same-parity-list)
                (car numbers)
                (cdr numbers))))

    (define (same-parity? number)
        (let ((first-number-odd (= (remainder first-number 2) 1))
            (number-odd (= (remainder number 2) 1)))
            (or (and first-number-odd number-odd)
                (and (not first-number-odd) (not number-odd)))))

    (append (list first-number) (car numbers) numbers))

(same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
(same-parity 2 3 4 5 6 7)
; (2 4 6)
