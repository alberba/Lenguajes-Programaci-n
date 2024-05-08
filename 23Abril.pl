% ejercicio antecesor
ascendent(joana, miquel).
ascendent(toni, miquel).
ascendent(toni, maria).
ascendent(miquel, aina).
ascendent(miquel, gloria).
ascendent(gloria, jaume).

    % caso directo
antecesor(X, Y) :-  ascendent(X, Y);
                    ascendent(X, Z),
                    antecesor(Z, Y).

% ejercicio listas
elements([], 0).

elements([_| L2],X) :-  elements(L2, X1),
                        X is X1+1.

% ejercicio pertany

pertany(X, [X|L1]).

pertany(X, [Y|L1]) :- pertany(X, L1).