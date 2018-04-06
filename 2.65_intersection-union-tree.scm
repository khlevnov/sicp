(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
    (list entry left right))

(define (list->tree elements)
    (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
    (if (= n 0)
        (cons '() elts) ; for leaves, that equals nil
        (let ((left-size (quotient (- n 1) 2))) ; size of left subtree
            (let ((left-result (partial-tree elts left-size)))
                (let ((left-tree (car left-result)) ; left subtree
                      (non-left-elts (cdr left-result)) ; rest elements of list
                      (right-size (- n (+ left-size 1)))) ; size of right subtree
                     (let ((this-entry (car non-left-elts)) ; root of tree
                           (right-result (partial-tree (cdr non-left-elts) right-size)))
                          (let ((right-tree (car right-result))
                                (remaining-elts (cdr right-result)))
                               (cons (make-tree this-entry left-tree right-tree)
                                     remaining-elts))))))))

(define (tree->list tree)
    (if (null? tree)
        '()
        (append (tree->list (left-branch tree))
                (cons (entry tree)
                      (tree->list (right-branch tree))))))

(define (union-set set1 set2)
    (cond ((null? set1) set2)
          ((null? set2) set1)
          ((= (car set1) (car set2))
                (cons (car set1) (union-set (cdr set1) (cdr set2))))
          ((< (car set1) (car set2))
                (cons (car set1) (union-set (cdr set1) set2)))
          ((> (car set1) (car set2))
                (cons (car set2) (union-set set1 (cdr set2))))))

(define (intersection-set set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
             (cond ((= x1 x2) (cons x1 (intersection-set (cdr set1) (cdr set2))))
                   ((< x1 x2) (intersection-set (cdr set1) set2))
                   ((< x2 x1) (intersection-set set1 (cdr set2)))))))

(define (intersection-tree-set set1 set2)
    (list->tree (intersection-set (tree->list set1)
                                  (tree->list set2))))

(define (union-tree-set set1 set2)
    (list->tree (union-set (tree->list set1)
                           (tree->list set2))))



(union-tree-set '(1 () (4 () ())) '(3 (2 () ()) ()))
(intersection-tree-set '(1 () ()) '(3 (1 () ()) (2 () ())))
