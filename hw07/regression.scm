
;; 
;; TYPEOF TESTS
;;

;; step 5

    ;; Literal
(check-type 3 int)
(check-type #t bool)
(check-type 'hello sym)

;; step 6

    ;; If 
(check-type 
    (if #t 
        'hi
        'bye)
    sym)
(check-type 
    (if (if #t #f #t)
        1 
        2)
    int)
(check-type 
    (if #t 
        (if #f #f #t)
        #t )
    bool)
(check-type 
    (if #f 
        '(1 2 3)
        (if #t '(1 2) '(2 3 4)))
    (list int))
(check-type-error (if 0 #t #t))
(check-type-error (if #t 1 'a))
(check-type-error 
    (if #f 
        (if #f 1 2)
        (if #t 'a 'b)))
(check-type-error
    (if #t 
        (if #t 'a 1)
        'b))

;; step 7
    ;; Var
(check-type + (int int -> int))
(check-type / (int int -> int))
(check-type or (bool bool -> bool))
(check-type-error class-105)

;; step 9
    ;; Val
(val intVal 1)
(val boolVal #t)
(val symVal 'a)
(val listVal '(1 2 3))
(check-type intVal int)
(check-type symVal sym)
(check-type listVal (list int))
(check-type-error (val v (if 1 2 3)))
(check-type-error (val u (if #f 'a 1)))

;; step 10 
    ;; Apply
(check-type (+ 1 2) int)
(check-type (+ (+ 1 2) (+ 1 2)) int)
(check-type (or #f (and #t #t)) bool)
(check-type-error (+ 'a 1))
(check-type-error (+ (+ 1 2) (+ 'a 1)))
(check-type-error (or #t 2))

;; step 11 
    ;; Let
(check-type (let ([x : int] [y : int]) (+ x y)) int)
(check-type (let ([x : bool] [y : bool]) (if y x y)) bool)
(check-type-error (let ([x : int] [y : bool]) (or x y)))
(check-type-error (let ([x : int] [y : bool]) (+ x y)))

;; step 12
    ;; Lambda
    ;; (lambda ([x1 : tyex1] … [xn : tyexn]) e)
(check-type (lambda ([x : int] [y : int]) (+ x y)) int)
;; (check-type (lambda ([x : bool] [y : bool]) (or x y)) bool)
(check-type-error (lambda ([x : bool] [y : int]) (+ x y)))
;; (check-type-error (lambda ([x : bool] [y : int]) (or x y)))

;; step 13 
    ;; Set
(check-type (set x 1) int)
(check-type (set (x #t)) bool)
(check-type-error (set x 1))
(check-type-error (set (x #t)))

;; step 13 
    ;; While
(val x 1)
(val y 1)
(val boolX #t)
(val boolY #f)
(check-type (while (= x 1) (+ x y)) unit)
;; (check-type (while (boolX) (or boolX boolY)) unit)
(check-type-error (while (= boolX 1) (+ x y)))
(check-type-error (while (boolX) (+ x y)))
;; (check-type-error (while (= x y) (or x y)))

;; step 13 
    ;; Begin
(check-type (begin ()) unit) ;; empty begin has type unit
(check-type (begin (set x 1) (set y 1) (+ x y)) int)
;; (check-type (begin (set x #f) (set y #t) (or x y)) bool)
(check-type-error (begin (set x 1) (set y #t) (+ x y)))
;; (check-type-error (begin (set x #f) (set y 1) (or x y)))


;; step 14 
    ;; Let STAR!
(check-type (let* ([x : int] [y : int]) (+ x y)) int)
(check-type (let* ([x : bool] [y : bool]) (if y x y)) bool)
;; (check-type-error (let* ([x : int] [y : bool]) (or x y)))
(check-type-error (let* ([x : int] [y : bool]) (+ x y)))

;; step 15
    ;; LetRec
    ;; (letrec [([x1 : tyex1] e1)
    ;;      … 
    ;;      ([xn : tyexn] en)] e)
(check-type (letrec ([x : int] [y : int]) (+ x y)) int)
(check-type (letrec ([x : bool] [y : bool]) (if y x y)) bool)
;; (check-type-error (letrec ([x : int] [y : bool]) (or x y)))
(check-type-error (letrec ([x : int] [y : bool]) (+ x y)))

;; step 16
    ;; ValRec
    ;; (val-rec [x : tyex] e)
(val-rec intVal 1)
(val-rec boolVal #t)
(val-rec symVal 'a)
(val-rec listVal '(1 2 3))
(check-type intVal int)
(check-type symVal sym)
(check-type listVal (list int))
(check-type-error (val-rec v (if 1 2 3)))
(check-type-error (val-rec u (if #f 'a 1)))

;; step 16
    ;; Define
    ;; (define tyex f ([x1 : tyex1] … [xn : tyexn]) e)
(check-type (define int f ([x : int] [y : int]) + x y) int)
;; (check-type (define bool f ([x : bool] [y : bool]) or x y) bool)
;; (check-type-error (define bool f ([x : bool] [y : int]) or x y))
(check-type-error (define bool f ([x : bool] [y : int]) + x y))


;; step 17
    ;; TyApply

;; step 17
    ;; TyLambda
