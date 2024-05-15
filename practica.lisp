;---------------------------------------------------------------------------
(defun inicia ()
    (inicializarProps)
    (pinta)
    (bucle)
    "Fin de la partida"
)

(defun bucle()
    (setq key (get-key))
    (cond
        ; Turno del cañon A
        ((equal (get 'programa 'turno) 0)
            (cond 
                ((or (equal key 65) (equal key 97))  
                    (moverIzquierda 'canonA)) ;"A"
                ((or (equal key 68) (equal key 100)) 
                    (moverDerecha 'canonA)) ;"D"
                ((or (equal key 87) (equal key 119)) 
                    (puja 'canonA 3)) ;"W"
                ((or (equal key 83) (equal key 115)) 
                    (baixa 'canonA 3)) ;"S"
                ((or (equal key 81) (equal key 113)) 
                    (disminueix 'canonA 3)) ;"Q"
                ((or (equal key 69) (equal key 101)) 
                    (augmenta 'canonA 3)) ;"E"
                ((or (equal key 70) (equal key 102)) 
                    (dispara 'canonA) 
                    (sleep 0.2)
                    (putprop 'programa 1 'turno)) ;"F"
                ((equal key 27) (putprop 'programa 1 'fin))
            )
            
        )
        ; Turno del cañon B
        ((equal (get 'programa 'turno) 1) 
            (cond
                ((or (equal key 74) (equal key 106)) 
                    (moverIzquierda 'canonB)) ;"J"
                ((or (equal key 76) (equal key 108)) 
                    (moverDerecha 'canonB)) ;"L"
                ((or (equal key 73) (equal key 105))
                    (puja 'canonB 3)) ;"I"
                ((or (equal key 75) (equal key 107)) 
                    (baixa 'canonB 3)) ;"K"
                ((or (equal key 79) (equal key 111)) 
                    (disminueix 'canonB 3)) ;"O"
                ((or (equal key 85) (equal key 117)) 
                    (augmenta 'canonB 3)) ;"U"
                ((or (equal key 72) (equal key 104)) 
                    (dispara 'canonB) 
                    (sleep 0.2)
                    (putprop 'programa 0 'turno)) ;"H"
                ((equal key 27) (putprop 'programa 1 'fin))
            )
        )
    )
    (pinta)
    (cond
        ((equal (get 'programa 'fin) 0)
            (bucle)
        )
    )
)

(defun pinta ()
    (cls)
    (dibujarEscenario)
    (dibujarCanones)
    (dibujarBandera)
)

; Función que se encarga de subir el palo del cañon
(defun puja (cano graus)
    (cond 
        (
            (and 
                (>= (+ (get cano 'angulo) graus) 0)
                (<= (+ (get cano 'angulo) graus) 180)
            )
            (putprop cano (+ (get cano 'angulo) graus) 'angulo)
        )
    )
)

; Función que se encarga de bajar el palo del cañon
(defun baixa (cano graus)
    (cond 
        (
            (and 
                (>= (- (get cano 'angulo) graus) 0) 
                (<= (- (get cano 'angulo) graus) 180)
            ) 
            (putprop cano (- (get cano 'angulo) graus) 'angulo)
        )
    )
)

; Función que se encarga de aumentar la velocidad del proyectil y el tamaño del palo
(defun augmenta (cano velocitat)
    (cond 
        (
            ; El rango esta entre 0 y 100
            (and 
                (> (+ (get cano 'velocidadProyectil) velocitat) 0)
                (<= (+ (get cano 'velocidadProyectil) velocitat) 100)
            )
            (putprop cano 
                (+ (get cano 'velocidadProyectil) velocitat) 
                'velocidadProyectil
            )
        )
    )
)

; Función que se encarga de disminuir la velocidad del proyectil y el tamaño del palo
(defun disminueix (cano velocitat)
    (cond 
        (
            ; El rango esta entre 0 y 100
            (and 
                (> (- (get cano 'velocidadProyectil) velocitat) 0)
                (<= (- (get cano 'velocidadProyectil) velocitat) 100)
            )
            (putprop cano 
                (- (get cano 'velocidadProyectil) velocitat)
                'velocidadProyectil
            )
        )
    )
)

; Función que se encarga de mover el cañon correspondiente a la izquierda
(defun moverIzquierda (cano)
    (cond
        ; Comprueba si el cañon está dentro de los límites del campo
        (   
            (and 
                (equal cano 'canonA)
                (>= (- (get cano 'posicion) 2) 0)
            )
            (putprop cano (- (get cano 'posicion) 2) 'posicion)
        )
        (
            (and 
                (equal cano 'canonB)
                (>= (- (get cano 'posicion) 2) 
                    (+ (get 'escenario 'anchuraCampoA) 
                        (get 'escenario 'anchuraMuro))
                )
            )
            (putprop cano (- (get cano 'posicion) 2) 'posicion)
        )
    )
)

; Función que se encarga de mover el cañon correspondiente a la derecha
(defun moverDerecha (cano)
    (cond
        ; Comprueba si el cañon está dentro de los límites del campo
        (
            (and 
                (equal cano 'canonA)
                (<= (+ (get cano 'posicion) (get cano 'anchura) 2) 
                    (get 'escenario 'anchuraCampoA))
            )
            (putprop cano (+ (get cano 'posicion) 2) 'posicion)
        )
        (
            (and 
                (equal cano 'canonB)
                (<= (+ (get cano 'posicion) (get cano 'anchura) 2) 
                    (+ (get 'escenario 'anchuraCampoA) 
                        (get 'escenario 'anchuraMuro) 
                        (get 'escenario 'anchuraCampoB))
                )
            )
            (putprop cano (+ (get cano 'posicion) 2) 'posicion)
        )
    )
)

(defun dispara (cano)
    ; Establece el color de la bala dependiendo del cañon
    (cond
        ((equal cano 'canonA) (color 0 0 255))
        ((equal cano 'canonB) (color 255 0 0))
    )
    (calculoInicial cano)
    (move (get 'bala 'posicionX) (get 'bala 'posicionY))
    (disparaRecursiu 0 cano)
)

; Función recursiva que calcula la trayectoria de la bala
(defun disparaRecursiu (tiempo cano)
    (cond
        ; Si detecta alguna colisión, finalizará el disparo
        ((detectaColision cano) t)
        (t
            ; Actualizamos los parámetros de la bala
            (putprop 'bala 
                ; Vy = Vy0 + g * t
                (+
                    (get 'bala 'velocidadY)
                    (* tiempo (get 'escenario 'gravedad))
                )
                'velocidadY
            )
            (putprop 'bala 
                ; Vx = Vx0 + viento * t
                (+
                    (get 'bala 'velocidadX0)
                    (* tiempo (get 'escenario 'viento))
                )
                'velocidadX
            )
            (putprop 'bala 
                ; X = X0 + Vx * t
                (+
                    (get 'bala 'posicionX)
                    (* tiempo (get 'bala 'velocidadX))
                )
                'posicionX
            )
            (putprop 'bala 
                ; Y = Y0 + Vy * t + 1/2 * g * t^2
                (+
                    (get 'bala 'posicionY)
                    (* tiempo (get 'bala 'velocidadY))
                    (* (/ 1 2) (expt tiempo 2) 
                        (get 'escenario 'gravedad))
                )
                'posicionY
            )
            ; Dibujamos la trayectoria
            (draw
                (round (get 'bala 'posicionX))
                (round (get 'bala 'posicionY)))
            (sleep 0.05)
            (disparaRecursiu (+ tiempo (get 'escenario 'tiempo))
                cano)    
        )
    ) 
)

; Función que detecta si la bala colisiona con el muro, el suelo o el cañon
(defun detectaColision (cano)
    (cond   
        ; Comprueba si la bala choca con el muro o con el cuadrado del escenario
        ((or 
            (and 
                (and 
                    ; Comprueba si la bala está en el rango del muro
                    (> (get 'bala 'posicionX) 
                        (get 'escenario 'anchuraCampoA))
                    (< (get 'bala 'posicionX) 
                        (+ (get 'escenario 'anchuraCampoA) 
                            (get 'escenario 'anchuraMuro))
                    )
                )
                ; Comprueba si la bala está en el rango de la altura del muro
                (< (get 'bala 'posicionY) (get 'escenario 'alturaMuro))
            )
            (> (get 'bala 'posicionY) (get 'escenario 'alturaCuadrado))
            ; Compueba si la bala esta en el ancho permitido
            (< (get 'bala 'posicionX) 0)
            (> (get 'bala 'posicionX) (get 'escenario 'anchuraCuadrado))
        ) t)
        ; La bala no colisiona con el muro
        (t 
            ; Comprueba si la bala choca con el suelo
            (cond
                (
                    (and 
                        (eq cano 'canonA)
                        (>  (get 'bala 'posicionY) 
                            (get 'escenario 'alturaCampoB))
                    )
                        (cond
                            ((detectaColisionCanon 'canonB) 
                                (putprop 'programa 1 'fin) t)
                            (t nil)
                        )
                )
                (
                    (and (eq cano 'canonB)
                        (>  (get 'bala 'posicionY) 
                        (get 'escenario 'alturaCampoA)))
                        (cond
                            ((detectaColisionCanon 'canonA) 
                                (putprop 'programa 1 'fin) t)
                            (t nil)
                        )
                )
                (t t)
            )
        )
    )
)

(defun detectaColisionCanon (canon)
    ; Comprueba si trayectoria de la bala choca con el canon
    (cond
        ((eq canon 'canonA)
            (and
                ; comprobando si la posición de la bala está entre el rango
                ; de la posición del canon y la posición del canon más su anchura
                (<= (get 'bala 'posicionX) 
                (+ (get 'canonA 'posicion) (get 'canonA 'anchura) 2))
                
                (>= (get 'bala 'posicionX) (- (get 'canonA 'posicion) 2))
                
                ; comprobando si la posición de la bala está entre el rango
                ; de la posición del canon y la posición del canon más su altura
                (<= (get 'bala 'posicionY) 
                    (+ (get 'escenario 'alturaCampoA) (get 'canonA 'altura) 2))
            )
        )
        ((eq canon 'canonB)
            (and
                (<= (get 'bala 'posicionX) 
                (+ (get 'canonB 'posicion) (get 'canonB 'anchura) 2))

                (>= (get 'bala 'posicionX) 
                    (- (get 'canonB 'posicion) 2))

                (<= (get 'bala 'posicionY) 
                (+ (get 'escenario 'alturaCampoB) 
                    (get 'canonB 'altura) 2))
            )
        )
    )
)

; Función que calcula los parámetros iniciales de la bala dependiendo de que
; cañon la dispara
(defun calculoInicial (cano)
    ; VY0 = V * sen(angulo)
    (putprop 'bala 
        (*
            (get cano 'velocidadProyectil)
            (sin (radians (get cano 'angulo)))
        )
        'velocidadY
    )

    ; X0 = X + (anchura / 2)
    (putprop 'bala 
        (+ (get cano 'posicion) (/ (get cano 'anchura) 2)) 
    'posicionX)

    (cond
        ((eq cano 'canonA)
            ; VX0 = V * cos(angulo)
            (putprop 'bala 
                (*
                    (get cano 'velocidadProyectil)
                    (cos (radians (get cano 'angulo)))
                )
                'velocidadX0
            )
            (putprop 'bala 
                (+
                    (get 'escenario 'alturaCampoA)
                    (get cano 'altura)
                )
                'posicionY
            )
        )
        ((eq cano 'canonB)
            ; Al ser el cañon B, la velocidad en X0 es negativa
            (putprop 'bala 
                (- 
                    (*
                        (get cano 'velocidadProyectil)
                        (cos (radians (get cano 'angulo)))
                    )
                )
                'velocidadX0
            )
            (putprop 'bala 
                (+
                    (get 'escenario 'alturaCampoB)
                    (get cano 'altura)
                )
                'posicionY
            )
        )
    )
)

(defun dibujarEscenario()
    ; Dibujo del cuadrado
    (color 0 0 0)
    (rectangle 0 0 
        (- (get 'escenario 'anchuraCuadrado) 1) 
        (- (get 'escenario 'alturaCuadrado) 1)
    )
    ; Campo A
    (color 148 238 85)
    (rectangle 0 0 
        (get 'escenario 'anchuraCampoA)
        (get 'escenario 'alturaCampoA)
    )
    ; Campo B
    (color 148 238 85)
    (rectangle
        (+ 
            (get 'escenario 'anchuraCampoA) 
            (get 'escenario 'anchuraMuro)
        ) 
        0
        (get 'escenario 'anchuraCampoB)   
        (get 'escenario 'alturaCampoB)
    )
    ; Muro
    (color 86 99 117)
    (rectangle (get 'escenario 'anchuraCampoA) 
        0
        (get 'escenario 'anchuraMuro)   
        (get 'escenario 'alturaMuro))
    (color 255 0 0)
)

(defun dibujarCanones()
    ; Canon A
    (color 0 0 255)
    (rectangle
        (get 'canonA 'posicion)
        (get 'escenario 'alturaCampoA)
        (get 'canonA 'anchura)
        (get 'canonA 'altura)
    )
    
    (anguloA
        (+ 
            (get 'canonA 'posicion) 
            (/ (get 'canonA 'anchura) 2)
        )
        (+ 
            (get 'escenario 'alturaCampoA) 
            (get 'canonA 'altura)
        )
        (/ (get 'canonA 'velocidadProyectil) 2)
        (radians (get 'canonA 'angulo))
    )
    
    ; Canon B
    (color 255 0 0)
    (rectangle
        (+ 
            (get 'canonB 'posicion)
        ) 
        (get 'escenario 'alturaCampoB)
        (get 'canonB 'anchura)
        (get 'canonB 'altura)
    )

    (anguloB 
        (+ 
            (get 'canonB 'posicion) 
            (/ (get 'canonB 'anchura) 2)
        )
        (+ 
            (get 'escenario 'alturaCampoB) 
            (get 'canonB 'altura)
        )
        (/ (get 'canonB 'velocidadProyectil) 2)
        (radians (get 'canonB 'angulo))
    )
)

(defun dibujarBandera()   
    ; Dibujamos la bandera en la posición del viento
    (move 
        (+  (get 'escenario 'anchuraCampoA) 
            (round (/ (get 'escenario 'anchuraMuro) 2))) 
        (get 'escenario 'alturaMuro)
    )
    (drawrel 0 (get 'escenario 'alturaBandera))
    (princ (get 'escenario 'viento))
    (dibujarBanderaViento (get 'escenario 'viento))
)

(defun dibujarBanderaViento (viento)
    (cond
        ;Dibujamos la bandera en funcion del viento recusivamente
        ((> viento 0) 
            (drawrel 0 -5)
            (drawrel 3 0)
            (drawrel 0 5)
            (drawrel -3 0)
            (moverel 3 0)
            (dibujarBanderaViento (- viento 1))
        )
        ((< viento 0) 
            (drawrel 0 -5)
            (drawrel -3 0)
            (drawrel 0 5)
            (drawrel 3 0)
            (moverel -3 0)
            (dibujarBanderaViento (+ viento 1))
        )
    )
)

(defun inicializarProps()
    ; Inicializando las propiedades
    (setq rs (make-random-state t))
    ; Propiedades del escenario
    (putprop 'escenario 340 'alturaCuadrado)
    (putprop 'escenario 640 'anchuraCuadrado)
    
    (putprop 'escenario (+ (random 21 rs) 20) 'anchuraMuro)
    (putprop 'escenario (+ (random 51 rs) 100) 'alturaMuro)
    
    (putprop 'escenario 20 'alturaBandera)

    ; El viento es un valor entre -5 y 5
    (putprop 'escenario (- (random 11 rs) 5) 'viento)
    
    ; Propiedades constantes del cañon
    (putprop 'canonA 10 'altura)
    (putprop 'canonA 20 'anchura)
    (putprop 'canonA 45 'angulo)
    (putprop 'canonA 20 'velocidadProyectil)

    (putprop 'canonB 10 'altura)
    (putprop 'canonB 20 'anchura)
    (putprop 'canonB 45 'angulo)
    (putprop 'canonB 20 'velocidadProyectil)

    ; Propiedades trayectoria
    (putprop 'escenario -9.8 'gravedad)
    (putprop 'escenario 0.001 'tiempo)

    (putprop 'programa 0 'fin)
    (putprop 'programa 0 'turno)
    
    ; Creacion del escenario
    (creacionCampos)
    (creacionCanon)
)

(defun creacionCampos()
    ; Posicionamos los campos en el escenario
    (putprop 'escenario
        (+
            (random 81 rs)
            ; Calculamos la anchura del campo A
            (-
                (round
                    (/
                        (-  (get 'escenario 'anchuraCuadrado ) 
                            (get 'escenario 'anchuraMuro )
                        )
                        2
                    )
                )
                40   
            )
        )
        'anchuraCampoA
    )
    ; Calculamos la anchura del campo B
    (putprop 'escenario 
        (-  (get 'escenario 'anchuraCuadrado) 
            (get 'escenario 'anchuraMuro) 
            (get 'escenario 'anchuraCampoA)) 
    'anchuraCampoB)

    ; Sumamos 15 porque es el minimo de altura para un campo
    (putprop 'escenario (+ (random 31 rs) 15) 'alturaCampoA) 
    (putprop 'escenario (+ (random 31 rs) 15) 'alturaCampoB) 
)

(defun creacionCanon ()
    ; Posicionamos los cañones en el campo
    (putprop 'canonA
        (+
            ; En una posición aleatoria entre 1/3 del campo
            (random (+ (round(/ (get 'escenario 'anchuraCampoA) 3)) 1) rs)
            (round(/ (get 'escenario 'anchuraCampoA) 3))
        )
        'posicion
    )
    
    (putprop 'canonB
        (+
            (random (+ (round(/ (get 'escenario 'anchuraCampoB) 3)) 1) rs)
            (round(/ (get 'escenario 'anchuraCampoB) 3))
            (get 'escenario 'anchuraCampoA)
            (get 'escenario 'anchuraMuro)
        )
        'posicion
    )
)

; Dibuja un rectangulo a partir del punto (x, y) 
; inicial junto a la anchura y altura
(defun rectangle (x y w h)
    (move x y)
    (drawrel w 0)
    (drawrel 0 h)
    (drawrel (- w) 0)
    (drawrel 0 (- h))
)

(defun radians (graus)
; Retorna el valor en radianes d'un angle en graus
 (/ (* graus (* 2 pi)) 360))

; Función que dibuja el palo del cañon A
(defun anguloA(x y r angle)
    (move x y)
    (drawr 
        (+ x (* r (cos angle)))
        (+ y (* r (sin angle)))
    )
)

; Función que dibuja el palo del cañon B
(defun anguloB(x y r angle)
    (move x y)
    (drawr 
        (- x (* r (cos angle)))
        (+ y (* r (sin angle)))
    )
)

; Funcion que dibuja un punto en la pantalla
(defun drawr (x y)
    (draw (round x)
    (round y))
)

(defun sleep (seconds)
    "Espera la quantitat indicada de segons"
    ; Això és un bucle iteratiu. NO PODEU FER-NE SERVIR ENLLOC MÉS
    (do ((endtime (+ (get-internal-real-time)
    (* seconds internal-time-units-per-second))))
    ((> (get-internal-real-time) endtime)))
)