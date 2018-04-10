#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>

using namespace std;

int main(){
	string chave;
	cin >> chave;

	int casos;
	cin >> casos;

	for (int i = 0; i < casos; i++){
		string nome;
		cin >> nome;
		int inf = 0;
		for(int j = 0; j < nome.length(); j++){
			if(chave[inf] == nome[j]){ 
				inf += 1;
			} else {
				inf = 0;
			}
			if(chave.length() == inf){
				while(inf){
					nome[j-inf+1] = chave[inf-1];
					inf--;
				}
			}
		}
		cout << nome << endl;
	}


	return 0;
}