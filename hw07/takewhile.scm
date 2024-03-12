
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