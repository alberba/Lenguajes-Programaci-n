; Pertany tiene que hacer lo mismo que member (es como la funcion contains) 

(defun pertany (x L)
    (cond
        ((null L) nil)
        ((equal x (car L)) t)
        (t (pertany x (cdr L)))
    )
)

; Calcular números exponenciales
(defun exp (x y)
    (cond 
        ((equal y 0) 1)
        (t (* x (exp x (- y 1))))
    )
)

; Cálculo de fibonacci
(defun fib (n)
    (cond 
        ((equal n 0) 0)
        ((equal n 1) 1)
        (t (+ (fib (- n 1)) (fib (- n 2)) ))
    )
)

(defun dividir (x y)
    (cond 
        ((< x y) 0)
        (t (+ (dividir (- x y) y) 1))
    )
)

(defun parell (x)
    (equal x (* 2 (dividir x 2)))
)

(defun senars (L)
    (cond 
        ((null L) '())
        ((not (parell (car L)))
         (cons (car L) (senars (cdr L))))
        (t (senars (cdr L)))
    )
)

(defun eq2 (a b c)
    (cond 
        ((minusp (- (* b b) (* 4 a c))) nil)
        (t )
    )
)