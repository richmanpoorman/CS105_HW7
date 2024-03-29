
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
;; (check-type or (bool bool -> bool))
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
;; (check-type (or #f (and #t #t)) bool)
(check-type-error (+ 'a 1))
(check-type-error (+ (+ 1 2) (+ 'a 1)))
(check-type-error (1 2 3))
;; (check-type-error (or #t 2))

;; step 11 
    ;; Let
(check-type (let ((x 1) (y 2)) (+ x y)) int)
(check-type (let ((x #t) (y #f)) (if y x y)) bool)
;; (check-type-error (let ([x : int] [y : bool]) (or x y)))
(check-type-error (let ((x #t) (y #f))  (+ x y)))
(check-type-error (let ((x 1) (y x)) x))

(check-type (let* ((x 1) (y x) (z y)) (* z y)) int)
(check-type (let* ((x (if #t #f #f)) (y x)) y) bool)
(check-type-error (let* ((x (if 1 2 3))) x))
(check-type-error (let* ((x y) (y 1)) x))

;; step 12
    ;; Lambda
    ;; (lambda ([x1 : tyex1] … [xn : tyexn]) e)
(check-type (lambda ([x : int] [y : int]) (+ x y)) (int int -> int))
(check-type (lambda ([x : int] [y : bool]) x) (int bool -> int))
(check-type (lambda ([x : bool] [y : bool]) (if x y y)) (bool bool -> bool))
(check-type (lambda ([x : bool] [y : int] [z : int]) 
                (if x y z)) (bool int int -> int))
(check-type-error (lambda ([x : int] [y : bool]) (if x y y)))
(check-type-error (lambda ([x : int] [y : bool]) (+ x y y)))
;; ;; step 13 
;;     ;; Set
(check-type (lambda ([x : int]) (set x 1)) (int -> int))
(check-type (lambda ([y : bool]) (set y #t)) (bool -> bool))
(check-type-error (lambda ([x : bool]) (set x 1)))
(check-type-error (lambda ([x : int]) (set x #t)))

;; while
(val whileX 1)
(val whileY 1)
(val whileX1 #t)
(val whileY1 #t)
(check-type (while (> 1 1) (+ 1 1)) unit)
(check-type (while whileX1 (+ 1 1)) unit)
(check-type-error  (while (> #t 1) (+ 1 1)))

;;begin
(val setX 1)
(val setY 1)
(check-type (begin (set setX 1) (set setY 1) (+ setX setY)) int)

(val setX1 #t)
(val setY1 #t)
(check-type (begin (set setX1 #f) (set setY1 #t) (> 1 1)) bool)

(set setX1 #t)
(set setY1 #t)
(check-type-error (begin (set setX1 #f) (set setY1 1) (> 1 1)))


;; step 14 
    ;; Let STAR!
(check-type (let* ((x 1) (y 2)) (+ x y)) int)
(check-type (let* ((x #t) (y #f)) (if y x y)) bool)
;; (check-type-error (let* ([x : int] [y : bool]) (or x y)))
(check-type-error (let* ((x #t) (y #f))  (+ x y)))

;; step 15
;;     LetRec
;;     (letrec [([x1 : tyex1] e1)
;;          … 
;;          ([xn : tyexn] en)] e)
(check-type (letrec 
                [([y : (int -> int)] 
                    (lambda ([x : int]) (+ x 1)))] 
                        (y 1)) int)

;; step 16
    ;; ValRec
    ;; (val-rec [x : tyex] e)
(val-rec [a : (int -> int)] (lambda ([b : int]) (set b 1)))
(check-type a (int -> int))

(val-rec [c : (bool -> bool)] (lambda ([b : bool]) (set b #t)))
(check-type c (bool -> bool))

;; step 16
    ;; Define
    ;; (define tyex f ([x1 : tyex1] … [xn : tyexn]) e)
(define unit func1 ([b : bool] [n : int]) (while b (+ n 1)))
(check-type (func1 #t 1) unit)

(define int func2 ([x : int] [n : int]) (+ n x))
(check-type (func2 1 2) int)
(check-type-error (func2 1 #t))

;; step 17
    ;; TyApply
(val id (type-lambda ['a] (lambda ([n : 'a]) n)))
(check-type ([@ id int] 3) int)
(check-type ([@ id bool] #t) bool)
(check-type ([@ null? bool] '(#t #f #f)) bool)
(check-type-error ([@ null? 'a] '(#t 1 #f)))
(check-type-error ([@ null? bool] '(1 #f #f)))

(val curry 
  (type-lambda ['a 'b 'c]
   (lambda ([f : ('a 'b -> 'c)])
     (lambda ([x : 'a]) 
       (lambda ([y : 'b]) (f x y))))))
(check-type ([@ curry int int bool] <) (int -> (int -> bool)))
(check-type ([@ curry int int int] +) (int -> (int -> int)))
(check-type-error ([@ curry int int int] <))
(check-type-error ([@ curry int int bool] +))
(check-type-error ([@ curry int int bool] or))

;; step 17
    ;; TyLambda
(check-type id (forall ['a]('a -> 'a)))
(val id2 (type-lambda ['a 'b] (lambda ([n : 'a]) n)))
(check-type id2 (forall ['a 'b]('a -> 'a)))
(check-type curry (forall ['a 'b 'c] (('a 'b -> 'c) -> ('a -> ('b -> 'c)))))
(type-lambda ['a] (lambda ([n : 'a]) n))
(val id3 (type-lambda ['a] (lambda ([n : 'a]) n)))
(check-type id3 (forall ['a]('a -> 'a)))
