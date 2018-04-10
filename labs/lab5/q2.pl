testaPrimeiroEl([X|_], [Y|_]) :-(X = Y).

testaUltimoEl([X|[]], X).
testaUltimoEl([_|XS], Y) :- testaUltimoEl(XS, Y).

poetica(X, Y, 'poetica') :- testaPrimeiroEl(X, Y), testaUltimoEl(X, R), testaUltimoEl(Y, R1), R = R1.
poetica(_, _, 'naopoetica').

:- initialization main.

main :-
  read(A),
  read(B),
  poetica(A, B, R),
  write(R), nl.
