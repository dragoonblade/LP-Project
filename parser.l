%{	
	#include "grammar.tab.h"
	#include <string.h>
	int yylex();
	void yyerror(const char *s);
%}
%%
[a-zA-Z]			   {yylval.id = yytext[0]; return identifier;}
[0-9]+                 {yylval.num = atoi(yytext); return number;}
"exit" 				   {return exit_command;}
[ \t\n]                ;
[-+=;*/^]              {return yytext[0];}
.                      {ECHO; yyerror ("unexpected character");}
%%
int yywrap (void) {
	return 1;
}