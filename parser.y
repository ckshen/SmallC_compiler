%{
	#include "parser.h"
	void yyerror(char *);
	int indent;
	FILE *fout;
	void toString(Node *);
	extern Node* setNode(char *n,char *v,Node *l,Node *r);
%}


%token <e_node>SEMI
%token <e_node>COMMA
%token <e_node>DOT
%token <e_node>ASSIGNOP
%token <e_node>LP
%token <e_node>RP
%token <e_node>LB
%token <e_node>RB
%token <e_node>LC
%token <e_node>RC
%token <e_node>TYPE
%token <e_node>STRUCT
%token <e_node>RETURN
%token <e_node>IF
%token <e_node>ELSE
%token <e_node>BREAK
%token <e_node>CONT
%token <e_node>FOR
%token <e_node>INT
%token <e_node>ID
%token <e_node>UNARYOP
%token <e_node>BOP1
%token <e_node>BOP2
%token <e_node>BOP3
%token <e_node>BOP4
%token <e_node>BOP5
%token <e_node>BOP6
%token <e_node>BOP7
%token <e_node>BOP8
%token <e_node>BOP9
%token <e_node>BOP10
%token <e_node>BOP11

%type <e_node>PROGRAM
%type <e_node>EXTDEFS
%type <e_node>EXTDEF
%type <e_node>EXTVARS
%type <e_node>SPEC
%type <e_node>STSPEC
%type <e_node>OPTTAG
%type <e_node>VAR
%type <e_node>FUNC
%type <e_node>PARAS
%type <e_node>PARA
%type <e_node>STMTBLOCK
%type <e_node>STMTS
%type <e_node>STMT
%type <e_node>ESTMT
%type <e_node>DEFS
%type <e_node>DEF
%type <e_node>DECS
%type <e_node>DEC
%type <e_node>INIT
%type <e_node>EXP
%type <e_node>ARRS
%type <e_node>ARGS

%nonassoc EMPTY
%nonassoc ELSE

%left	BOP11
%right	BOP10
%right	BOP9
%right	BOP8
%right	BOP7
%right	BOP6
%right	BOP5
%right	BOP4
%right	BOP3
%right	BOP2
%right	BOP1
%left	UNARYOP
%right  DOT


%%

PROGRAM:
EXTDEFS		{$$ = setNode("PROGRAM","",$1,NULL);indent = 0;toString($$);}
;
EXTDEFS:
EXTDEF EXTDEFS {$$ = setNode("EXTDEFS","",$1,NULL);$1->rBro = $2;}
| {$$ = setNode("EXTDEFS","",NULL,NULL);}
;
EXTDEF:
SPEC EXTVARS SEMI  {$$ = setNode("EXTDEF","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| SPEC FUNC STMTBLOCK {$$ = setNode("EXTDEF","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
;
EXTVARS:
DEC {$$ = setNode("EXTVARS","",$1,NULL);}
| DEC COMMA EXTVARS {$$ = setNode("EXTVARS","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
|%prec EMPTY {$$ = setNode("EXTVARS","",NULL,NULL);}
;
SPEC:
TYPE {$$ = setNode("SPEC","",$1,NULL);}
| STSPEC {$$ = setNode("SPEC","",$1,NULL);}
;
STSPEC:
STRUCT OPTTAG LC DEFS RC {$$ = setNode("STSPEC","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;$4->rBro = $5;}
| STRUCT ID {$$ = setNode("STSPEC","",$1,NULL);$1->rBro = $2;}
;
OPTTAG:
ID {$$ = setNode("OPTTAG","",$1,NULL);}
| %prec EMPTY {$$ = setNode("OPTTAG","",NULL,NULL);}
;
VAR:
ID {$$ = setNode("VAR","",$1,NULL);}
| VAR LB INT RB {$$ = setNode("VAR","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;}
;
FUNC:
ID LP PARAS RP {$$ = setNode("FUNC","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;}
;
PARAS:
PARA COMMA PARAS {$$ = setNode("PARAS","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| PARA {$$ = setNode("PARAS","",$1,NULL);}
| {$$ = setNode("PARAS","",NULL,NULL);}
;
PARA:
SPEC VAR {$$ = setNode("PARA","",$1,NULL);$1->rBro = $2;}
;
STMTBLOCK:
LC DEFS STMTS RC {$$ = setNode("STMTBLOCK","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;}
;
STMTS:
STMT STMTS {$$ = setNode("STMTS","",$1,NULL);$1->rBro = $2;}
| {$$ = setNode("STMTS","",NULL,NULL);}
;
STMT:
EXP SEMI {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;}
| STMTBLOCK {$$ = setNode("STMT","",$1,NULL);}
| RETURN EXP SEMI {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| IF LP EXP RP STMT ESTMT {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;$4->rBro = $5;$5->rBro = $6;}
| FOR LP EXP SEMI EXP SEMI EXP RP STMT {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;$4->rBro = $5;$5->rBro = $6;$6->rBro = $7;$7->rBro = $8;$8->rBro = $9;}
| CONT SEMI {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;}
| BREAK SEMI {$$ = setNode("STMT","",$1,NULL);$1->rBro = $2;}
;
ESTMT:
ELSE STMT {$$ = setNode("ESTMT","",$1,NULL);$1->rBro = $2;}
|%prec EMPTY {$$ = setNode("ESTMT","",NULL,NULL);}
;
DEFS:
DEF DEFS {$$ = setNode("DEFS","",$1,NULL);$1->rBro = $2;}
| {$$ = setNode("DEFS","",NULL,NULL);}
;
DEF:
SPEC DECS SEMI {$$ = setNode("DEF","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
;
DECS:
DEC COMMA DECS {$$ = setNode("DECS","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| DEC {$$ = setNode("DEF","",$1,NULL);}
;
DEC:
VAR {$$ = setNode("DEC","",$1,NULL);}
| VAR ASSIGNOP INIT {$$ = setNode("DEC","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
;
INIT:
EXP {$$ = setNode("INIT","",$1,NULL);}
| LC ARGS RC {$$ = setNode("INIT","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
;
EXP:
EXP BOP1 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP2 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP3 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP4 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP5 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP6 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP7 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP8 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP9 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP10 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP BOP11 EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| UNARYOP EXP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;}
| LP EXP RP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| ID LP ARGS RP {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;}
| ID ARRS {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;}
| EXP DOT ID {$$ = setNode("EXP","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| INT {$$ = setNode("EXP","",$1,NULL);}
| %prec EMPTY{$$ = setNode("EXP","",NULL,NULL);}
;
ARRS:
LB EXP RB ARRS {$$ = setNode("ARRS","",$1,NULL);$1->rBro = $2;$2->rBro = $3;$3->rBro = $4;}
| {$$ = setNode("ARRS","",NULL,NULL);}
;
ARGS:
EXP COMMA ARGS {$$ = setNode("ARGS","",$1,NULL);$1->rBro = $2;$2->rBro = $3;}
| EXP {$$ = setNode("ARGS","",$1,NULL);}
;

%%
void toString(Node *n){
	int i = 0;
	for (i = 0; i < indent; ++i)
		fprintf(fout,"\t");
	if (n->value != "")
		fprintf(fout,"%s =========> %s\n", n->name,n->value);
	else fprintf(fout,"%s\n", n->name);
	++indent;
	if (n->lSon!=NULL)
		toString(n->lSon);
	--indent;
	if (n->rBro!=NULL)
		toString(n->rBro);
}

void yyerror(char *s){
	fprintf(stderr,"%s\n", s);
}
int main(int argc, char *argv[]){
	freopen(argv[1], "r", stdin);
	fout = fopen(argv[2], "w");
	if (!yyparse())
		fprintf(fout, "Parsing complete.\n");
	else fprintf(fout, "Error.\n");
	fclose(fout);
	return 0;
}
