
%------------------------------ FATOS ------------------------------

novo_tabuleiro( [["-","1","2","3","4","5","6","7","8"],
                ["1","~","O","~","O","~","O","~","O"],
                ["2","O","~","O","~","O","~","O","~"],
                ["3","~","O","~","O","~","O","~","O"],
                ["4","~","~","~","~","~","~","~","~"],
                ["5","~","~","~","~","~","~","~","~"],
                ["6","X","~","X","~","X","~","X","~"],
                ["7","~","X","~","X","~","X","~","X"],
                ["8","X","~","X","~","X","~","X","~"]] ).


jogador("X").
jogador("O").


dama("Z").
dama("M").


espacoVazio("~").


alterna_jogador("X", "O").
alterna_jogador("O", "X").


damaDoJogador("X", "Z").
damaDoJogador("O", "M").


pecaDoOponente("X", "O").
pecaDoOponente("X", "M").
pecaDoOponente("Z", "O").
pecaDoOponente("Z", "M").
pecaDoOponente("O", "X").
pecaDoOponente("O", "Z").
pecaDoOponente("M", "X").
pecaDoOponente("M", "Z").

%------------------------------ DESENHANDO O TABULEIRO ------------------------------
 
desenha_tabuleiro([L1, L2, L3, L4, L5, L6, L7, L8, L9]) :-  
    desenha_linha(L1),
    desenha_linha(L2),  
    desenha_linha(L3),
    desenha_linha(L4),
    desenha_linha(L5), 
    desenha_linha(L6), 
    desenha_linha(L7), 
    desenha_linha(L8), 
    desenha_linha(L9), nl.  
  

desenha_linha([A1, A2, A3, A4, A5, A6, A7, A8, A9]) :-  
    write("      "),  
    write(A1), write("|"),  
    write(A2), write("|"),  
    write(A3), write("|"),
    write(A4), write("|"),
    write(A5), write("|"),
    write(A6), write("|"),
    write(A7), write("|"),
    write(A8), write("|"),
    write(A9), write("|"),  
    nl.  

%------------------------------ OBTENDO VALOR DE POSIÇÃO NO TABULEIRO ------------------------------

retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro) :-        
   nth0(Linha, Tabuleiro, LinhaLista),     
   nth0(Coluna, LinhaLista, Elemento).   

%------------------------------ VERIFICAÇÃO DE INDICES ------------------------------

verifica_indices_tabuleiro(Linha, Coluna, Resultado) :- 
    Linha >= 1, Linha =< 8, Coluna >= 1, Coluna =< 8, Resultado = "True".   
verifica_indices_tabuleiro(_, _, Resultado) :-
    Resultado =  "False".

%------------------------------ METODOS DE MODIFICAÇÃO DO TAABULEIRO ------------------------------

mudaColuna(Coluna, Index, Elemento, [T|[]], [N|Ns]) :-
    N = T.
mudaColuna(Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    Coluna =\= Index,
    mudaColuna(Coluna, Index+1, Elemento, Ts, Ns), 
    N = T.
mudaColuna(Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    mudaColuna(Coluna, Index+1, Elemento, Ts, Ns),
    N = Elemento. 


mudaLinha(_, _, _, _, [T|[]], [N|Ns]) :-
    N = T.
mudaLinha(Linha, Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    Linha =\= Index,
    mudaLinha(Linha, Coluna, (Index+1), Elemento, Ts, Ns), 
    N = T. 
mudaLinha(Linha, Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    mudaColuna(Coluna, 0, Elemento, T, N2), 
    mudaLinha(Linha, Coluna, (Index+1), Elemento, Ts, Ns),
    N = N2.


mudaPeca(Linha, Coluna, Elemento, Tabuleiro, NovoTabuleiro) :-
    jogador(Elemento),
    (Linha =:= 1 ; Linha =:= 8),
    damaDoJogador(Elemento, Dama),
    mudaLinha(Linha, Coluna, 0, Dama, Tabuleiro, NovoTabuleiro).
mudaPeca(Linha, Coluna, Elemento, Tabuleiro, NovoTabuleiro) :-
    mudaLinha(Linha, Coluna, 0, Elemento, Tabuleiro, NovoTabuleiro).

%------------------------------ VERIFICANDO SE AH VENCEDOR ------------------------------

verifica_tabuleiro(Peca, DamaPeca, [], "False") :- !.
verifica_tabuleiro(Peca, DamaPeca, [Cabeca|Cauda], Resultado) :-
    (member(Peca, Cabeca); member(DamaPeca, Cabeca)), Resultado = "True";
    verifica_tabuleiro(Peca, DamaPeca, Cauda, Resultado).

%------------------------------ REGRAS DE MOVIMENTAÇÃO DAS PEÇAS ------------------------------

jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 1,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'X' SE MOVE PARA A ESQUERDA"),nl.
jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -1,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'X' SE MOVE PARA A DIREITA"),nl.
jogadorXSeMove(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 2,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'X' COMEU PARA A ESQUERDA"),nl.
jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -2,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'X' COMEU PARA A DIREITA"),nl.
jogadorXCome(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 1,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'O' SE MOVE PARA A ESQUERDA"),nl.
jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -1,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'O' SE MOVE PARA A DIREITA"),nl.
jogadorOSeMove(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 2,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'O' COMEU PARA A ESQUERDA"),nl.
jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -2,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'O' COMEU PARA A DIREITA"),nl.
jogadorOCome(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= 1,
    Elemento = "X",   
    jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= -1,
    Elemento = "O",   
    jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= 2,
    Elemento = "X",
    jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= -2,
    Elemento = "O",
    jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    (Linha - NovaLinha =:= 1 ; Linha - NovaLinha =:= 2 ; Linha - NovaLinha =:= -1 ; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 1 ; Coluna - NovaColuna =:= -1 ; Coluna - NovaColuna =:= 2 ; Coluna - NovaColuna =:= -2),
    jogador(Elemento),
    pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    (Linha - NovaLinha =:= 1 ; Linha - NovaLinha =:= -1 ; Linha - NovaLinha =:= 2 ; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 1 ; Coluna - NovaColuna =:= -1 ; Coluna - NovaColuna =:= 2 ; Coluna - NovaColuna =:= -2),
    (Linha - NovaLinha =:= 2; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 2; Coluna - NovaColuna =:= -2),
    dama(Elemento),
    pulaDama(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pula(_, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.

%------------------------------ METODOS LOOP DO JOGO ------------------------------

verificaJogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador) :-
    Tabuleiro = NovoTabuleiro,
    Mensagem = "Jogada inválida!",
    NovoJogador = Jogador.
verificaJogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador) :- 
    Mensagem = "Jogada realizada!",
    alterna_jogador(Jogador, NovoJogador).


realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem) :-
    verifica_indices_tabuleiro(Linha, Coluna, Resultado1),
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, Resultado2),
    Resultado1 = "True",
    Resultado2 = "True",
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),
    damaDoJogador(Jogador, DamaJogador),
    ((Elemento = Jogador); (Elemento = DamaJogador)),
    retorna_valor_na_casa(NovaLinha, NovaColuna, ElementoVazio, Tabuleiro),
    espacoVazio(ElementoVazio),
    pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro),
    verificaJogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador).
realiza_jogada(_, _, _, _, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem) :-
    NovoTabuleiro = Tabuleiro,
    NovoJogador = Jogador,
    Mensagem = "Jogada inválida!".


inicia_jogo(Tabuleiro, Jogador):-
    desenha_tabuleiro(Tabuleiro),
    write("JOGADOR DA RODADA: "),
    write(Jogador), nl,
    pega_posicao(Linha, Coluna),
    pega_nova_posicao(NovaLinha, NovaColuna),
    realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem),
    write(Mensagem),nl,
    inicia_jogo(NovoTabuleiro, NovoJogador).

%------------------------------ METODOS DE INTERAÇÃO COM USUARIO ------------------------------

menu_opcao('1') :-
    novo_tabuleiro(Tabuleiro),
    inicia_jogo(Tabuleiro,"X").
menu_opcao('2') :-
    nl, print("_____________________________O QUE EH O JOGO?_______________________________"),
    nl, print("O jogo de damas eh constituido por um tabuleiro quadratico, dividido em 64 quadrados com 24 pecas, sendo 12 de cor branca e 12 de cor preta."),
    nl, print("Existem 8 linhas que estao na posicao vertical e 8 colunas na posicao horizantal. Dois jogadores 'O' e 'X', onde a dama de O é 'M' e a de X é 'Z'."),
    nl, print("______________________________  O OBJETIVO  ________________________________"),
    nl, print("Comer todas as pecas do adversario. Quem comer todas as pecas do adversario eh o vencedor!"),
    nl, print("______________________________REGRAS O JOGO_________________________________"),
    nl, print("1- Nao eh permitido peca normal comer ou andar para tras."),
    nl, print("2- Pode comer apenas uma peca."),
    nl, print("3- Pecas normais so andam uma casa por vez."),
    nl, print("4- O Jogo dura 10 ou mais minutos."),
    nl, print("5- Nao eh permitido jogar com uma peca do adversario."),
    nl, print("6- A dama pode comer ou andar para tras, porem, apenas uma casa por vez."),nl,nl.
menu_opcao(_) :-
    print("Opcao invalida, tenta de novo, parca!"),nl,
    main.
    
    
pega_posicao(Linha, Coluna):-
    print("Digite a linha na qual a peca se encontra:"),
    read_line_to_codes(user_input, A),
    string_to_atom(A,B),
    atom_number(B,Linha),
    print("Digite a coluna na qual a peca se encontra:"),
    read_line_to_codes(user_input, C),
    string_to_atom(C,D),
    atom_number(D,Coluna).


pega_nova_posicao(NovaLinha, NovaColuna):-
    print("Digite a linha que desejas para nova posicao da peca:"),
    read_line_to_codes(user_input, A),
    string_to_atom(A,B),
    atom_number(B,NovaLinha),
    print("Digite a coluna que desejas para nova posicao da peca:"),
    read_line_to_codes(user_input, C),
    string_to_atom(C,D),
    atom_number(D,NovaColuna).
    
%------------------------------ MAIN ------------------------------

:- initialization main.

main :-
    nl, print("Novo Jogo!"), nl,
    print("Escolha uma opcao (digite o numero): 1. Jogar | 2. Ajuda"),nl,
    read_line_to_codes(user_input, T1),
    string_to_atom(T1, A),
    menu_opcao(A),
    main,
    halt(0).
