#include <iostream>
#include <stdio.h>
#include <stdlib.h>


long long fib(int n){
	if(n == 0){
		return 0;
	}
	else if (n == 1 || n == 2){
		return 1;
	} else {
		return fib(n-1) + fib(n-2);
	}
}

int main(){
	long long num1, num2, num3;
	scanf("%lld", &num1);
	num2 = num1 + 1;
	num3 = num2 + 1;

	num1 = fib(num1);
	num2 = fib(num2);
	num3 = fib(num3);

	long long result = (num1 % 10) + (num2 % 10) + (num3 % 10);

	printf("%lld\n", result);
}