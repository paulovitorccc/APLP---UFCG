filme(chicago, musical,marshall, 2003, 109).
filme(amnesia, suspense, nolan, 2000, 113).
filme(babel, drama, inarritu, 2006, 142).
filme(senhorDosAneis, fantasia, jackson, 2004, 201).
filme(capote, drama, miller, 2005, 98).
filme(casablanca, romance, curtiz, 1942, 102).
filme(belezaAmericana, drama, mendes, 2000, 122).
filme(matrix, ficcao, wachowsk, 1999, 136).
filme(meninaDeOuro, drama, clint, 2005, 132).
filme(shrek, animacao, adamson, 2001, 90).
filme(titanic, drama, cameron, 1997, 194).
filme(gladiador, drama, scott, 2001, 155).
filme(umaMenteBrilhante, drama, howard, 2002, 135).

winner(belezaAmericana, 2000).
winner(gladiador, 2001).
winner(umaMenteBrilhante, 2002).
winner(chicago, 2003).
winner(senhorDosAneis, 2004).
winner(meninaDeOuro, 2005).

dirigiu(F, D) :- filme(F, _, D1, _, _), D = D1.
genero(F, G) :- filme(F, G1, _, _, _), G = G1.
diretorMelhorFilme(A,D) :- winner(F, A), filme(F, _, D, _, _).
melhorFilme(D) :- diretorMelhorFilme(_, D),!.