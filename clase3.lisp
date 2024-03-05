; Elimina la primera coincidencia de a en la lista

(defun esborra (a L)
    (cond 
        ((null L) '())
        ((equal a (car L)) (cdr L))
        (t (cons (car L) (esborra a (cdr L))) )
    )
)

; Elimina todos los elementos que coincidan con a de la lista
(defun esborra-tot (a L)
    (cond 
        ((null L) nil)
        ((equal a (car L)) (esborra-tot a (cdr L)))
        (t (cons (car L) (esborra-tot a (cdr L))) )
    )
)

; Devuelve todos los valores de una lista menos el último
(defun rdc (L)
    (cond
        ((null (cdr L)) nil)
        (t (cons (car L) (rdc (cdr L))))
    )
)

; Añade un elemento al final de una lista
(defun snoc (a L)
    (cond
        ((null L) (list a))
        (t (cons (car L) (snoc a (cdr L))))
    )
)

; Multiplica cada valor de la lista por x
(defun escala (x L)
    (cond
        ((null L) '())
        (t (cons (* x (car L)) (escala x (cdr L))))
    )
)

; Devuelve el número máximo de una lista
(defun maxim (L)
    (cond
        ((null (cdr L)) (car L))
        ((> (car L) (maxim (cdr L))) (car L))
        (t (maxim (cdr L)))
    )
)

; Devuelve el número mínimo de una lista
(defun minim (L)
    (cond
        ((null (cdr L)) (car L))
        ((< (car L) (minim (cdr L))) (car L))
        (t (minim (cdr L)))
    )
)

(defun ordena (L)
    (cond 
        ((null L) nil)
        (t 
            (cons (minim L) (ordena (esborra (minim L) L)))
        )
    )
)
