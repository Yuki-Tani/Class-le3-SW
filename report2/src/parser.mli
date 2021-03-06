
(* The type of tokens. *)

type token = 
  | TRUE
  | THEN
  | SEMISEMI
  | RPAREN
  | PLUS
  | MULT
  | LT
  | LPAREN
  | LET
  | INTV of (int)
  | IN
  | IF
  | ID of (Syntax.id)
  | FALSE
  | EQ
  | ELSE
  | DISJ
  | CONJ

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val toplevel: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Syntax.program)
