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

(define source '((a 1) (b 2) (c 4) (d 8) (e 16)))
(define tree (generate-huffman-tree source))

(define text '(a))
(define encoded-text (encode text tree))
(length encoded-text)
encoded-text

; e (0) -- 1
; d (1 0) -- 2
; c (1 1 0) -- 3
; b (1 1 1 0) -- 4
; a (1 1 1 1) -- 4

(define source '((a 1) (b 2) (c 4) (d 8) (e 16)
                 (f 32) (g 64) (h 128) (i 256) (j 512)))
(define tree (generate-huffman-tree source))

(define text '(i))
(define encoded-text (encode text tree))
(length encoded-text)
encoded-text

; j (0) -- 1
; i (1 0) -- 2
; h (1 1 0) -- 3
; g (1 1 1 0) -- 4
; f (1 1 1 1 0) -- 5
; e (1 1 1 1 1 0) -- 6
; d (1 1 1 1 1 1 0) -- 7
; c (1 1 1 1 1 1 1 0) -- 8
; b (1 1 1 1 1 1 1 1 0) -- 9
; a (1 1 1 1 1 1 1 1 1) -- 9
