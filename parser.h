/*
	This is a head file that both lex
	program and yacc program included
*/


#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifndef MAIN_H
#define MAIN_H

typedef struct node{
	char *name;
	char *value;
	struct node *lSon,*rBro;
} Node;

typedef struct elem
{
	Node *e_node;
} ELEM;
#define YYSTYPE ELEM
#endif
