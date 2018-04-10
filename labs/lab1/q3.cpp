#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>

using namespace std;

int main(){
	int tam;
	scanf("%d", &tam);

	int matriz[tam][tam];
	int index = 0;
	while(index < tam){
		for(int i = 0; i < tam; i++){
			int num;
			scanf("%d", &num);
			matriz[index][i] = num;
		}
		index++;
	}
	bool aux = true;
	int somaColunas = 0;
	int somaLinhas = 0;
	for(int k = 0; k < tam; k++){ 
		int somaColunasAtual = 0;
		for(int l = 0; l < tam; l++){
			somaColunasAtual += matriz[l][k];
		}
		if(k == 0){
			somaColunas = somaColunasAtual;
		}
		if(somaColunas != somaColunasAtual){
			aux = false;
			break;
		}

		
		int somaLinhasAtual = 0;
		for(int o = 0; o < tam; o++){
			somaLinhasAtual += matriz[k][o];
		}
		if(k == 0){
			somaLinhas = somaLinhasAtual;
		}
		if(somaLinhas != somaLinhasAtual){
			aux = false;
			break;
		}

	}



	if(aux){
		printf("True\n");
	} else {
		printf("False\n");
	}


	return 0;
}