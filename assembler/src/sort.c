#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUM_OPS 38

char* OP_LEXEMES[NUM_OPS]={
"add","addi","and","andi",
"auipc","beq","bge","bgeu",
"blt","bltu","bne","jal",
"jalr","lb","lbu","lh",
"lhu","lui","lw","or",
"ori","sb","sh","sll",
"slli","slt","slti","sltiu",
"sltu","sra","srai","srl",
"srli","sub","sw","xor",
"xori","$stop"};

static int compare(const void* a, const void* b)
{
    // setting up rules for comparison
    return strcmp(*(const char**)a, *(const char**)b);
}



int main(){



    qsort(OP_LEXEMES,NUM_OPS,sizeof(const char*),compare) ;

    for (int i = 0; i < NUM_OPS; i++){
        printf("%s\n",OP_LEXEMES[i]);
    }
    
}


