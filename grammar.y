%{
	#include "stdio.h"
	#include "stdlib.h"
	#include "math.h"
	#include <ctype.h>
	int symbols[52];
	int symbolVal(char symbol);
	void updateSymbolVal(char symbol, int val);
	int yylex();
	void yyerror(const char *s);
%}

%union {int num; char id;}
%start root
%token exit_command
%token <num> number
%token <id> identifier
%type <num> term factor base expr
%type <id> answer



%%
//definations

root	: answer ';'	{;}
		| root answer ';' {;}
		| exit_command ';'	{exit(EXIT_SUCCESS);}
		| root exit_command ';'	{exit(EXIT_SUCCESS);}
		;

answer  : identifier '=' expr 	{updateSymbolVal($1,$3);printf("%d\n",symbolVal($1));}
		| identifier 			{printf("%d\n",symbolVal($1));}
		;	

expr : term '*' expr				{$$ = $3 * $1;}
	 | term '/' expr				{$$ = $3 / $1;}	
	 | term							{$$ = $1;}
	 ;
term : factor '-' term				{$$ = $3 - $1;}
	 | factor '+' term				{$$ = $3 + $1;}
	 | factor						{$$ = $1;}
	 ;
factor  : base '^' factor			{$$ = pow($3,$1);}
		| base						{$$ = $1;}
		;
base : identifier					{$$ = symbolVal($1);}	
	 | number 						{$$ = $1;}
	 ;	
%%

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

int symbolVal(char symbol)
{
	int id = computeSymbolIndex(symbol);
	return symbols[id];
}

void updateSymbolVal(char symbol, int val)
{
	int id = computeSymbolIndex(symbol);
	symbols[id] = val;
}


int main (void) {
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	yyparse ( );	
	return 0;
}

 void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }