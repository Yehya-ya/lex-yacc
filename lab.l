
%{
	#include "y.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	void yyerror(char *);
	char s[20];
%}

letter [a-zA-Z]
digit [0-9]
alfa [a-zA-Z0-9_]
%option yylineno 

%%

{digit}+		{
					yylval.I_value = atoi(yytext);
					
					return INTEGER;
				}
"read"			return READ;
"readc"			return READC;
"output"		return OUTPUT;
"outputc"		return OUTPUTC;
"y_int"			return Y_INT;
"y_char"		return Y_CHAR;
">="            return GE;
"<="            return LE;
"=="            return EQ;
"!="            return NE;
"if"			return IF;
"else"			return ELSE;
"while"			return WHILE;
[-+*/%s<>=(){}\n] 		return *yytext;
"#include"		return INCLUDE;
"\<"(.+)">" 		return HEADER;
\/\/.* {};
\/.*  			{printf("In the line: %d.\n",yylineno);
				yyerror("syntax error.");}
\/\*(.*\n)*\*\/ {};
[ \t]+			;
EOF				;
"\'"[a-z]"\'" {
					yylval.C_value = *(yytext+1);
					return CHARACTER;
				 }
[a-zA-Z][a-zA-Z0-9]*	{
									strncpy(s,yytext,yyleng);
									s[yyleng] = '\0';
									yylval.ID = s;
									return IDENTIFIER;
								}

. 				{printf("In the line: %d.\n",yylineno);
				yyerror("syntax error.");}
%%



int yywrap(void){
	return 1;
}
