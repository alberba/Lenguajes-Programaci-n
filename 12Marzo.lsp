; EJERCICIO 1

    ; Clase pertany de clase2.lsp para uso

    (defun pertany (x L)
        (cond
            ((null L) nil)
            ((equal x (car L)) t)
            (t (pertany x (cdr L)))
        )
    )

    ; Comprobar si una lista dada es un conjunto o no
    (defun conjunt-correcte (L)
        (cond
            ((null L) t)
            ((pertany (car L) (cdr L)) nil)
            (t (conjunt-correcte (cdr L)))
        )
    )

; EJERCICIO 2

    ; A partir de una lista, convertirlo a un conjunto
    (defun fer-conjunt (L)
        (cond
            ((null L) '())
            ((pertany (car L) (cdr L)) 
                (fer-conjunt (cdr L))
            )
            (t (cons (car L) (fer-conjunt (cdr L))))
        )
    )

; EJERCICIO 3

    ; Union de dos conjuntos
    (defun unio (L1 L2)
        (cond
            ((null L1) L2)
            ((pertany (car L1) L2)
                (unio (cdr L1) L2)
            )
            (t (cons (car L1) (unio (cdr L1) L2)))
        )
    )

; EJERCICIO 4

    ; Intersección de dos conjuntos
    (defun interseccio (L1 L2)
        (cond
            ((null L1) '())
            ((pertany (car L1) L2)
                (cons (car L1) (interseccio (cdr L1) L2))
            )
            (t (interseccio (cdr L1) L2))
        )
    )

; EJERCICIO 5

    ; LA diferencia entre dos conjuntos. Los elementos que hay en L1 que no estan en L2
    (defun diferencia (L1 L2)
        (cond
            ((null L1) '())
            ((pertany (car L1) L2)
                (diferencia (cdr L1) L2)
            )
            (t (cons (car L1) (diferencia (cdr L1) L2)))
        )
    )

; EJERCICIO 6

    ; La diferencia simétrica entre dos conjuntos. Los elementos que hay en L1 que no estan en L2 y viceversa
    (defun diferencia-simetrica (L1 L2)
        (unio (diferencia L1 L2) (diferencia L2 L1))
    )

; EJERCICIO 7

    ; A partir de un elemento y una lista, hará listas por cada elemento de L 
    ; formados por el elemento a por el elemento de L.
    ; Ejemplo : ((a L_1) (a L_2))
    (defun fer-llistes (a L)
        (cond
            ((null L) '())
            (t
                (cons (list a (car L)) (fer-llistes a (cdr L)))
            )
        )
    )

    ; Producto cartesiano
    (defun producte-cartesia (L1 L2)
        (cond
            ((null L1) '())
            (t
                ; Tiene que ser append, ya que si fuese cons 
                ; quedaria (((a d) (a e)) ((b d) (b e)))
                (append 
                    (fer-llistes (car L1) L2) 
                    (producte-cartesia (cdr L1) L2)
                )
            )
        )
    )

; EJERCICIO 8

    ; Insertar un elemento en la posición n de una lista
    (defun insereix (a num L)
        (cond
            ((null L) (list a))
            ((= num 1) (cons a L))
            (t (cons (car L) (insereix a (- num 1) (cdr L))))
        )
    )