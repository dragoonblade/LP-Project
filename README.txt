# LP-Project

Using YACC and LEX to parse a grammar.

grammar is a calculator with +, -, *, / and ^ operations.
^ has highest priority
followed by + and -
and lowest for * and /
ex: 1+2*2^2 
-> 1+2*4 -> 3*4 -> 12
and not
-> 1+2*4 -> 1+12 -> 13

also the the operations are right assosciative instead of right
ex: 2-1 is -1 not 1
    2/6 is 3 not 1/3

first compile yacc file as
$yacc -d grammar.y   //creates two files header file and c file (-d used to create header file)
created grammar.tab.h
        grammar.tab.c

then compile lex file
$lex parser.l     //creates a c file
created lex.yy.c

then compile the resultant c files together
$gcc lex.yy.c grammar.tab.c -o output

then execute output
