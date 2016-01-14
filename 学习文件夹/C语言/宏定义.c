
#include<stdio.h>

#define Y 60
#define Add(a,b) a+b
int main(){
	printf("我是main函数%d\n",Y);
	float number= Add(10.1,20.5);
	printf("我是number=%f\n",number);
	return 0;
}
