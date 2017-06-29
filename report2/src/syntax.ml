(* ML interpreter / type reconstruction *)
type id = string

type binOp = Plus | Mult | Lt |
             (* Ex3.2.3 により論理演算子&&と||を二項演算子に追加*)
             Conj | Disj
type exp =
    Var of id
  | ILit of int
  | BLit of bool
  | BinOp of binOp * exp * exp
  | IfExp of exp * exp * exp
 (* Ex3.3.1 により変数宣言により束縛できるように *)
  | LetExp of id * exp * exp
 (* Ex3.4.1 により関数宣言と関数適応が扱えるように*)
  | FunExp of id * exp
  | AppExp of exp * exp

type program = 
    Exp of exp
 (* Ex3.3.1 により変数宣言だけから成る式も認める*)
 | Decl of id * exp
