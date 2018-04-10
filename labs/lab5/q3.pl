removerTodas(_,[],[]).
removerTodas(Val,[Val|Tail],L) :- removerTodas(Val,Tail,L).
removerTodas(Val,[Val1|Tail], [Val1|Tail1]) :- Val \== Val1, removerTodas(Val,Tail,Tail1).

removerRep([],[]).
removerRep([Val|Tail], [Val|Tail1]) :- removerTodas(Val,Tail,List), removerRep(List,Tail1).

:- initialization main.

main :-
  read(A),
  removerRep(A, R),
  write(R), nl.