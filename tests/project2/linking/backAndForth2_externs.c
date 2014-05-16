# include <stdio.h>
extern void forth(int x);
void back(int x){
    printf("back %d", x);
    forth(x+1);
}
