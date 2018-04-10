
#include <bits/stdc++.h>

#define N 8

using namespace std;

int XDamaL, XDamaC,ODamaL, ODamaC;
char DamaX, DamaO;


// Constroi o tabuleiro
char **intitialize(){
  char **M;
  int i, j, k, l;

  //definindo tamanho do tabuleiro

  M = (char**)calloc(N, sizeof(char*));
  for(i=0; i<N; i++)
    M[i] = (char*)calloc(N, sizeof(char));

    /*
    posicionando as peças
  X = pretas,
  O = brancas,
  */

  //lista de coordenadas
  
  //peças pretas (X)
  for(i=0; i<3; i+=2)
    for(j=1; j<N; j+=2)
      M[i][j] = 'X';
  
  for(j=0; j<N; j+=2)
    M[1][j] = 'X';

  //peças brancas (O)
  for(i=5; i<N; i+=2)
    for(j=0; j<N; j+=2)
      M[i][j] = 'O';
  for(j=1; j<N; j+=2)
    M[6][j] = 'O';

  //espaços vazios entre as peças pretas
  for(i=0; i<3; i+=2)
    for(j=0; j<N; j+=2)
      M[i][j] = ' ';
  for(j=1; j<N; j+=2)
    M[1][j] = ' ';

  //espaços vazios entre as peças brancas
  for(i=5; i<N; i+=2)
    for(j=1; j<N; j+=2)
      M[i][j] = ' ';
  for(j=0; j<N; j+=2)
    M[6][j] = ' ';

  //demais espaços vazios
  for(i=3; i<5; i++)
    for(j=0; j<N; j++)
      M[i][j] = ' ';


  return M;
}

// imprime matriz
void printM(char **M){
  
  int i, j;

  printf("  1  2  3  4  5  6  7  8\n");
  for(i=0;i<N;i++){
    printf("%d",i+1);
    for(j=0; j<N; j++){
            printf("[%c]",M[i][j]);
        }

      printf("\n");

  }
  
}

int DamaVerifica(int i, int j,int lin,int col,char jogador){

    if ((jogador=='X' && i == 7) || (XDamaL==i && XDamaC==j)){
        return 1;
    }
    if ((jogador =='O' && i == 0) || (ODamaL==i && ODamaC==j)){
        return 1;
    }

    if (jogador=='X' && lin == 7) {
        return 2;
    }
    if (jogador =='O' && lin == 0) {
        return 2;
    }

    return 0;

}

//define regras do jogo, como: evitar usar casas fora do tabuleiro, como a peça pode andar e comer.
int step(char **M, int i, int j, int lin, int col, char jogador){


  int VDama;
  VDama = DamaVerifica(i,j,lin,col,jogador);

  //limitando tabuleiro. -Funcionando.
  if(lin < 0 || lin >= N || col < 0 || col >= N)
        return 0;
  //Checando se a peça que está na casa escolhida é a o jogador. 
    if(M[i][j] != jogador)
      return 0;


  //Peças Brancas.
  //Proibindo peças de andarem para trás e para os lados. 
    if(jogador == 'O'){
      if(lin >= i && (VDama==0 || VDama==2))
        return 0;

    //Proibindo peças de andar para frete.
      if(col == j)
        return 0;

      //Permitindo avançar apenas 1 casa ou avançar 2 no caso da ação "COMER".
      if (VDama==0 || VDama==2 ){

        if(lin <= i - 2 || col <= j-2 || col >= j+2){
          if(M[lin][col] == 'X')
            return 0;

          if(M[lin+1][col-1] == 'X')
            return 1;
          else if (M[lin+1][col+1] == 'X')
            return 1;
          else 
            return 0;
          if(M[lin][col] == 'X')
          return 0;
        }
      }
      //Não permitindo peça sobrepor peça adversária.
      if(M[lin][col] == 'O' || M[lin][col] == 'X')
          return 0;
    
    if (VDama==1){
      ODamaL = lin;
        ODamaC = col;
      } 
    }

  //Peças Pretas.
  //Proibindo peças de andarem para trás e para os lados. 
    if(jogador == 'X'){
      if(lin <= i && (VDama==0 || VDama==2))
        return 0;

    //Proibindo peças de andar para frete.
      if(col == j)
        return 0;

      if (VDama==0 || VDama==2){
        //Permitindo avançar apenas 1 casa ou avançar 2 no caso da ação "COMER"
        if(lin <= i - 2 || col <= j-2 || col >= j+2){
          if(M[lin][col] == 'O')
            return 0;

          if(M[lin-1][col-1] == 'O')
            return 1;
          else if (M[lin-1][col+1] == 'O')
            return 1;
          else 
            return 0;
        }
      }
      //Não permitindo peça sobrepor peça adversária.
      if(M[lin][col] == 'O' || M[lin][col] == 'X')
          return 0;
    
      
    if (VDama==1){
        XDamaL= lin;
      XDamaC= col;
    } 

    }    

    
  M[i][j] = jogador;

  return 1;
}
//Complemento status.
int statusJogador(char **M, char jogador){
  int i;
  for(i=0; i<N; i++)
    if( M[i][0] == jogador || M[i][1] == jogador || M[i][2] == jogador || M[i][3] == jogador || 
      M[i][4] == jogador || M[i][5] == jogador || M[i][6] == jogador || M[i][7] == jogador)
        return 1;
  return 0;
}

/*
Verifica se o jogo pode ou não continuar
caso as peças acabem ou não possam mais se mover.
*/
int status(char **M){

  /* -1 = Jogo continua
      0 = Brancas ganham.
      1 = Pretas ganham.
  */

  if(statusJogador(M, 'O'))
    return -1;
  else 
    return 0;

  if(statusJogador(M, 'P'))
    return -1;
  else
    return 1;

}

//Move a Peca
void movePeca(char **M, int i, int j, int lin, int col, char jogador){

  int VDama;

  VDama = DamaVerifica(i,j,lin,col,jogador);

  if (VDama==2){
    if (jogador=='X'){
      M[lin][col] = 'Z';
    }else{
      M[lin][col] = 'P';
    }
  }else{  
    M[lin][col] = M[i][j];
  }

  M[i][j] = ' ';

  //Come peça.
  if(jogador == 'O'){
    
    if (VDama==0){

      if(lin == i - 2 && col == j-2){
        if(M[lin+1][col+1] == 'X')
          M[lin+1][col+1] = ' ';
      }else if (col == j+2 && lin == i - 2){
        if(M[lin+1][col-1] == 'X')
          M[lin+1][col-1] = ' ';  
      }
    }else {

      if (lin < i && col < j){
        if(M[lin+1][col+1] == 'X')
          M[lin+1][col+1] = ' ';
      }   
        
      
      if (lin < i && col > j){
        if(M[lin+1][col-1] == 'X')
          M[lin+1][col-1] = ' ';
      }

      if (lin>i && col >j){
        if(M[lin-1][col-1] == 'X')
          M[lin-1][col-1] = ' ';  
      }

      if (lin > i && col < j){
        if(M[lin-1][col+1] == 'X')
          M[lin-1][col+1] = ' ';
      }

    }
  
  }

  if(jogador == 'X'){
    
    if (VDama==0){
      if(lin == i + 2 && col == j-2){
        if(M[lin-1][col+1] == 'O')
          M[lin-1][col+1] = ' ';
      }else if (col == j+2 && lin == i + 2){
        if(M[lin-1][col-1] == 'O')
          M[lin-1][col-1] = ' ';
      }
    
    }else {

      if (lin < i && col < j){
        if(M[lin+1][col+1] == 'O')
          M[lin+1][col+1] = ' ';
      }   
        
      
      if (lin < i && col > j){
        if(M[lin+1][col-1] == 'O')
          M[lin+1][col-1] = ' ';
      }

      if (lin>i && col >j){
        if(M[lin-1][col-1] == 'O')
          M[lin-1][col-1] = ' ';  
      }

      if (lin > i && col < j){
        if(M[lin-1][col+1] == 'O')
          M[lin-1][col+1] = ' ';
      }


    }

  }
}

void gamepc(char **M){
	int i, j, k;
	for(i=0; i < N; i++) {
		for(k=0; k < N; k++) {
			if(M[i][k] == 'X') {
				if(M[i+1][k+1] == 'O' && M[i+2][k+2] == ' ') {
						movePeca(M, i, k, i+2, k+2, 'X');
						return;
				} else if (M[i+1][k-1] == 'O' && M[i+2][k-2] == ' ') {
						movePeca(M, i, k, i+2, k-2, 'X');
						return;
				}
			}
		}
  }

  for(i=0; i < N; i++) {
		for(j=0; j < N; j++) {
			if(M[i][j] == 'X') {
				if(M[i+1][j+1] == ' ') {
					movePeca(M, i, j, i+1, j+1, 'X');
					return;
				} else if (M[i+1][j-1] == ' ') {
					movePeca(M, i, j, i+1, j-1, 'X');
					return;
				}

			}
		}
	}
}


/*Função que aplica a lógica do jogo, que alterna a rodada de cada jogador e
que imprime o tabuleiro atualizado a cada rodada.
*/

void game(){
  char **M;
  char **tabuleiro;
  char jogador = 'O';
  //escolhe a peça
  int i, j;
  //escolhe a casa
  int lin, col;
  
  int opcaoDeJogabilidade;
  
  char msg[][20]={"ocorreu um empate","jogador O venceu","jogador X venceu"};

  intitialize();
  
  tabuleiro = intitialize();

  int jogoAtivo = -1;
			
	printf("\n\n\t\t\tSelecione o modo de jogo:\n");
	printf("\n\t\t\t1- Dois Jogadores.\n\t\t\t2- Jogar contra a maquina.\n\n");
	printf("\n\t\t\tOpcao: ");
	scanf("%d", &opcaoDeJogabilidade);
	printf("\n\n\n");
            
  //loop jogo
  while(jogoAtivo == -1){
    
    
    if(opcaoDeJogabilidade == 2 && jogador == 'X') {
		
		gamepc(tabuleiro);
		jogoAtivo = status(tabuleiro);
    } else {
		printM(tabuleiro);
		printf("jogador %c digite linha e coluna selecionar peça: ", jogador);
		scanf("%d %d", &i, &j);
		printf("escolha casa para a qual a peça devera se mover: ");
		scanf("%d %d", &lin, &col);
		// se nao posso prosseguir
        if( !step(tabuleiro, i-1, j-1, lin-1, col-1, jogador) ){
            printf("\njogada invalida !\n");
            continue;
        }
		movePeca(tabuleiro,i-1, j-1, lin-1, col-1, jogador);
		jogoAtivo = status(tabuleiro);
	}


    //alternando jogadores.
    if(jogador == 'O')
            jogador = 'X';
        else
            jogador = 'O';
  
  }
  printf("\n%s\n", msg[jogoAtivo]);
}

int main(void){
	
	  int opcao_selecionada;
	  printf("\n\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________        UFCG        ____________________\n");
      printf("\t__________________    PROJETO APLP    ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________        DAMAS       ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n\t\t\t\t\t\n");
       do {
      printf("\tEscolha uma das opcoes abaixo:\n\n");
      printf("\t 1- Jogar.\n\t 2- Ajuda.\n\t 3- Sair.\n\n");
      printf("\tOpcao: ");

      scanf("%d", &opcao_selecionada);
   

      switch(opcao_selecionada) {
        case 1:	
        
			game();
            
        case 2:

            printf("\n_____________________________O QUE EH O JOGO?_______________________________");
            printf("\n\n\t     O jogo de Damas eh constituido por um tabuleiro quadratico,\n\tdividido em 64 quadrados com 24 pecas, sendo 12 de cor branca\n\te 12 de cor preta. Exitem  8 linhas que estao na posicao vertical,\n\te com 8 colunas na posicao horizantal.\n");
            printf("\n_____________________________  O OBJETIVO  _______________________________");
            printf("\n\n\t      Comer o maior numero de pecas possiveis do adversario. Quem \n\tdurante os 3 minutos tiver mais pecas, eh o vencedor!\n\n");
            printf("\n______________________________REGRAS O JOGO_________________________________");
            printf("\n\n\t1- Nao eh permitido comer para tras.\n\t2- Pode comer uma peca, nao duas de uma vez.\n\t3- Soh anda uma casa por vez.\n\t4- O Jogo dura 3 Minutos.\n\t5- Nao eh permitido jogar com uma peca do adversario.\n");
            printf("____________________________________________________________________________\n\n");
           
            break;

        
        case 3:
            printf("\n\n\n\n\t\t\t  FIM DO JOGO\n\n\n\n\n");
            break;
    }
  } while(opcao_selecionada != 3);

 

  return 0;
}
