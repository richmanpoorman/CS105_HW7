
;; Literal (extra) 
(check-type 'a sym)
(check-type 1 int)
(check-type #f bool)
(check-type '() (forall ['a] (list 'a)))
(check-type '(1 2 3 4) (list int))
(check-type '((#t #f) (#t #t) (#f)) (list (list bool)))


;; Var 
(val intVal (+ 1 2))
(val symVal 'a)
(val boolVal #t)
(val emptyVal '())
(val intVal1 1)
(val intVal2 2)
(val intListListVal '((1 2) (1 2 3) (1 2 3 4)))

(check-type intVal int)
(check-type symVal sym)
(check-type boolVal bool)
(check-type emptyVal (forall ['a] (list 'a)))
(check-type (+ intVal1 intVal2) int)
(check-type intListListVal (list (list int)))

(check-type-error )

;; Set 
(check-type (set intVal 10) int)
(check-type (set symVal 'b) sym)
(check-type (set boolVal #f) bool)
(check-type (set emptyVal '()) (forall ['a] (list 'a)))
(check-type (set intVal1 (set intVal2 (set intVal 9))) int)
(check-type (set intListListVal '((1 2 3)) ) (list (list int)))

;; While

;; Begin 

;; Let

;; Letstar 

;; Letrec

;; Lambda 

;; Tylambda
 
;; Tyapply

;;
;; TYPDEF TESTS 
;;

;; Val 

;; Valrec

;; Exp

;; Define
