div(N,P) :-
P>0,
N>P,
0 is N mod P.

fatores( N , Fs ) :-
  integer(N) ,
  N > 0 ,
  setof( F , ( between(1,N,F) , N mod F =:= 0 ) , Fs ).

soma([Num], Num).
soma([N1,N2 | Calda], Total) :-
    soma([N1+N2|Calda], Total).

last([Y|Calda]):-
    last(Calda).

:- initialization main.

main:-
  read(X3),
  string_to_atom(X3,X2),
  atom_number(X2,X),

  fatores(X,L),
  soma(L,R),
  
  length(L,_length),
  nth1(_length,L,_last),
  Z is (R - _last),
  
  ((Z =:= X) -> writeln('true');writeln('false')),
  
  halt(0).