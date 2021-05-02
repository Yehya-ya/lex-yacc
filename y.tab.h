/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEGER = 258,
    IDENTIFIER = 259,
    CHARACTER = 260,
    Y_INT = 261,
    Y_CHAR = 262,
    WHILE = 263,
    IF = 264,
    OUTPUT = 265,
    OUTPUTC = 266,
    READ = 267,
    READC = 268,
    ELSE = 269,
    INCLUDE = 270,
    HEADER = 271,
    IFX = 272,
    GE = 273,
    LE = 274,
    EQ = 275,
    NE = 276,
    UMINUS = 277
  };
#endif
/* Tokens.  */
#define INTEGER 258
#define IDENTIFIER 259
#define CHARACTER 260
#define Y_INT 261
#define Y_CHAR 262
#define WHILE 263
#define IF 264
#define OUTPUT 265
#define OUTPUTC 266
#define READ 267
#define READC 268
#define ELSE 269
#define INCLUDE 270
#define HEADER 271
#define IFX 272
#define GE 273
#define LE 274
#define EQ 275
#define NE 276
#define UMINUS 277

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 15 "lab.y" /* yacc.c:1909  */

	int I_value;
	char C_value;
	char * ID;

#line 104 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
