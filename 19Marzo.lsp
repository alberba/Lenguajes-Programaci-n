; EJERCICIO 1

    ; Borrar elemento si cumple una determinada condicion
    (defun esborra-si (f L)
        (cond
            ((null L) '())
            ((funcall f (car L))
                (esborra-si f (cdr L))
            )
            (t (cons (car L) (esborra-si f (cdr L))))
        )
    )

; EJERCICIO 2
    (defun afegeix-coes (L)
        ; El apply nos permite hacer un append para cada elemento resultante del mapcar
        (apply 'append (mapcar 'cdr L))
    )

; EJERCICIO 3

    (defun suma1 (a)
        (+ a 1))

    (defun meu-mapcar (f L)
        (cond
            ((null L) nil)
            (t (cons (funcall f (car L))
                    (meu-mapcar f (cdr L))))
        )
    )

; EJERCICIO 4
    (defun transposta (L1 L2)
        (cond
            ((null L1) '())
            (t (cons (list (car L1) (car L2))
                (transposta (cdr L1) (cdr L2))))
        )
    )   

    ; Transpuesta de una lista de la forma ((1, 2, 3) (4, 5, 6))
    (defun transposta (L)
        (cond
            ((null (car L)) nil)
            (t (cons (mapcar 'car L) 
                     (transposta (mapcar 'cdr L))))
        )
    )

    (defun mult (L)
        (apply '* L)
    )

    (defun pescalar (L)
        (apply '+ (mapcar 'mult (transposta L)))
    )