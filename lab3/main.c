#include <stdio.h>

int fexp(int a, int b){
if(b == 0) return 1;
int tmp = fexp(a,b/2);
tmp = tmp*tmp;
if(b % 2 == 1) tmp=tmp*a;
return tmp;
}

int main(){
    int num = 545648;
    int comp = fexp(2,32) - num;
    comp = fexp(2,32);
    printf("%i", comp);
    return 0;
}
