; Ordenar de menor a mayor
(defun ordena (L)
    (cond 
        ((null L) nil)
        (t 
            (cons 
                (minim L) 
                (ordena (esborra (minim L) L))
            )
        )
    )
)

; Invertir una lista
(defun inverteix (L)
    (cond
        ((null L) nil)
        ((null (cdr L)) L)
        (t
            (append
                (inverteix (cdr L))
                (list (car L))
            )
        )
    )
)

; Eliminar enesimo elementod
(defun esborraN (x L)
    (cond
        ((null L) nil)
        (t
            (cond
                ((equal x 1) (cdr L))
                (t 
                    (cons
                        (car L)
                        (esborraN (- x 1) (cdr L))
                    )
                )
            )
        )
    )
)

; Número de veces que aparece una expresión en una lista
(defun vegades (x L) 
    (cond
        ((null L) 0)
        (t
            (+ 
                (cond
                    ((equal x (car L)) 1)  
                    (t 0)
                )
                (vegades x (cdr L))
            )
        )
    )
)

; Contar el nombre de átomos que hay dentro de una lista
(defun atoms (L)
    (cond
        ((null L) 0)
        ; Si el elemento a comprobar es una lista, hay que aplicar el método 
        ; para el elemento lista y sumarlo a las siguientes
        ((listp (car L)) 
            (+ (atoms (car L)) (atoms (cdr L)))
        )
        (t (+ 1 (atoms (cdr L))))
    )
)

; Convertir la lista en una lista plana
(defun aplana (L)
    (cond
        ((null L) '())
        ((listp (car L))
            (append (aplana (car L)) (aplana (cdr L)))
        )
        (t (append (list (car L)) (aplana (cdr L))))
    )
)

; Devolver n primeros elementos de una lista
(defun tornaprimers (n L)
    (cond
        ((null L) '())
        ((= n 1) (list(car L)))
        (t (append (list (car L)) (tornaprimers (- n 1) (cdr L))))
    )
)

; Devolver la lista eliminando los primeros n elementos
(defun treuprimers (n L)
    (cond
        ((null L) '())
        ((= n 1) (cdr L))
        (t (treuprimers (- n 1) (cdr L)))
    )
)

