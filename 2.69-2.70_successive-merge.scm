(define (weight-leaf x) (caddr x))

(define (weight tree)
    (if (leaf? tree)
        (weight-leaf tree)
        (cadddr tree)))

(define (leaf? object)
    (eq? (car object) 'leaf))

(define (adjoin-set x set)
    (cond ((null? set) (list x))
          ((< (weight x) (weight (car set))) (cons x set))
          (else (cons (car set)
                (adjoin-set x (cdr set))))))

(define (make-leaf symbol weight)
    (list 'leaf symbol weight))

(define (make-leaf-set pairs)
    (if (null? pairs)
        '()
        (let ((pair (car pairs)))
             (adjoin-set (make-leaf (car pair) (cadr pair))
                         (make-leaf-set (cdr pairs))))))

(define (symbol-leaf x) (cadr x))

(define (symbols tree)
    (if (leaf? tree)
        (list (symbol-leaf tree))
        (caddr tree)))

(define (make-code-tree left right)
    (list left
          right
          (append (symbols left) (symbols right))
          (+ (weight left) (weight right))))

(define (generate-huffman-tree pairs)
    (define (successive-merge pairs)
        (if (= (length pairs) 1)
            (car pairs)
            (successive-merge (cons (make-code-tree (cadr pairs)
                                                    (car pairs))
                                    (cddr pairs)))))
    (successive-merge (make-leaf-set pairs)))

(define source '((A 2) (NA 16)
                 (BOOM 1) (SHA 3)
                 (GET 2) (YIP 9)
                 (JOB 2) (WAH 1)))
(define tree (generate-huffman-tree source))

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

(define text '(
    Get a job
    Sha na na na na na na na na
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip yip yip yip yip yip
    Sha boom
))
(define encoded-text (encode text tree))

(* (length text) 8)
(length encoded-text)
