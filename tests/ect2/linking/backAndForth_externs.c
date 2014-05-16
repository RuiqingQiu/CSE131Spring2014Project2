# include <stdio.h>
extern void forth();
void back(){
    printf("back");
    forth();
}
