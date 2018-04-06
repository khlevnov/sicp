(define (entry tree) (car tree))

(define (lookup-tree given-key db)
    (cond ((null? db) false)
          ((= given-key (key (entry db))) true)
          ((< given-key (key (entry db))) (lookup-tree given-key (left-branch db)))
          ((> given-key (key (entry db))) (lookup-tree given-key (right-branch db)))))
