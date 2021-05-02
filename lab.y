%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "myheader.h"

	int yylex(void);
	void yyerror(char *);
	void new_var(char * , nodeEnum );
	int yylineno;
	void freeVAR(struct variable *p);
	int seach(char * p);
%}

%union {
	int I_value;
	char C_value;
	char * ID;
};

%token <I_value>INTEGER
%token <ID>IDENTIFIER
%token <C_value>CHARACTER
%token Y_INT Y_CHAR
%token WHILE IF OUTPUT OUTPUTC READ READC ELSE INCLUDE HEADER
%nonassoc IFX
%nonassoc ELSE


%left GE LE EQ NE '>' '<'
%left '+' '-'
%left '*' '/' '%'
%nonassoc UMINUS


%%

program:
        function                {/*printf("ssss");*/ freeVAR(ptr); exit(0); }
        
        ;

function:
          function stmt         { ; }
         | function Y_CHAR IDENTIFIER '\n' { new_var($3, CHAR); }
		 | function Y_INT IDENTIFIER '\n' { /*printf("y_int\n");*/ new_var($3, INT); }
		 |  function INCLUDE HEADER '\n' {}
		 |
        ;

stmt:
	'\n' { ; }
	| READ '(' IDENTIFIER ')' '\n'   { switch (seach($3)){
														case CHAR:{
															printf("In the line: %d.\nVariable %s of type \"y_char\" cannot be used in function read.",yylineno,$3);
															yyerror("");
														}
														case UNDEC:{
															printf("In the line: %d.\n%s ",yylineno,$3);
															yyerror("is Undeclared variable.");
															break;
														}
														case INT: {
															break;
														}
													} }
	| READC '(' IDENTIFIER ')' '\n'	 { switch (seach($3)){
														case CHAR:{
															break;
														}
														case UNDEC:{
															printf("In the line: %d.\n%s ",yylineno,$3);
															yyerror("is Undeclared variable.");
															break;
														}
														case INT : {
															printf("In the line: %d.\nVariable %s of type \"y_int\" cannot be used in function readc.",yylineno,$3);
															yyerror("");
															break;
														}
													} }
	| OUTPUT '('expr')' '\n' 		 { ; }
	| OUTPUTC '('cexpr')' '\n'	 { ; }
    | WHILE '(' expr ')' '\n' stmt        { ; }
    | IF '(' expr ')' '\n' stmt %prec IFX { ; }
    | IF '(' expr ')' '\n' stmt ELSE stmt { ; }
    | '{' stmt_list '}' '\n'	     { ; }
	| IDENTIFIER '=' expr '\n' {/*printf("I = ex\n");*/ switch (seach($1)){
														case CHAR:{
															printf("In the line: %d.\ncannot assign statement of type \"y_int\" to variable \"%s\" of type \"y_char\".",yylineno-1,$1);
															yyerror("");
															break;
														}
														case UNDEC:{
															printf("In the line: %d.\n%s ",yylineno,$1);
															yyerror("is Undeclared variable.");
															break;
														}
														case INT : {
															break;
														}
													}
						 		}
	| IDENTIFIER '=' CHARACTER '\n' {/*printf("ID=char\n");*/ switch (seach($1)){
										case CHAR:{
											break;
										}
										case UNDEC:{
											printf("In the line: %d.\n%s ",yylineno,$1);
											yyerror("is Undeclared variable.");
											break;
										}
										case INT : {
											printf("In the line: %d.\ncannot assign statement \"%c\" of type \"y_char\" to variable \"%s\" of type \"y_int\".",yylineno-1,$3,$1);
											yyerror("");
											break;
										} 
									}
								}
	;

stmt_list:
          stmt                  { ; }
        | stmt_list stmt        { ; }
        ;

cexpr:
   	CHARACTER { ; }
	| IDENTIFIER { /*printf("cexpr\n");*/ switch ( seach($1)){
										case CHAR:{
											break;
										}
										case UNDEC:{
											printf("In the line: %d.\n%s ",yylineno,$1);
											yyerror("is Undeclared variable.");
											break;
										}
										case INT : {
											printf("In the line: %d.\n%s ",yylineno,$1);
											yyerror("is a Variable of type \"y_int\" cannot be used in this expression.");
											break;
										} 
									}
				}
	;
expr:
	INTEGER			{ ; }
	| IDENTIFIER 	{ //printf("expr\n");
						switch (seach($1)){
							case CHAR:{
								printf("In the line: %d.\n%s ",yylineno,$1);
								yyerror("is a Variable of type \"y_char\" cannot be used in this expression.");
								break;
							}
							case UNDEC:{
								printf("In thie line: %d.\n%s ",yylineno,$1); 
								yyerror("is Undeclared variable.");
								break;
							}
							case INT : {
								break;
							}
						}
					}
	| '-' expr %prec UMINUS { ; }
	| expr '+' expr 	{ ; }
	| expr '-' expr 	{ ; }
	| expr '*' expr 	{ ; }
	| expr '/' expr 	{ ; }
	| expr '%' expr		{ ; }
	| expr '<' expr     { ; }
	| expr '>' expr     { ; }
	| expr GE expr      { ; }
	| expr LE expr      { ; }
	| expr NE expr      { ; }
	| expr EQ expr      { ; }
	| '(' expr ')' 		{ ; }
	;

%%

void new_var(char * str, nodeEnum T){
	struct variable * p, *temp = ptr;

	if ((p = malloc(sizeof(struct variable) )) == NULL){
        yyerror("out of memory");
	}
	
	p->Type = T;
	strcpy(p->s, str);
	p->next = NULL;
	//printf("new_var %s \n", p->s);
	if(temp == NULL){
		ptr = p;
		return;
	}
	while(temp->next != NULL){
		if(strcmp(str,temp->s) == 0){
			printf("In thie line: %d.\n%s ",yylineno-1,str ); 
			yyerror("is already declared.");
		}
		temp = temp->next;
	}

	temp->next = p;
	return;
}

void freeVAR(struct variable *p){
	if(p != NULL){
		if (p->next!=NULL){
			freeVAR(p->next);
		}
		free(p);
	}
	return;
}

int seach(char * p){
	struct variable * temp = ptr;
	//printf("search %s\n", p);
	if(temp != NULL){
		while(temp != NULL){
			//printf("while %s\n", temp->s);
			if(strcmp(p,temp->s) == 0){
				//printf("strcmp\n");
				return temp->Type;		
			}
			temp = temp->next;
		}
	}
	//printf("UNDEC\n");
	return UNDEC;
}
void yyerror(char *s ) {
	printf("%s\n",s);
}

int main(void) {
	yyparse();
	return 0;
}
