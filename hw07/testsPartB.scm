;; drop
(check-type drop (forall ['n 'a] (int (list 'a) -> (list 'a))))

;; takewhile
;; Is there something to check if of type func? 
(check-type takewhile (forall ['a 'b] ('a (list 'b) -> 'b)))