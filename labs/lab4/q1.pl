verifica(A, B, C, D, R) :- (D = 'and.'), A = 'true.', B = 'true.', C = 'true.', R = 'true'.
verifica(A, B, C, D, R) :- (D = 'or.'), (A = 'true.'; B = 'true.'; C = 'true.'), R = 'true'.
verifica(_, _, _, _, 'false').

:- initialization main.

main :-
  read_line_to_codes(user_input, T1),
  string_to_atom(T1, A),
  
  read_line_to_codes(user_input, T2),
  string_to_atom(T2, B),
  
  read_line_to_codes(user_input, T3),
  string_to_atom(T3, C),
  
  read_line_to_codes(user_input, T4),
  string_to_atom(T4, D),
  
  verifica(A, B, C, D, R),
 
  write(R), nl.