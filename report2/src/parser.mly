%{
open Syntax
%}

%token LPAREN RPAREN SEMISEMI
%token PLUS MULT LT
%token IF THEN ELSE TRUE FALSE

%token <int> INTV
%token <Syntax.id> ID

(* Ex3.2.3 によって && || を拡張*)
%token CONJ DISJ
(* Ex3.3.1 によって let in = を拡張*)
%token LET IN EQ
(* Ex3.4.1 によって fun ->を拡張*)
%token FUN RARROW

%start toplevel
%type <Syntax.program> toplevel
%%



toplevel :
    e=Expr SEMISEMI { Exp e }
 (* Ex3.3.1によってlet式もプログラムとして扱う *)
  | LET x=ID EQ e=Expr SEMISEMI { Decl (x, e) }

Expr :
    e=IfExpr { e }
  | e=DJExpr { e }
 (* Ex3.3.1 によってlet-in式も式として扱う*)
  | e=LetExpr { e }
 (* Ex3.4.1 によって関数宣言も式として扱う*)
  | e=FunExpr { e }

(* Ex3.2.3 によって拡張 *)
(* 結合度は LT < CONJ(&&) < DISJ(||)*)
DJExpr :
    l=DJExpr DISJ r=CJExpr { BinOp (Disj, l, r) } (*|| は 左結合の二項演算*)
  | e=CJExpr { e }

CJExpr :
    l=CJExpr CONJ r=LTExpr { BinOp (Conj, l, r) } (*&& は 左結合の二項演算*)
  | e=LTExpr { e }
(* Ex3.2.3拡張ここまで  *)

LTExpr : 
    l=PExpr LT r=PExpr { BinOp (Lt, l, r) }
  | e=PExpr { e }

PExpr :
    l=PExpr PLUS r=MExpr { BinOp (Plus, l, r) }
  | e=MExpr { e }

MExpr : 
    l=MExpr MULT r=AppExpr { BinOp (Mult, l, r) }
  | e=AppExpr { e }

(* Ex3.4.1 によって拡張 *)
(* 結合度は最も強い*)
AppExpr :
    f=AppExpr x=AExpr { AppExp (f, x) } (*関数適応 は 左結合*)
  | e=Aexpr { e }
(* Ex3.4.1拡張ここまで*)

AExpr :
    i=INTV { ILit i }
  | TRUE   { BLit true }
  | FALSE  { BLit false }
  | i=ID   { Var i }
  | LPAREN e=Expr RPAREN { e }

IfExpr :
    IF c=Expr THEN t=Expr ELSE e=Expr { IfExp (c, t, e) }

(* Ex3.3.1 によってlet式を拡張  *)
LetExpr :
    LET x=ID EQ e1=Expr IN e2=Expr { LetExp (x, e1, e2) }
