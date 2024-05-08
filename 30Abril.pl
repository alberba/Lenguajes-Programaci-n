% ejercicio afegir
afegir([], L, L).
afegir([X|L1], L2, [X|L3]) :- afegir(L1, L2, L3).

% ejercicio darrer
darrer([X], X).
darrer([X|L1], Y) :- darrer(L1, Y).

% ejercicio esborrar
esborrar(X, [X|L1], L1).
esborrar(Y, [X|L1], [X|L]) :- esborrar(Y, L1, L).

% ejercicio invertir
invertir([],[]).
invertir([X], X).
invertir([X|L1], L2) :- invertir(L1, L3),
                        afegir(L3, [X], L2).

% ejercicio permuta
permuta([], []).
permuta([X|L1], L2) :- permuta(L1, L3),
                    insereix(X, L3, L2).

insereix(X, L, [X|L]).
insereix(X, [Y|L1],[Y|L2]) :- insereix(X,L1,L2).
