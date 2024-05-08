fill(pep, pere).
fill(lluis, pere).

pare(X, Y) :- fill(Y, X).
germa(X, Y) :- pare(Z, X), pare(Z, Y), X \= Y.

% ejercicio densidat

poblacio(palma, 300000).
poblacio(manacor, 50000).
poblacio(santa_maria, 4000).

superficie(palma, 10).
superficie(manacor, 6).
superficie(santa_maria, 2).

densitat(X, D) :-   poblacio(X, P), 
                    superficie(X, S), 
                    D is P/S.

% ejercicio signe

horoscop(aries, 21, 3, 21, 4).
horoscop(toro, 21, 4, 21, 5).
horoscop(geminis, 21, 5, 21, 6).
horoscop(cancer, 21, 6, 21, 7).
horoscop(leo, 21, 7, 21, 8).
horoscop(virgo, 21, 8, 21, 9).
horoscop(libra, 21, 9, 21, 10).
horoscop(escorpi, 21, 10, 21, 11).
horoscop(sagitari, 21, 11, 21, 12).
horoscop(capricorn, 21, 12, 21, 1).
horoscop(aquari, 21, 1, 21, 2).
horoscop(peixos, 21, 2, 21, 3).

signe(Dia, Mes, Signe) :-   horoscop(Signe, D1, M1, _, _),
                            Mes = M1,
                            Dia >= D1.

signe(Dia, Mes, Signe) :-   horoscop(Signe, _, _, D2, M2),
                            Mes = M2,
                            Dia < D2.

factorial(0, 1).

factorial(N, X) :-  N \= 0,
                    N1 is N - 1,
                    factorial(N1, X1),
                    X is N * X1.

