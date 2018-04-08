(define sample-tree
    (make-code-tree (make-leaf 'A 4)
        (make-code-tree (make-leaf 'B 2)
            (make-code-tree (make-leaf 'D 1)
                            (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define (leaf? object)
    (eq? (car object) 'leaf))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))

(define (encode-symbol symbol tree)
    (let ((left-subtree (left-branch tree))
          (right-subtree (right-branch tree)))
        (cond ((leaf? tree) '())
              ((list? (memq symbol (symbols left-subtree)))
                    (cons '0 (encode-symbol symbol left-subtree)))
              ((list? (memq symbol (symbols right-subtree)))
                    (cons '1 (encode-symbol symbol right-subtree)))
              (else (error "Symbol doesn't exist" bit)))))

(define (encode message tree)
    (if (null? message)
        '()
        (append (encode-symbol (car message) tree)
    (encode (cdr message) tree))))

(encode '(a d a b b c a) sample-tree)
