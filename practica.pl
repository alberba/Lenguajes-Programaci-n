verEdificios([], 0, _).

verEdificios([X|L], N, MAYOR):-
    X >= MAYOR,
    verEdificios(L, N1, X),
    N is N1 + 1.

verEdificios([X|L], N, MAYOR):-
    MAYOR > X,
    verEdificios(L, N1, MAYOR),
    N is N1.

transponerMatriz([], []).
transponerMatriz([[]|_], []).
transponerMatriz(LFILAS, [COLUMNATRANS|RESTOCOLUMNA]) :-
    primeros(LFILAS, COLUMNATRANS, RSINTRANS),
    transponerMatriz(RSINTRANS, RESTOCOLUMNA).

primeros([], [], []).
primeros([[X|SINTRANS]|RESTOFILAS], [X|RCOLUMNA], [SINTRANS|RESTOSINTRANS]) :-
    primeros(RESTOFILAS, RCOLUMNA, RESTOSINTRANS).

ciutats(O,E,N,S, LFILAS) :-
    permutar_filas(4, LFILAS),
    verEdificiosLado(O, LFILAS),
    invertirListas(LFILAS, LFILASINVERTIDA),
    verEdificiosLado(E, LFILASINVERTIDA),
    transponerMatriz(LFILAS, LTRANS),
    todos_diferentesMatriz(LTRANS),
    verEdificiosLado(N, LTRANS),
    invertirListas(LTRANS, LTRANSINVERTIDA),
    verEdificiosLado(S, LTRANSINVERTIDA).

verEdificiosLado([ORI|[]], [F|[]]) :- 
    verEdificios(F, N, 0),
    ORI = N.

verEdificiosLado([ORI|ORIRESTO], [F|RESTOFILA]) :-
    verEdificios(F, N, 0),
    ORI = N,
    verEdificiosLado(ORIRESTO, RESTOFILA).

todos_diferentesMatriz([]).

todos_diferentesMatriz([X|L]):- 
    todos_diferentes(X),
    todos_diferentesMatriz(L).

todos_diferentes([]).
todos_diferentes([X|L]) :- not(member(X, L)), todos_diferentes(L).

invertirListas([], []).

invertirListas([X|L1], L2) :- invertir(X,Y),
    invertirListas(L1, L3),
    unirListas([Y], L3, L2).

unirListas([], L, L).

unirListas([X|L1], L2, [X|L3]) :- unirListas(L1, L2, L3).

invertir([X], [X]).

invertir([X|L1], L2) :- invertir(L1, L3),
    unirListas(L3, [X], L2).

permutar_filas(0, []).
permutar_filas(N, [Y|L1]) :-
    permutar([1,2,3,4], Y),
    N1 is N-1,
    permutar_filas(N1, L1).

% Permutar una lista
insereix(X, L, [X|L]).
insereix(X, [Y|L], [Y|L2]) :- insereix(X, L, L2).

permutar([], []).
permutar([X|L1], L2) :- permutar(L1, L3),
    insereix(X, L3, L2).