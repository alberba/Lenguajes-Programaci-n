; Funció quadrat que pinta un quadrat de mida m
(defun quadrat (mida)
    (drawrel mida 0)
    (drawrel 0 mida)
    (drawrel (- mida) 0)
    (drawrel 0 (- mida))
)

(defun quadrats (n dx dy)
    (cond
        ((= n 0) nil)
        (t
            (moverel dx dy)
            (quadrat 40)
            (quadrats (- n 1) dx dy)
        )
    )
)

; EJERCICIO CIRCULO ANGULO
; FUNCIONES AUXILIARES

; Dibuja un rectangulo a partir del punto (x, y) 
; inicial junto a la anchura y altura
(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h))
)

; Dibuja un círculo con la p(x, y) central y su radio, 
; junto al número de lados
(defun cercle (x y radi segments)
    (mover (+ x radi) y)
    (cercle2 x y radi (/ 360 segments) 0)
)


(defun cercle2 (x y radi pas angle)
    (cond ((< angle 360)
        (drawr (+ x (* radi (cos (radians (+ angle pas)))))
               (+ y (* radi (sin (radians (+ angle pas))))))
        (cercle2 x y radi pas (+ angle pas)))
        (t t)
    )
)

; Funciones para evitar errores con 
; valores double
(defun mover (x y)
    (move (round x)
          (round y)
    )
)

(defun drawr (x y)
    (draw (round x)
          (round y)
    )
)

; Función para pasar de grados a radianes
(defun radians (graus)
    (/ (* graus (* 2 pi)) 360)
)

(defun inici()
    ; Guarda en programa la variable ángulo con un valor inicial 0
    (putprop 'programa 0 'angle)
    (repeteix)
)

(defun inici-cli ()
    (putprop 'programa 0 'angle)
    (repeteix-cli)
)

; Incrementa el ángulo en 1
(defun inc-angle ()
    (putprop 'programa (+ (get 'programa 'angle) 1) 'angle)
)

; Decrementa el ángulo en 1
(defun dec-angle ()
    (putprop 'programa (- (get 'programa 'angle) 1) 'angle)
)

(defun pinta ()
    ; Limpia la pantalla
    (cls)
    ; Cambia el color del trazado a rojo
    (color 255 0 0)
    ; Dibuja el rectángulo del tamaño de la pantalla.
    ; Se decrementa en 1 el ancho y el alto para que 
    ; se pueda ver por pantalla
    (rectangle 0 0 639 339)
    (color 0 0 0)
    (cercle 320 170 160 100)
    (angle 320 170 160 (get 'programa 'angle))
)

; Función para dibujar una recta desde el centro del círculo
; al extremo, teniendo en cuenta el ángulo actual
(defun angle (x y r angle)
    (move x y)
    (drawr (+ x (* r (cos (radians angle))))
           (+ y (* r (sin (radians angle))))
    )
)

; Bucle para poder hacer el programa iterativo
(defun repeteix ()
    (pinta)
    (setq key (get-key))
    (cond 
        ; La tecla presionado es la arrow-up
        ((equal key 328) (inc-angle) (repeteix))
        ; La tecla presionado es la arrow-down
        ((equal key 336) (dec-angle) (repeteix))
        ((equal key 27) "Fin del juego")
        (t (repeteix))
    )
)

(defun repeteix-cli ()
    (pinta)
    (princ "Funcions: inc-angle o dec-angle")
    (terpri)
    (princ "---->"
    (eval (read))) 
    (repeteix-cli)
)