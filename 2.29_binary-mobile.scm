(define (make-mobile left right)
    (list left right))

(define (make-branch length structure)
    (list length structure))

(define (left-branch mobile)
    (car mobile))

(define (right-branch mobile)
    (cadr mobile))

(define (branch-length branch)
    (car branch))

(define (branch-structure branch)
    (cadr branch))

(define (total-weight mobile)
    (if (pair? mobile)
        (+ (total-weight (branch-structure (left-branch mobile)))
           (total-weight (branch-structure (right-branch mobile))))
        mobile))

(define (balanced? mobile)
    (define (moment branch)
        (if (pair? (branch-structure branch))
            (* (branch-length branch) (total-weight (branch-structure branch)))
            (* (branch-length branch) (branch-structure branch))))
    (if (not (pair? mobile))
        true
        (and (balanced? (branch-structure (left-branch mobile)))
             (balanced? (branch-structure (right-branch mobile)))
             (= (moment (left-branch mobile))
                (moment (right-branch mobile))))))

(define imbalanced-mobile (make-mobile
    (make-branch 3 (make-mobile
        (make-branch 3 1)
        (make-branch 2 4)))
    (make-branch 2 (make-mobile
        (make-branch 3 (make-mobile
            (make-branch 3 (make-mobile
                (make-branch 3 (make-mobile
                    (make-branch 3 1)
                    (make-branch 2 4)))
                (make-branch 2 4)))
            (make-branch 2 4)))
        (make-branch 2 (make-mobile
            (make-branch 3 1)
            (make-branch 2 4)))))))

(define balanced-mobile (make-mobile
    (make-branch 4 (make-mobile
        (make-branch 2 6)
        (make-branch 4 3)))
    (make-branch 3 12)))

(balanced? balanced-mobile)
