type nat = Zero | OneMoreThan of nat;;
type 'a option = None | Some of 'a;;
type 'a tree = Lf | Br of 'a * 'a tree * 'a tree;;
let sampletree = Br(1, Br(2, Br(4, Lf, Lf),
Br(5, Lf, Lf)),
Br(3, Br(6, Lf, Lf),
Br(7, Lf, Lf)));;

(*6.3*)

let rec minus a b =
match (a,b) with
(_ , Zero) -> Some a (*return type nat option*)
| (Zero , _) -> None
| (OneMoreThan a',OneMoreThan b') -> minus a' b';;

let five = OneMoreThan (OneMoreThan (OneMoreThan (OneMoreThan (OneMoreThan Zero))));;
let three = OneMoreThan (OneMoreThan (OneMoreThan Zero));;

minus five three;;
minus three five;;

(*6.4*)
let rec comptree x n = 
if n=0 then
Lf
else
let part = comptree x (n-1) in
Br (x, part, part);;

comptree 5 3;;

(*6.5*)
let rec preord t l =
match t with
Lf -> l
| Br(x, left, right) -> x :: (preord left (preord right l));;

let rec inord t l =
match t with
Lf -> l
| Br(x, left, right) -> inord left (x :: (inord right l));;

let rec postord t l =
match t with
Lf -> l
| Br(x, left, right) -> postord left (postord right (x :: l));;

preord sampletree [];;
inord sampletree [];;
postord sampletree [];;

(*6.7*)
type arith =
Const of int | Add of arith * arith | Mul of arith * arith;;
(* exp stands for (3+4) * (2+5) *)
let exp = Mul (Add (Const 3, Const 4), Add (Const 2, Const 5));;

let rec string_of_arith x =
match x with
Const a -> string_of_int a
| Add (a,b) ->
(match b with
Add _ -> (string_of_arith a) ^ "+" ^ "(" ^ (string_of_arith b) ^ ")"
| _ -> (string_of_arith a) ^ "+" ^ (string_of_arith b) )
| Mul (a,b) ->
let left = match a with Add _ -> "(" ^ (string_of_arith a) ^ ")" | _ -> string_of_arith a in
let right = match b with Const _ -> string_of_arith b | _ -> "(" ^ (string_of_arith b) ^ ")" in
left ^ "*" ^ right;;

(*I solved optional*)

let expand x =
let rec recexp x  =
match x with
Mul (l',r') ->
let l = recexp l' in
let r = recexp r' in 
(match (l,r) with
(Add (a,b), _ ) -> Add (recexp (Mul(a, r)),recexp (Mul(b, r)))
| (_, Add(a,b)) -> Add (recexp (Mul(l,a)),recexp (Mul(l,b)))
| (_, _) -> Mul (l,r)
)
| Add (l,r) -> Add (recexp l, recexp r)
| _ -> x in
string_of_arith (recexp x);;

string_of_arith exp;;
string_of_arith (Mul (Const 1, Mul(Const 2, Add(Const 3, Const 4))));;

expand exp;;
expand (Mul (Const 1, Mul(Const 2, Add(Const 3, Const 4))));;


(*6.8*)
let rec add t x =
match t with
Lf -> Br (x, Lf, Lf)
| (Br (y, left, right) as whole) ->
if x = y then whole
else if x < y then Br(y, add left x, right) else Br(y, left, add right x);;

(*  1    *) Br(1, Lf, Br(2, Lf, Br(3, Lf, Br(4, Lf, Lf))));;
(*   2   *) (* 1 -> 2 -> 3 -> 4 *)
(*    3  *) add (add (add (add Lf 1) 2) 3) 4;;
(*     4 *)

(*  1    *) Br(1, Lf, Br(2, Lf, Br(4, Br(3, Lf, Lf), Lf)));;
(*   2   *) (* 1 -> 2 -> 4 -> 3 *)
(*    4  *) add (add (add (add Lf 1) 2) 4) 3;;
(*   3   *)

(*  1    *) Br(1, Lf, Br(3, Br(2, Lf, Lf),  Br(4, Lf, Lf)));;
(*   3   *) (* 1 -> 3 -> 2 -> 4  or  1 -> 3 -> 4 -> 2 *)
(*  2 4  *) add (add (add (add Lf 1) 3) 2) 4;;
(*       *) add (add (add (add Lf 1) 3) 4) 2;;

(*  1    *) Br(1, Lf, Br(4, Br(2, Lf, Br(3, Lf, Lf)), Lf));;
(*    4  *) (* 1 -> 4 -> 2 -> 3 *)
(*  2    *) add (add (add (add Lf 1) 4) 2) 3;;
(*    3  *)

(*  1    *) Br(1, Lf, Br(4, Br(3, Br(2, Lf, Lf), Lf), Lf));;
(*    4  *) (* 1 -> 4 -> 3 -> 2 *)
(*   3   *) add (add (add (add Lf 1) 4) 3) 2;;
(*  2    *)

(*   2   *) Br(2, Br(1, Lf, Lf), Br(3, Lf, Br(4, Lf, Lf)));;
(* 1  3  *) (* 2 -> 1 -> 3 -> 4  or  2 -> 3 -> 1 -> 4  or  2 -> 3 -> 4 -> 1 *)
(*     4 *) add (add (add (add Lf 2) 1) 3) 4;;
(*       *) add (add (add (add Lf 2) 3) 1) 4;;
            add (add (add (add Lf 2) 3) 4) 1;;

(*   2   *) Br(2, Br(1, Lf, Lf), Br(4, Br(3, Lf, Lf), Lf));;
(* 1  4  *) (* 2 -> 1 -> 4 -> 3  or  2 -> 4 -> 1 -> 3  or  2 -> 4 -> 3 -> 1 *)
(*   3   *) add (add (add (add Lf 2) 1) 4) 3;;
(*       *) add (add (add (add Lf 2) 4) 1) 3;;
            add (add (add (add Lf 2) 4) 3) 1;;

(*   3   *) Br(3, Br(1, Lf, Br(2, Lf, Lf)), Br(4, Lf, Lf));;
(* 1   4 *) (* 3 -> 1 -> 2 -> 4  or  3 -> 1 -> 4 -> 2  or  3 -> 4 -> 1 -> 2 *)
(*  2    *) add (add (add (add Lf 3) 1) 2) 4;;
(*       *) add (add (add (add Lf 3) 1) 4) 2;;
            add (add (add (add Lf 3) 4) 1) 2;;

(*   3   *) Br(3, Br(2, Br(1, Lf, Lf), Lf), Br(4, Lf, Lf));;
(*  2  4 *) (* 3 -> 2 -> 1 -> 4  or  3 -> 2 -> 4 -> 1  or  3 -> 4 -> 2 -> 1 *)
(* 1     *) add (add (add (add Lf 3) 2) 1) 4;;
(*       *) add (add (add (add Lf 3) 2) 4) 1;;
            add (add (add (add Lf 3) 4) 2) 1;;

(*    4  *) Br(4, Br(1, Lf, Br(2, Lf, Br(3, Lf, Lf))), Lf);;
(*  1    *) (* 4 -> 1 -> 2 -> 3 *)
(*   2   *) add (add (add (add Lf 4) 1) 2) 3;;
(*    3  *)

(*    4  *) Br(4, Br(1, Lf, Br(3, Br(2, Lf, Lf), Lf)), Lf);;
(*  1    *) (* 4 -> 1 -> 3 -> 2 *)
(*   3   *) add (add (add (add Lf 4) 1) 3) 2;;
(*  2    *)

(*    4  *) Br(4, Br(2, Br(1, Lf, Lf), Br(3, Lf, Lf)), Lf);;
(*  2    *) (* 4 -> 2 -> 1 -> 3  or  4 -> 2 -> 3 -> 1 *)
(* 1 3   *) add (add (add (add Lf 4) 2) 1) 3;;
(*       *) add (add (add (add Lf 4) 2) 3) 1;;

(*    4  *) Br(4, Br(3, Br(1, Lf, Br(2, Lf, Lf)), Lf), Lf);;
(*  3    *) (* 4 -> 3 -> 1 -> 2 *)
(* 1     *) add (add (add (add Lf 4) 3) 1) 2;;
(*  2    *)

(*    4  *) Br(4, Br(3, Br(2, Br(1, Lf, Lf), Lf), Lf), Lf);;
(*   3   *) (* 4 -> 3 -> 2 -> 1 *)
(*  2    *) add (add (add (add Lf 4) 3) 2) 1;;
(* 1     *)

