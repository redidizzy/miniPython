%{
#include<stdio.h> 	
#include <stdlib.h>
#include <string.h>
#include "quadP.h"
extern FILE* yyin;
extern int yyaccept;

int qc=0;
int saveIf=0;
int saveElif=0;
int saveElse=0;
int saveFinIf=0;
char saveOp = null;
int quadOp = 0;
%}

%token <chaine>idf <chaine>comentaire <chaine>mc_entier dp <chaine>mc_if <chaine>mc_elif <chaine>mc_else <entier>valE egal moins virgule 
%token plus divis fois aff inferieur superieur infegal supegal different parouvr parferm espace retour tabulation

%left infegal supegal superieur inferieur egal different
%left plus moins
%left fois divis

%union{
int entier;
char* chaine;
}
%start S
%%
S: DEC INST{printf("Programme syntaxiquement correcte\n"); YYACCEPT;}
;
DEC: TYPE espace LISTEIDF DEC 
   |TYPE LISTEVAL DEC
   |
;
TYPE: mc_entier
;
LISTEIDF: idf virgule LISTEIDF
		| idf
;
LISTEVAL: idf aff valE virgule LISTEVAL
		| idf aff valE
;
INST: AFFEC retour
		| IF retour
		| IF ELIF ELSE retour
		|
		
;		
AFFEC: idf aff EXP{quadr("=",$3,"",$1);}
;
EXP: A EXP
	|B
	|C EXP parferm
;
A: B OP{quadOp = qc; quadr(saveOP, "", "", ""); }
;
B:OPERANDE{ajour_quad(quadOp)}
;
C:parouvr A
;
OP: plus{strcpy(saveOP, "+");}
	|moins{strcpy(saveOP, "-");}
	|divis{strcpy(saveOP, "/");}
	|fois{strcpy(saveOP, "*");}
;
COMP: EXP OUTILCOMP EXP
;	
OPERANDE: idf
		|valE
;
OUTILCOMP: supegal
		| infegal
		| inferieur
		| superieur
		| different
		| egal
;		
		
IF: mc_if CONDITION SUITE
;
ELIF: mc_elif CONDITION SUITE
;
ELSE: mc_else SUITE
;
CONDITION: parouvr COMP parferm

SUITE: dp retour tabulation INST
		
%%

main ()
{
	
yyin=fopen("test.txt","r");
if(yyin==NULL){ printf("erreur d'ouverture");}
yyparse();
/*afficher_qdr();*/
printf("\n \n");


}
	yywrap()
	{
		
	}
	int yyerror(char*  msg )
	{
		printf("erreur syntaxique ligne %d colonne %d", numLigne(), numCol());
	}
