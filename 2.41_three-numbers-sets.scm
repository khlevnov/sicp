(define (generate-threes n sum)
    (define (flatmap f sequence)
        (fold-right append '() (map f sequence)))

    (define (enumerate-threes n)
        (define (enumerate n)
            (define (iter result n)
                (if (= n 0)
                    result
                    (iter (cons n result) (- n 1))))
            (iter '() n))

        (flatmap
            (lambda (third)
                (flatmap
                    (lambda (second)
                        (map (lambda (first)
                            (list first second third))
                            (enumerate (- second 1))))
                    (enumerate (- third 1))))
            (enumerate n)))

    (define (three-sum three)
        (+ (car three) (cadr three) (caddr three)))

    (filter
        (lambda (three) (= (three-sum three) sum))
        (enumerate-threes n)))

(generate-threes 6 9)
