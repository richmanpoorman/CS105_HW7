

;; (drop) 
;; given a natural number n and a list of values xs, returns xs without the 
;; first n elements (or the empty list if n is greater than the length of xs).

;; laws:

(val drop 
    (type-lambda ['a]
        (letrec [([drop-mono : (int (list 'a) -> (list 'a))]
            (lambda ([n : int] [xs : (list 'a)])
                (if ([@ null? 'a] xs)
                    [@ '() 'a]
                    (if (> n 0)
                        (drop-mono (- n 1) ([@ cdr 'a] xs))
                        xs))) )]
            drop-mono)))

(check-expect ([@ drop (forall ['a] (list 'a))] 
                    1 [@ '() (forall ['a] (list 'a))]) 
                    [@ '() (forall ['a] (list 'a))])

(check-expect ([@ drop int] 1 '(1 2 3)) '(2 3))
(check-expect ([@ drop int] 2 '(1 2 3)) '(3))
(check-type ([@ drop int] 3 '(1 2 3)) (list int))
(check-type ([@ drop bool] 3 '(#t #f #f #t)) (list bool))

(check-type-error ([@ drop bool] 3 '(1 2 3)))
(check-type-error ([@ drop int] 3 '(#t 1 2 3)))
