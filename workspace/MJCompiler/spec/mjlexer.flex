package rs.ac.bg.etf.pp1;
import java_cup.runtime.Symbol;
import java.io.*;
import org.apache.log4j.*;

%%

%{
	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn);
	}
	// ukljucivanje informacije o poziciji tokena
	private Symbol new_symbol(int type, Object value) {
		return new Symbol(type, yyline+1, yycolumn, value);
	}
%}

%cup

%xstate COMMENT

%eofval{ 
return new_symbol(sym.EOF);
%eofval}

%line
%column

%%

" " {}
"\b" {}
"\t" {}
"\r\n" {}
"\f" {}
"program" {return new_symbol(sym.PROGRAM, yytext());}
"break" {return new_symbol(sym.BREAK, yytext());}
"class" {return new_symbol(sym.CLASS, yytext());}
"else" {return new_symbol(sym.ELSE, yytext());}
"const" {return new_symbol(sym.CONST, yytext());}
"if" {return new_symbol(sym.IF, yytext());}
"new" {return new_symbol(sym.NEW, yytext());}
"print" {return new_symbol(sym.PRINT, yytext());}
"read" {return new_symbol(sym.READ, yytext());}
"return" {return new_symbol(sym.RETURN, yytext());}
"void" {return new_symbol(sym.VOID, yytext());}
"while" {return new_symbol(sym.WHILE, yytext());}
"extends" {return new_symbol(sym.EXTENDS, yytext());}
"+" {return new_symbol(sym.PLUS, yytext());}
"-" {return new_symbol(sym.MINUS, yytext());}
"*" {return new_symbol(sym.TIMES, yytext());}
"/" {return new_symbol(sym.DIV, yytext());}
"%" {return new_symbol(sym.MOD, yytext());}
"==" {return new_symbol(sym.EQUAL, yytext());}
"!=" {return new_symbol(sym.NOT_EQUAL, yytext());}
">" {return new_symbol(sym.GREATER, yytext());}
">=" {return new_symbol(sym.GREATER_OR_EQUAL, yytext());}
"<" {return new_symbol(sym.LESS, yytext());}
"<=" {return new_symbol(sym.LESS_OR_EQUAL, yytext());}
"&&" {return new_symbol(sym.AND, yytext());}
"||" {return new_symbol(sym.OR, yytext());}
"=" {return new_symbol(sym.EQUALS, yytext());}
"++" {return new_symbol(sym.INC, yytext());}
"--" {return new_symbol(sym.DEC, yytext());}
";" {return new_symbol(sym.SEMI_COMMA, yytext());}
"," {return new_symbol(sym.COMMA, yytext());}
"." {return new_symbol(sym.DOT, yytext());}
"(" {return new_symbol(sym.LPAREN, yytext());}
")" {return new_symbol(sym.RPAREN, yytext());}
"[" {return new_symbol(sym.LBRACKET, yytext());}
"]" {return new_symbol(sym.RBRACKET, yytext());}
"{" {return new_symbol(sym.LBRACE, yytext());}
"}" {return new_symbol(sym.RBRACE, yytext());}
"//" {yybegin(COMMENT);}
<COMMENT>. {yybegin(COMMENT);}
<COMMENT>"\r\n" {yybegin(YYINITIAL);}
[0-9]+ {return new_symbol(sym.NUMBER, new Integer (yytext()));}
"true"|"false" {return new_symbol(sym.BOOLCONST, new Boolean (yytext().equals("true") ? true : false));}
([a-z]|[A-Z])[a-z|A-Z|0-9|_]* {return new_symbol (sym.IDENT, yytext());}
"'"[\040-\176]"'" {return new_symbol (sym.CHARCONST, new Character (yytext().charAt(1)));}
"\""[^\"]*"\"" {return new_symbol(sym.STRCONST, new String (yytext().substring(1, yytext().length()-1)));}
. {System.err.println("Leksicka greska ("+yytext()+") na liniji "+(yyline+1) + " na poziciji " + (yycolumn+1) );}

