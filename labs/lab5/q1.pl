
:- initialization main.

main :-
	read(T),
	max_list(T,Max),
	min_list(T,Min),
	sum_list(T,Sum),
	R is (Max-Min + Sum),
	write(R), nl.
