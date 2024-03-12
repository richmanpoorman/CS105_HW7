

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
;; Unit Tests
        (check-expect ([@ drop (forall ['a] (list 'a))] 
                            1 [@ '() (forall ['a] (list 'a))]) 
                            [@ '() (forall ['a] (list 'a))])

        (check-expect ([@ drop int] 1 '(1 2 3)) '(2 3))
        (check-expect ([@ drop int] 2 '(1 2 3)) '(3))
        (check-type ([@ drop int] 3 '(1 2 3)) (list int))
        (check-type ([@ drop bool] 3 '(#t #f #f #t)) (list bool))

        (check-type-error ([@ drop bool] 3 '(1 2 3)))
        (check-type-error ([@ drop int] 3 '(#t 1 2 3)))


;;
;; Take while
;;

;; (takewhile p? xs) Given a predicate p? that works on every element of the 
;; given list, and a list of elements xs, returns the largest prefix of xs 
;; in which every element satisfies p? 
;;      (forall ['a] (('a -> bool) (list 'a) -> (list 'a)) )

;; Laws:
;;      (takewhile p? '()) = '()
;;      (takewhile p? (cons y ys)) = (cons y (takewhile p? ys)) if (p? y)
;;      (takewhile p? (cons y ys)) = '() if (not (p? y))

(val takewhile 
    (type-lambda ['a] 
        (letrec 
            [([takewhile-mono : (('a -> bool) (list 'a) -> (list 'a))]
                (lambda ([p? : ('a -> bool)] [xs : (list 'a)]) 
                    (if ([@ null? 'a] xs) 
                        [@ '() 'a]
                        (if (p? ([@ car 'a] xs))
                            ([@ cons 'a] ([@ car 'a] xs) (takewhile-mono p? 
                                                            ([@ cdr 'a] xs)))
                            [@ '() 'a] ))))]
            takewhile-mono)))

;; Unit tests 
        (check-type takewhile (forall ['a] (('a -> bool) (list 'a) -> 
                                                (list 'a)) ))
        (check-expect 
            ([@ takewhile (list bool)]
                (lambda ([xs : (list bool)]) ([@ car bool] xs))
                [@ '() (list bool)])
            [@ '() (list bool)])
        (check-expect 
            ([@ takewhile int] 
                (lambda ([x : int]) (< x 10))
                '(1 2 3 4 5 6 7 8 9))
            '(1 2 3 4 5 6 7 8 9))
        (check-expect 
            ([@ takewhile (list int)]
                (lambda ([xs : (list int)]) (< ([@ car int] xs) 10))
                '((10 11) (1 2 3) (16) (9 8 7 6 5)))
            [@ '() (list int)])
        (check-expect 
            ([@ takewhile bool] 
                (lambda ([x : bool]) x)
                '(#t #t #t #f #t #t #f #f))
            '(#t #t #t))
        (check-type-error 
            ([@ takewhile int] 
                (lambda ([x : bool]) x)
                '(#t #t #t #f #t #t #f #f)))
        (check-type-error 
            ([@ takewhile bool] 
                (lambda ([x : int]) (< x 10))
                '(#t #t #t #f #t #t #f #f)))
        (check-type-error 
            ([@ takewhile bool] 
                (lambda ([x : bool]) x)
                '(1 2 3 4 5 6 7 8 9)))
        (check-type 
            [@ takewhile (forall ['a 'b] (list 'a))]
            (((forall ['a 'b] (list 'a)) -> bool) 
                (list (forall ['a 'b] (list 'a))) 
                -> (list (forall ['a 'b] (list 'a)))))