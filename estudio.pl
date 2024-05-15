factorial(0, 1).

factorial(N, X) :- N > 0, N1 is N-1,
                    factorial(N1, X1),
                    X is N*X1.

% ejercicio ascendiente

ascendent(joana, miquel).
ascendent(toni, miquel).
ascendent(toni, maria).
ascendent(miquel, aina).
ascendent(miquel, gloria).
ascendent(gloria, jaume).

antecesor(X,Z) :- ascendent(X,Z).
antecesor(X,Z) :- ascendent(X,Y), antecesor(Y, Z).

% el número de elementos que tiene una lista

elements([], 0).

elements([X|L], N) :- elements(L, N1), N is N1 + 1.

% pertenece un elemento dentro de una lista

pertany([X|_], X).
pertany([_|L], Y) :- pertany(L, Y).

% Unir dos listas

unirListas([], L, L).

unirListas([X|L1], L2, [X|L3]) :- unirListas(L1, L2, L3).

% Último elemento de la lista

darrer([X], X).

darrer([_|L], X) :- darrer(L, X).

% Borrar un elemento de la lista

esborrar(_,[],[]).
esborrar(X,[X|L],L2) :- esborrar(X, L, L2).

esborrar(X, [Y|L], [Y|L2]) :- esborrar(X, L, L2).

% Sumar los elementos de una lista
sumar([], 0).

sumar([X|L], N) :- sumar(L, N1), N is X+N1.

%El número máximo de una lista

maxim([X], X).

maxim([X|L], N):- maxim(L, N), N>X.

maxim([X|L], X):- maxim(L, N), X>=N.

% Invertir una lista
invertir([X], [X]).

invertir([X|L1], L2) :- invertir(L1, L3),
    unirListas(L3, [X], L2).

% Permutar una lista
insereix(X, L, [X|L]).
insereix(X, [Y|L], [Y|L2]) :- insereix(X, L, L2).

permutar([], []).
permutar([X|L1], L2) :- permutar(L1, L3),
    insereix(X, L3, L2).

% Ejercicio Aritmogrames
digit(X) :- between(1 , X, 9).

solucio(A,B,C,D,E,F,G,H) :-
    digit(A), digit(B), digit(C),
    7 is A*B-C,
    digit(D), digit(E),
    2 is D*4//E,
    digit(F), digit(G), digit(H),
    7 is F-G+H,
    7 is A+D+F,
    4 is B-4+G,
    7 is C-E+H.
