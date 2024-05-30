% Autores: Sergi Oliver y Albert Salom

% Soluciones al problema de las ciudades:
% - ciutats([3,3,1,2],[1,1,2,2],[3,3,2],[2,1,3],[F1,F2,F3,F4]) -> ([1, 2, 3],[2, 3, 4],[4, 1, 2],[3, 4, 1])
% - ciutats([2,1], [1,2], [2,1], [1,2], [F1,F2]). -> ([1, 2],[2, 1])
% - ciutats([2,2,1,3], [3,1,3,2], [3,1,2,2], [2,3,1,2], [F1,F2,F3,F4]) -> ([2, 4, 3, 1],[3, 1, 2, 4],[4, 3, 1, 2],[1, 2, 4, 3]

% Predicado base para verEdificios. Si la lista está vacía, el número de edificios visibles es 0
verEdificios([], 0, _).

% Predicado recursivo para verEdificios
% Si el edificio actual es mayor que el edificio más alto que se ha visto hasta ahora, 
% se incrementa el contador y se llama recursivamente con el resto de la lista
verEdificios([X|L], N, MAYOR):-
    X >= MAYOR,
    verEdificios(L, N1, X),
    N is N1 + 1.

% Predicado recursivo. Si el primer edificio es menor que MAYOR, no se cuenta como visible
verEdificios([X|L], N, MAYOR):-
    MAYOR > X,
    verEdificios(L, N1, MAYOR),
    N is N1.

% Predicado base para transponerMatriz. Si la matriz está vacía, la matriz transpuesta también lo esta
transponerMatriz([], []).
% Si la primera fila de la matriz está vacía, la matriz transpuesta también lo esta
transponerMatriz([[]|_], []).
% Predicado recursivo para transponerMatriz. Extrae la primera columna y llama recursivamente para procesar el resto
transponerMatriz(LFILAS, [COLUMNATRANS|RESTOCOLUMNA]) :-
    primeros(LFILAS, COLUMNATRANS, RSINTRANS),
    transponerMatriz(RSINTRANS, RESTOCOLUMNA).

% Predicado base para primeros
primeros([], [], []).
% Predicado recursivo para primeros. Extrae el primer elemento de cada fila para formar la primera columna de la matriz transpuesta
primeros([[X|SINTRANS]|RESTOFILAS], [X|RCOLUMNA], [SINTRANS|RESTOSINTRANS]) :-
    primeros(RESTOFILAS, RCOLUMNA, RESTOSINTRANS).

% Predicado para resolver el problema de las ciudades
ciutats(O,E,N,S, LFILAS) :-
    % Obtenemos el número de filas de la matriz
    length(O, NFILAS),
    length(N, NCOLUMNAS),
    NFILAS =< NCOLUMNAS,
    	!,
        rango(NCOLUMNAS, FILAPARAPERMUTAR),
        permutar_filas(NFILAS, FILAPARAPERMUTAR, LFILAS),
        % Verificamos los edificios visibles desde el oeste
        verEdificiosLado(O, LFILAS),

        % Invertimos las filas de la matriz para obtener la vista sobre el este
        invertirListas(LFILAS, LFILASINVERTIDA),
        % Verificamos los edificios visibles desde el este
        verEdificiosLado(E, LFILASINVERTIDA),

        % Transponemos la matriz original para obtener la vista sobre el norte
        transponerMatriz(LFILAS, LTRANS),
        % Verificamos que todas las columnas tengan elementos únicos
        todos_diferentesMatriz(LTRANS),
        % Verificamos los edificios visibles desde el norte
        verEdificiosLado(N, LTRANS), 

        % Obtenemos la vista sobre el sur
        invertirListas(LTRANS, LTRANSINVERTIDA), 
        % Verificamos los edificios visibles desde el sur
        verEdificiosLado(S, LTRANSINVERTIDA);
    
    % En caso de que el número de filas sea mayor o igual al número de columnas, 
    % actuamos como si las filas fueran las columnas y viceversa y luego transponemos el resultado.
    ciutats(N, S, O, E, LTRANS),
    transponerMatriz(LTRANS, LFILAS).
    
    
% verEdificiosLado(), calcula el número de edificios visibles desde la izquierda para cada fila de una matriz.

% Predicado base, si la lista de filas tiene una sola fila.
verEdificiosLado([ORI|[]], [F|[]]) :- 
    verEdificios(F, N, 0),
    ORI = N.
%Predicado recursivo, calcula el número de edificios visibles desde la izquierda para la primera fila y llama recursivamente con el resto de las filas.
verEdificiosLado([ORI|ORIRESTO], [F|RESTOFILA]) :-
    verEdificios(F, N, 0),
    ORI = N,
    verEdificiosLado(ORIRESTO, RESTOFILA).

%todos_diferentes(), verifica que todas las filas de una matriz tengan elementos únicos.

% Predicado base si la lista está vacía, es verdadera.
todos_diferentesMatriz([]).

% Predicado recursivo verifica que el primer elemento no esté en el resto de la lista y luego verifica el resto de la lista.
todos_diferentesMatriz([X|L]):- 
    todos_diferentes(X),
    todos_diferentesMatriz(L).

% Predicado base una lista vacía tiene todos sus elementos únicos (es trivialmente verdadera).
todos_diferentes([]).

% Predicado recursivo verifica que el primer elemento de la lista no esté en el resto de la lista.
todos_diferentes([X|L]) :- not(member(X, L)), todos_diferentes(L).

% Predicado base para invertirListas. Si la lista está vacía, la lista invertida también lo está.
invertirListas([], []).
% Predicado recursivo para invertirListas. Invierte la primera lista y llama recursivamente con el resto de la lista.
invertirListas([X|L1], L2) :- invertir(X,Y),
    invertirListas(L1, L3),
    unirListas([Y], L3, L2).

% A partir de dos listas, une la primera con la segunda.
unirListas([], L, L).
unirListas([X|L1], L2, [X|L3]) :- unirListas(L1, L2, L3).

% A partir de una lista, esta devolverá la lista invertida.
invertir([X], [X]).
invertir([X|L1], L2) :- invertir(L1, L3),
    % Se añade el primer elemento al final de la lista invertida.
    unirListas(L3, [X], L2).

% A partir de el número de filas (y columnas) de una matriz, se crea posibles soluciones permutando las filas.
permutar_filas(0, _, []):- !.
permutar_filas(N, FILAPARAPERMUTAR, [Y|L1]) :-
    permutar(FILAPARAPERMUTAR, Y),
    N1 is N-1,
    permutar_filas(N1, FILAPARAPERMUTAR, L1).

% Devuelve una lista con los números de 1 a N
rango(0, []):- !.
rango(N, [N|L]) :- N1 is N-1, rango(N1, L).

% Inserta un elemento en una lista
insereix(X, L, [X|L]).
insereix(X, [Y|L], [Y|L2]) :- insereix(X, L, L2).

% Permuta una lista
permutar([], []).
permutar([X|L1], L2) :- permutar(L1, L3),
    insereix(X, L3, L2).