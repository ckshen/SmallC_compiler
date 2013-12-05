%{
	#include "parser.h"
	void yyerror(char *);
	#include "parser.tab.h"
	Node* setNode(char *n,char *v,Node *l,Node *r);
%}

dec	([0-9])+
oct ([0-7])+
hex 0(x|X)([0-9a-fA-F])+
identifier	[_A-Za-z][_A-Za-z0-9]*
whiteSpace	[ \f\r\t\v]+		
uop			"-"|"!"|"++"|"--"|"~"
bop1		"*"|"/"|"%"
bop2		"+"|"-"
bop3		"<<"|">>"
bop4		">"|">="|"<"|"<="
bop5		"=="|"!="
bop6		"&"
bop7		"^"
bop8		"|"
bop9 		"&&"
bop10		"||"
bop11 		"+="|"-="|"*="|"/="|"&="|"^="|"|="|"<<="|">>="

%%

\n 				{}
";"				{yylval.e_node = setNode("SEMI",";",NULL,NULL);return (SEMI);}
","				{yylval.e_node = setNode("COMMA",",",NULL,NULL);return (COMMA);}
"."				{yylval.e_node = setNode("DOT",".",NULL,NULL);return (DOT);}
"="				{yylval.e_node = setNode("ASSIGNOP","=",NULL,NULL);return (ASSIGNOP);}
"("				{yylval.e_node = setNode("LP","(",NULL,NULL);return (LP);}
")"				{yylval.e_node = setNode("RP",")",NULL,NULL);return (RP);}
"["				{yylval.e_node = setNode("LB","[",NULL,NULL);return (LB);}
"]"				{yylval.e_node = setNode("RB","]",NULL,NULL);return (RB);}
"{"				{yylval.e_node = setNode("LC","{",NULL,NULL);return (LC);}
"}"				{yylval.e_node = setNode("RC","}",NULL,NULL);return (RC);}
int				{yylval.e_node = setNode("TYPE","int",NULL,NULL);return (TYPE);}
struct			{yylval.e_node = setNode("STRUCT","struct",NULL,NULL);return (STRUCT);}
return			{yylval.e_node = setNode("RETURN","return",NULL,NULL);return (RETURN);}
if				{yylval.e_node = setNode("IF","if",NULL,NULL);return (IF);}
else			{yylval.e_node = setNode("ELSE","else",NULL,NULL);return (ELSE);}
break			{yylval.e_node = setNode("BREAK","break",NULL,NULL);return (BREAK);}
continue		{yylval.e_node = setNode("CONT","continue",NULL,NULL);return (CONT);}
for				{yylval.e_node = setNode("FOR","for",NULL,NULL);return (FOR);}
{whiteSpace}	{}
{oct}			{yylval.e_node = setNode("INT",strdup(yytext),NULL,NULL);return(INT);}
{dec}			{yylval.e_node = setNode("INT",strdup(yytext),NULL,NULL);return(INT);}
{hex}			{yylval.e_node = setNode("INT",strdup(yytext),NULL,NULL);return(INT);}
{identifier}	{yylval.e_node = setNode("ID",strdup(yytext),NULL,NULL);return(ID);}
{uop}			{yylval.e_node = setNode("UNARYOP",strdup(yytext),NULL,NULL);return (UNARYOP);}
{bop1}			{yylval.e_node = setNode("BOP1",strdup(yytext),NULL,NULL);return(BOP1);}
{bop2}			{yylval.e_node = setNode("BOP2",strdup(yytext),NULL,NULL);return(BOP2);}
{bop3}			{yylval.e_node = setNode("BOP3",strdup(yytext),NULL,NULL);return(BOP3);}
{bop4}			{yylval.e_node = setNode("BOP4",strdup(yytext),NULL,NULL);return(BOP4);}
{bop5}			{yylval.e_node = setNode("BOP5",strdup(yytext),NULL,NULL);return(BOP5);}
{bop6}			{yylval.e_node = setNode("BOP6",strdup(yytext),NULL,NULL);return(BOP6);}
{bop7}			{yylval.e_node = setNode("BOP7",strdup(yytext),NULL,NULL);return(BOP7);}
{bop8}			{yylval.e_node = setNode("BOP8",strdup(yytext),NULL,NULL);return(BOP8);}
{bop9}			{yylval.e_node = setNode("BOP9",strdup(yytext),NULL,NULL);return(BOP9);}
{bop10}			{yylval.e_node = setNode("BOP10",strdup(yytext),NULL,NULL);return(BOP10);}
{bop11}			{yylval.e_node = setNode("BOP11",strdup(yytext),NULL,NULL);return(BOP11);}

%%

Node* setNode(char *n,char *v,Node *l,Node *r){
	Node *ret;
	ret = (Node *)malloc(sizeof(Node));
	ret->name = n;
	ret->value = v;
	ret->lSon = l;
	ret->rBro = r;
	return ret;
}


int yywrap(){
	return 1;
}
