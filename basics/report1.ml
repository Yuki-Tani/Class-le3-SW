(*************** Ex.2 ***************)
print_string "\n\n*************** Ex.2 ***************";;

(*** Ex.2.1 ***)
(*
1. float_of_int 3 +. 2.5;;
  float = 5.5   暗黙の型変換は行われない

2. int_of_float 0.7;;
  int = 0    切り捨てでint型に丸められる


3. if "11" > "100" then "foo" else "bar";;
  string = "foo"   string型の大小は辞書順

4. char_of_int ((int_of_char 'A') + 20);;
  char = 'U'   char型はint型に変換できる

5. int_of_string "0xff";;
  int = 256   string型は0xをつけて16進int型に変換できる

6. 5.0**2.0;;
	float = 25.   指数演算
*)


(*** Ex.2.2 ***)
(*
1. if true&&flase then 2
  予想：true&&falseを１語として認識する事によるnot_boundエラー
  結果：else節以下が何も書かれていないことによる型エラー

2. 8*-2
  予想：*を前置演算子-よりも早く評価することによるsyntaxエラー
　結果：概ね予想通り（具体的にはunbound error）

3. int_of_string "0xfg"
  予想：gが16進intとして認められないという関数エラー
  結果：予想通り

4. int_of_float -0.7
  予想：前置演算子-より関数が先に結合することによるsyntaxエラー
  結果：概ね予想通り（具体的にはintとみなされる型エラー）
*)


(*** Ex.2.3 ***)
print_string "\n***** Ex.2.3 *****";;
(*1. not true && false => true*) 
  not (true && false);;

(*2. float_of_int int_of_float 5.0 => 5.0*) 
  float_of_int (int_of_float 5.0);;

(*3. sin 3.14 /. 2.0 ** 2.0 +. cos (3.14 /. 2.0) ** 2.0 => 1.0*) 
  sin (3.14 /. 2.0) ** 2.0 +. cos (3.14 /. 2.0) ** 2.0;;

(*4. sqrt 3*3 + 4*4 => 5 (int)*) 
  int_of_float (sqrt (float_of_int (3*3 + 4*4)));;



(*** Ex.2.4 ***)
(*
&& : 
if b1 then
  if b2 then
    true 
  else 
    false 
else
  false

|| : 
if b1 then
  true
else
  if b2 then
    true
  else
    false

*)


(*** Ex.2.5 ***)
(*
a_2'     :ok
____     :ok
Cat      :Unbound constructor (C)
_'_'_    :ok
7eleven  :Invalid literal (7)
'ab2     :syntax error (')
_        :ok
*)


(*** Ex.2.6 ***)
print_string "\n***** Ex.2.6 *****";;
(*1*)
let yen_of_dollar dollar  =
 int_of_float (dollar *. 111.12 +. 0.5);;

(*2*)
let dollar_of_yen yen = 
 floor (float_of_int yen /. 111.12 *. 100. +. 0.5) /. 100.;;

(*3*)
let print_yen_of_dollar dollar =
  string_of_float dollar ^ " dollars are " 
 ^ string_of_int (yen_of_dollar dollar) ^ " yen.";;

(*4*)
let capitalize char =
  let num = int_of_char char in
  if num>=97 && num<=122 then
   char_of_int (num - 32)
  else
   char ;;


yen_of_dollar 1.0;;
yen_of_dollar 6.0;;

dollar_of_yen 112;;

print_yen_of_dollar 6.0;;

capitalize 'a';;
capitalize 'z';;
capitalize 'N';;
capitalize '1';;



(*************** Ex.3 ***************)
print_string "\n\n*************** Ex.3 ***************";;

(*** Ex.3.1 ***)

(* 参照、評価結果予想
(1)
let x = 1 in let x = 3 in let x = 「x」 + 2 in 「x」 * 「x」
   1つ目：let x = 3 を参照
   2つ目：let x = x + 2 を参照
   3つ目：let x = x + 2 を参照
   評価結果予想：25

(2)
let x = 2 and y = 3 in (let y = 「x」 and x = 「y」 + 2 in 「x」 * 「y」) + 「y」
   1つ目(x) : let x = 2 and ... を参照
   2つ目(y) : let ... and y = 3 を参照
   3つ目(x) : let x = y + 2 を参照
   4つ目(y) : let y = x を参照
   5つ目(y) : let ... and y = 3 を参照
   評価結果予想：13

(3)
let x = 2 in let y = 3 in let y = 「x」 in let z = 「y」+ 2 in 「x」*「y」*「z」
   1つ目(x) : let x = 2 を参照
   2つ目(y) : let y = x を参照
   3つ目(x) : let x = 2 を参照
   4つ目(y) : let y = x を参照
   5つ目(z) : let z = y + 2 を参照
   評価結果予想：16
*)

(* 結果
(1),(2),(3)とも予想通りであった。

let x =1 in let x = 3 in let x=x+2 in x * x;;
let x=2 and y=3 in (let y=x and x=y+2 in x*y)+y;;
let x=2 in let y=3 in let y=x in let z=y+2 in x*y*z;; 
*)


(*** Ex.3.2 ***)

(*
(1) let x = e1 and y = e2;;
(2) let x = e2 let y = e2;;

(1)の式の場合、式e1,e2の評価の際に使用される環境はいずれもこのlet式直前までの環境である。
すなわち、e2内部にxが現れていたとしてもそのxが参照する定義は　let x=e2　ではない。
(2)の式の場合、式e1の評価の際に使用される環境はこのlet式直前までの環境であるが、
式e2の評価の際に使用する環境は、それに束縛 y = e2 を加えた環境となる。
従って、e2内部にxが現れたとき、そのxが参照する定義は let y = e2　である。
*)


(*** Ex.3.3 ***)
print_string "\n***** Ex.3.3 *****";;

let geo_mean (a,b) =
  sqrt (a *. b);;

geo_mean (2.,18.);;
geo_mean (1.,2.);;


(*** Ex.3.4 ***)
print_string "\n***** Ex.3.4 *****";;

let prodMatVec ( ((a11,a12),(a21,a22)) , (x,y)) =
  (a11 *. x +. a12 *. y , a21 *. x +. a22 *. y);;

prodMatVec (((0.0,-2.0),(2.0,0.0)) , (3.0,4.0));;


(*** Ex.3.5 ***)

(*
float*float*float*float型の構成法は、　(a,b,c,d)　のような形となる。
一方(float*float)*(float*float)型の構成法は、　((a,b),(c,d))　のような形となる。
前者は要素を並べた１つの組、後者は組を入れ子にして２つ入れた形となっている。
要素の取り出しについても、それぞれ上記の形でパターンマッチを行う。

*)


(*** Ex.3.6 ***)

(*
パターン(x : int) は、int型の単一の値にマッチし、それをxに束縛する。
*)


(*** Ex.3.7 ***)
print_string "\n***** Ex.3.7 *****";;
(*1*)
let rec pow (x,n) =
 if n < 0 then 
   pow (1. /. x , -n)
 else  
   if n = 0 then
     1.
   else
     x *. pow (x,n-1) ;;

pow (2.,10);;

(*2*)
let rec pow (x,n) =
 if n < 0 then
    pow (1. /. x , -n)
 else
 if n = 0 then
   1.
 else
   let child = pow (x , n / 2) in
   if n mod 2 = 0 then
     child *. child
   else
     x *. child *. child ;;
   
pow (2.,10);;


(*** Ex.3.8 ***)
print_string "\n***** Ex.3.8 *****";;

let rec powi (x,n,pr) =
  if n < 0 then 
   powi (1. /. x , -n, pr)
 else  
   if n = 0 then
     pr
   else
     powi (x , n-1, pr *. x) ;;

(*呼出しの際
powi (基数,乗数,1.0) と、最後に1.0をつけた組で呼び出す。
*)

powi (2.0, 50, 1.0);;


(*** Ex.3.9 ***)
print_string "\n***** Ex.3.9 *****";;

(*
let cond (b, e1, e2) : int = if b then e1 else e2;;
let rec fact n = cond ((n = 1), 1, n * fact (n-1));;
*)
(*
fact 4 の評価ステップは以下のようになる。

fact 4
=> cond ((4 = 1), 1 , 4 * fact (4 - 1))
=> cond (false, 1, 4 * fact (4 - 1))
=> cond (false, 1, 4 * fact 3)
=> cond (false, 1, 4 * cond((3 == 1), 1, 3 * fact (3-1))
=>..
=> cond (false, 1, 4 * cond(false, 1, 3* fact 2))
=>...
=> cond (fale, 1, 4 * cond(false, 1, 3* cond(false,1, 2*fact 1)))
=>...
=> cond (false,1,4*cond(false,1,3*cond(false,1,2*cond(true,1,1*fact 0)))) 
=> cond (false,1,4*cond(false,1,3*cond(false,1,2*cond(true,1,1*cond(false,1,0*fact (-1))))))
=>....

関数呼び出しは、その引数の値を評価してから関数式の適応を行う。
今回の例では、true,falseによるe1,e2式の選択の前にn*fact(n-1)の評価を行うことになるので、
factの再帰呼び出しが止まらず、無限ループに陥ってしまう。

*)


(*** Ex.3.10 ***)
print_string "\n***** Ex.3.10 *****";

(*let rec fib n = (* nth Fibonacci number *)
if n = 1 || n = 2 then 1 else fib(n - 1) + fib(n - 2);;*)
(*

fib 4
=> if 4=1 || 4=2 then 1 else fib (4-1) + fib (4-2)
=> if false then 1 else fib (4-1) + fib (4-2)
=> fib (4-1) + fib (4-2)
=> fib 3 + fib (4-2)
=> (if 3=1 || 3=2 then 1 else fib (3-1) + fib (3-2)) + fib (4-2)
=> (if false then 1 else fib (3-1) + fib (3-2)) + fib (4-2)
=> fib (3-1) + fib (3-2) + fib (4-2)
=> fib 2 + fib (3-2) + fib (4-2)
=> (if 2=1 || 2=2 then 1 else fib (2-1) + fib (2-2)) + fib (3-2) + fib(4-2)
=> (if true then 1 else fib (2-1) + fib (2-2)) + fib (3-2) + fib(4-2)
=> 1 + fib (3-2) + fib(4-2)
=> 1 + fib 1 + fib(4-2)
=> 1 + (if 1=1 || 1=2 then 1 else fib (1-1) + fib (1-2)) + fib(4-2)
=> 1 + (if true then 1 else fib (1-1) + fib (1-2)) + fib(4-2)
=> 1 + 1 + fib(4-2)
=> 2 + fib(4-2)
=> 2 + fib 2
=> 2 + (if 2=1 || 2=2 then 1 else fib (2-1) + fib (2-2))
=> 2 + (if true then 1 else fib (2-1) + fib (2-2))
=> 2 + 1
=> 3

*)


(*** Ex.3.11 ***)
print_string "\n***** Ex.3.11 *****";;

(*1*)
let rec gcd (a,b) =
  if b = 0 then
    abs a
  else
    gcd (b , a mod b);;

(*2*)
let rec comb (n,m) = 
  if n<0 || m<0 then 0 else
  if m = 0 || m = n then
    1
  else
    comb (n-1,m-1) + comb (n-1,m);;

(*3*)
let fib_iter n = 
  let rec  _fib_iter (n, i, curr, prev) =
  if n = i then
    curr
  else
    _fib_iter (n, i+1,curr+prev,curr) in

  if n<1 then
    0
  else
    _fib_iter (n,1,1,0) ;;

(*4*)
let max_ascii arg =
  let length = String.length arg in
  let rec compare (i,max_char) =
    if i = length then
      max_char
    else
      let newmax =
        if arg.[i] > max_char then
          arg.[i]
        else
          max_char in
      compare (i+1,newmax) in
  compare (0,char_of_int 0);;

gcd (120,75);;
gcd (-20,36);;
comb (10,2);;
comb (6,3);;
fib_iter 5;;
fib_iter 1000;;
max_ascii "OCaml";;
max_ascii "%#('?*@";;


(*** Ex.3.12 ***)
print_string "\n***** Ex.3.12 *****";;

(*
let rec pos n =
neg (n-1) +. 1.0 /. (float_of_int (4 * n + 1))
and neg n =
if n < 0 then 0.0
else pos n -. 1.0 /. (float_of_int (4 * n + 3));;
*)

let rec pos_neg n =
  if n <= 0 then 1.0
  else pos_neg (n-1) 
        -. 1.0 /. (float_of_int (4 * n - 1))
	+. 1.0 /. (float_of_int (4 * n + 1));;

4.0 *. pos_neg 200;;



(*************** Ex.4 ***************)
print_string "\n\n*************** Ex.4 ***************";;

(*** Ex.4.1 ***)
print_string "\n***** Ex.4.1 *****";;

let integral f a b =
  let dx = 1e-6 in
  let rec calc_table (a',sum) = 
    if a' >= b then
      sum
    else
      let s = (f a' +. f (a' +. dx)) /. 2.0 *. dx in
      calc_table (a' +. dx, sum +. s)
  in
  calc_table (a , 0.);;

let pi = 3.14159265358979324;;
integral sin 0. pi;;


(*** Ex.4.2 ***)
print_string "\n***** Ex.4.2 *****";;

let rec pow x n =
 if n < 0 then
    pow (1. /. x) (-n)
 else
 if n = 0 then
   1.
 else
   let child = pow  x  (n / 2) in
   if n mod 2 = 0 then
     child *. child
   else
     x *. child *. child ;;

pow 2.0 10;;

let rec pow n x =
 if n < 0 then
    pow (-n) (1. /. x)
 else
 if n = 0 then
   1.
 else
   let child = pow (n / 2) x in
   if n mod 2 = 0 then
     child *. child
   else
     x *. child *. child ;;

let cube = pow 3;;

cube 5.0;;

(*
前者の定義 pow x nから cubeを定義する場合、
let cube x = pow x 3
のように、引数を明示して定義すればよい。
*)


(*** Ex.4.3 ***)
print_string "\n***** Ex.4.3 *****";;

(*
(1)int -> int -> int -> int
(2)(int -> int) -> int -> int
(3)(int -> int -> int) -> int

１は、int型変数を受け取って int->int->int型関数を返すような関数が持つ型である。
最終的にはint値３つを受け取ってint値を返すような型である。
２は、int -> int型関数を受け取って、int -> int型関数を返すような関数が持つ型である。
最終的には、intを引数にしてintを返す関数１つと、int値１つを受け取ってint値を返すような型である。
３は、int -> int -> int型関数を受け取って、int値を返すような関数が持つ型である。
最終的には、int値２つを引数にしてintを返す関数１つを受け取って、int値を返すような型である。
*)

let fun4_3_1 x y z = x + y + z;;
let fun4_3_2 f x = f (x + 1)  + 2;;
let fun4_3_3 f = f 1 2 + 3;;


(*** Ex.4.4 ***)
print_string "\n***** Ex.4.4 *****";;

let curry f x y = f (x, y);;
let average (x,y) = (x +. y) /. 2.0;;
let curried_avg = curry average;;

let uncurry f (x, y) = f x y;;

let avg = uncurry curried_avg in
avg (4.0, 5.3);;


(*** Ex.4.5 ***)
print_string "\n***** Ex.4.5 *****";;

let rec repeat f n x =
  if n > 0 then repeat f (n - 1) (f x) else x;;

let fib n =
  let (fibn, _) =  repeat (fun (curr, prev) -> (curr + prev, curr)) (n-1) (1,0)
  in fibn;;

fib 6;;


(*** Ex.4.6 ***)
print_string "\n***** Ex.4.5 *****";;

let id x = x;;
let ($) f g x = f (g x);;

let rec funny f n =
if n = 0 then id
else if n mod 2 = 0 then funny (f $ f) (n / 2)
else funny (f $ f) (n / 2) $ f;;

(*
funny f n は、fをn回適応するような関数を返す。
*)

(funny (fun x->x*2) 10) 1;;


(*** Ex.4.7 ***)
print_string "\n***** Ex.4.7 *****";;

let k x y = x ;;
let s x y z = x z (y z);;

(*
 s k k 1 
 => k 1 (k 1)
 => (fun y -> 1) (k 1)
 => (fun y -> 1) (fun y' -> 1)
 => 1
*)

k (s k k) 1 2;;


(*** Ex.4.8 ***)
print_string "\n***** Ex.4.8 *****";;

(*
let double f x = f (f x);;
<=>
let double = (fun f -> (fun x -> f (f x)))  
*)

(*
double double f x
=> (fun f' -> (fun x' -> f' (f' x'))) double f x
=> (fun x' -> double (double x')) f x
=> double (double f) x
=> double ((fun f' -> (fun x' -> f' (f' x'))) f) x
=> double (fun x' -> f (f x')) x
=> (fun f2 -> (fun x2 -> f2 (f2 x2))) (fun x' -> f (f x')) x
=> fun x2 -> ( (fun x' -> f (f x')) ((fun x' -> f (f x')) x2) ) x
=> (fun x' -> f (f x')) ((fun x' -> f (f x')) x)
=> (fun x' -> f (f x')) (f (f x))
=> f ( f (f (f x))))
*)



(*************** Ex.5 ***************)
print_string "\n\n*************** Ex.5 ***************";;

let hd (x::rest) = x
let tl (x::rest) = rest
let null = function [] -> true | _ -> false;;

let rec length = function
[] -> 0
| _ :: rest -> 1 + length rest;;

(*** Ex.5.1 ***)

(* 予想
1. 'a list list 
2. 誤り リストのリストであるが、中のリストの格納している型が違い型付けできない
3. int list list
4. 誤り １つめのconsのtail部がlist list int であるのに、headがintになっている
5. 'a list list
6. bool->bool list
*)

(* 結果
　全て予想通りであった。
*)


(*** Ex.5.2 ***)
print_string "\n***** Ex.5.2 *****";;

let sum_list l =
  let rec sum_list_part l sum =
    if (null l) then sum
    else sum_list_part (tl l) (hd l + sum) in
  sum_list_part l 0;;

let rec max_list l =
  let head = hd l in
  if (null (tl l)) then head
  else if head > hd (tl l) then max_list (head :: tl (tl l))
  else max_list (tl l);;

sum_list [1;2;3;4;5;6;7;8;9];;
max_list [3;1;4;1;5;9;2;6;5];;

(* 得失議論
hd,tl,nullを使用する記述の方が、先頭要素での場合分けや
後方リストの取り出しを簡単に行える一方で、
２つめ以降の要素等で場合分けをする場合や、
先頭２つを取り除いたリストを用意する場合は、呼び出しがやや複雑になる。
いくつかの先頭要素を崩して使用する場合はmatchの方が書きやすい。
*)


(*** Ex.5.3 ***)
print_string "\n***** Ex.5.3 *****";;
(*1*)
let rec downto0 n =
  if n<0 then []
  else n :: (downto0 (n-1));;

(*2*)
let rec roman def n =
  if n <= 0 then ""
  else if null def then ""
  else
    let (num,chr) = hd def in
    if num > n then
      roman (tl def) n
    else
      chr ^ roman def (n-num);;

(*3*)
let rec concat ll =
  match ll with
    [] -> []
  | head :: tail -> head @ (concat tail);;

(*4*)
let rec zip l1 l2 =
  if null l1 || null l2 then []
  else (hd l1, hd l2) :: zip (tl l1) (tl l2);;

(*5*)
let rec filter p l = 
  if null l then []
  else if p (hd l) then
    hd l :: filter p (tl l)
  else 
    filter p (tl l);;

(*6*)
let rec belong a s =
  if null s then false
  else if a = hd s then true
  else belong a (tl s);;

let rec intersect s1 s2 =
  if null s1 then []
  else if belong (hd s1) s2 then
    hd s1 :: intersect (tl s1) s2
  else
    intersect (tl s1) s2;;

let rec union s1 s2 =
  if null s1 then s2
  else if belong (hd s1) s2 then
    union (tl s1) s2
  else 
    hd s1 :: union (tl s1) s2;;

let rec diff s1 s2 =
  if null s1 then []
  else if belong (hd s1) s2 then
    diff (tl s1) s2
  else
    hd s1 :: diff (tl s1) s2;;


downto0 10;;

roman [(1000, "M"); (900, "CM"); (500, "D"); (400, "CD");
(100, "C"); (90, "XC"); (50, "L"); (40, "XL");
(10, "X"); (9, "IX"); (5, "V"); (4, "IV"); (1, "I")] 1984;;

concat [[0; 3; 4]; [2]; [5; 0]; []];;

zip [1;2;3;4;5] [5;4;3;2;1;0];;

filter (fun l -> length l = 3) [[1; 2; 3]; [4; 5]; [6; 7; 8]; [9]];;

belong 9 [3;1;4;1;5;9;2;6;5];;
belong 0 [3;1;4;1;5;9;2;6;5];;
intersect [0;2;4;6;8;10;12] [0;3;6;9;12];;
union [0;2;4;6;8;10;12] [0;3;6;9;12];;
diff [0;2;4;6;8;10;12] [0;3;6;9;12];;


(*** Ex.5.4 ***)
print_string "\n***** Ex.5.4 *****";;

let rec map f = function
    [] -> []
  | x :: rest -> f x :: map f rest;;

let f x = x + 1 in
let g x = x * 2 in
let l = [1;2;3;4;5] in

 map f (map g l);;

let f x = x + 1 in
let g x = x * 2 in
let l = [1;2;3;4;5] in

(*解答*)
 map (f $ g) l;;


(*** Ex.5.5 ***)
print_string "\n***** Ex.5.5 *****";;

(*
let rec forall p = function
  [] -> true
  | x :: rest -> if p x then forall p rest else false;;

let rec exists p = function
  [] -> false
  | x :: rest -> (p x) or (exists p rest);;
*)
let rec fold_right f l e =
  match l with
    [] -> e
    | x :: rest -> f x (fold_right f rest e);;

(*解答*)
let forall p l =
  fold_right (&&) (map p l) true;;

let exists p l =
  fold_right (||) (map p l) false;;

forall (fun x -> x>3) [1;2;3;4;5];;
forall (fun x -> x>0) [1;2;3;4;5];;
exists (fun x -> x>3) [1;2;3;4;5];;
exists (fun x -> x>6) [1;2;3;4;5];;


(*** Ex.5.6 ***)
print_string "\n***** Ex.5.6 *****";;

let rec quicker l sorted = 
  match l with
    [] -> sorted
  | [x] -> x :: sorted
  | x :: xs -> (* x is the pivot *)
    let rec partition left right = function
      (*[] -> (quick left) @ (x :: quick right)*)
        [] -> quicker left (x :: (quicker right sorted))
      | y :: ys -> if x < y then partition left (y :: right) ys
          else partition (y :: left) right ys
    in partition [] [] xs;;

quicker [3;1;4;1;5;9;2;6;5;3;5] [];;


(*** Ex.5.7 ***)
print_string "\n***** Ex.5.7 *****";;

let squares r =
  let rec find r i list =
      let fl_cand = sqrt (float_of_int (r - i*i)) in
      let int_cand = int_of_float fl_cand in
      if int_cand < i then
	list
      else if (fl_cand -. float_of_int int_cand) = 0.0 then
	find r (i+1) ((int_cand,i) :: list)
      else
	find r (i+1) list
  in
  find r 0 [];;

let check5_7 = squares 48612265;;
length check5_7;;


(*** Ex.5.8 ***)
print_string "\n***** Ex.5.8 *****";;

let map2 f l =
  let rec map_rec f l list =
    match l with
	[] -> list
      | head :: tail -> map_rec f tail (f head::list) in
  map_rec (fun x->x) (map_rec f l []) [];;
(* 末尾再帰で定義、順番が逆になるため、同じ関数を恒等変換で適応して順番を戻す  *)

map2 (fun x->x*2) [1;2;3;4;5];;



(*************** Ex.6 ***************)
print_string "\n\n*************** Ex.6 ***************";;

type nat = Zero | OneMoreThan of nat;;
let rec add m n =
match m with Zero -> n | OneMoreThan m' -> OneMoreThan (add m' n);;
let zero = Zero;;
let three = OneMoreThan(OneMoreThan(OneMoreThan Zero));;
let five = OneMoreThan(OneMoreThan(OneMoreThan(OneMoreThan(OneMoreThan Zero))));;

type 'a tree = Lf | Br of 'a * 'a tree * 'a tree;;
let comptree = Br(1, Br(2, Br(4, Lf, Lf),Br(5, Lf, Lf)),Br(3, Br(6, Lf, Lf),Br(7, Lf, Lf)));;

type 'a seq = Cons of 'a * (unit -> 'a seq);;
let rec from n = Cons (n, fun () -> from (n + 1));;
let head (Cons (x, _)) = x;;
let tail (Cons (_, f)) = f ();;
let rec take n s =
if n = 0 then [] else head s :: take (n - 1) (tail s);;
let rec nthseq n (Cons (x, f)) =
if n = 1 then x else nthseq (n - 1) (f());;


(*** Ex.6.1 ***)
print_string "\n***** Ex.6.1 *****";;

type figure =
Point
| Circle of int
| Rectangle of int * int
| Square of int;;

type loc_fig = {x : int; y : int; fig : figure};;

(*位置については、円は中心、長方形/正方形はそれが含む最も小さい座標（左下）*)
(*重なりは、共有する点を持つかどうかで判定*)

let rec overlap loc1 loc2 =
  (*正方形は長方形*)
  let l1 = match loc1.fig with
      Square l -> {loc1 with fig = Rectangle l l} 
    | _ -> loc1 in
  let l2 = match loc1.fig with
      Square l -> {loc2 with fig = Rectangle l l}
    | _ -> loc2 in 
  let pow2 x -> x*x in 
  match (l1.fig, l2.fig) with
      (Point,Point) -> (l1.x = l2.x) && (l1.y = l2.y)
    | (Point,Circle r) -> pow2 (l1.x-l2.x) + pow2 (l1.y-l2.y) <= pow2 r 
    | (Point,Rectangle xl yl) ->　l2.x<=l1.x && l1.x<=l2.x+xl && l2.y<=l1.y && l1.y<=l2.y+yl
    | (Circle r1,Circle r2) ->  pow2 (l1.x-l2.x) + pow2 (l1.y-l2.y) <= pow2 (r1+r2)
    | (Circle r,Rectangle xl yl) -> 
         if l2.x<=l1.x && l1.x<=l2.x+xl then 
	   l2.y - r <= l1.y && l1.y <= l2.y + yl + r
	 else if l2.y<=l1.y && l1.y<=l2.y+yl then 
	   l2.x - r <= l1.x && l1.x <= l2.x + xl + r
	 else overlap l1 {x=l2.x;    y=l2.y    ;Point} ||
	      overlap l1 {x=l2.x+xl; y=l2.y    ;Point} ||
	      overlap l1 {x=l2.x;    y=l2.y+yl ;Point} ||
	      overlap l1 {x=l2.x+xl; y=l2.y+yl ;Point}
    | (Rectangle xl1 yl1,Rectangle xl2 yl2) ->  
         l2.x-xl1 <= l1.x && l1.x <= l2.x + xl2
     &&  l2.y-yl1 <= l1.y && l1.y <= l2.y + yl2
    | _ -> overlap l2 l1;;

///////////////////////////////////////////////////////////////テストから

(*** Ex.6.2 ***)
print_string "\n***** Ex.6.2 *****";;

let int_of_nat n =
  let rec countCons n count =
  match n with
      Zero -> count
    | OneMoreThan n' -> countCons n' (count+1) in
  countCons n 0;;

let mul n1 n2 =
  let rec recmul n m ans =
  match n with
      Zero -> ans
    | OneMoreThan next ->
       recmul next m (add ans m) in
  recmul n1 n2 Zero;;

let rec monus n1 n2 =
  match (n1 , n2) with
      (Zero , _) -> Zero
    | (_ , Zero) -> n1
    | (OneMoreThan n1', OneMoreThan n2') -> monus n1' n2';;

int_of_nat five;;
mul five three;;
monus five three;;


(*** Ex.6.6 ***)
print_string "\n***** Ex.6.6 *****";;

let rec reflect tree = 
  match tree with
      Lf -> Lf
    | Br (comp,left,right) -> 
      let refl = reflect left in
      let refr = reflect right in
      Br (comp,refr,refl);;

(*
preorder(reflect(t)) = reverse (postorder(t))
inorder(reflect(t)) = reverse (inorder(t))
postorder(reflect(t)) = reverse (preorder(t))
*)

reflect comptree;;


(*** Ex.6.9 ***)
print_string "\n***** Ex.6.9 *****";;

let rec sift n (Cons(x,f)) =
  if x mod n = 0 then
    sift n (f())
  else
    Cons (x ,fun () -> sift n (f()));;

let rec sieve (Cons (x, f)) = Cons (x, fun () -> sieve (sift x (f())));;
let primes = sieve (from 2);;

nthseq 5870 primes;;



(*** Ex.6.10 ***)
print_string "\n***** Ex.6.10 *****";;

type ('a, 'b) sum = Left of 'a | Right of 'b;;

(*1*)
let fun6_10_1 (a,s) =
   match s with
     Left l -> Left (a,l)
   | Right r -> Right (a,r);;

(*2*)
let fun6_10_2 (s1,s2) =
  match (s1,s2) with
      (Left x, Left y) -> Left (Left (x,y))
    | (Left x, Right y) -> Right (Left (x,y))
    | (Right x, Left y) -> Right (Right (x,y))
    | (Right x, Right y) -> Left (Right (x,y));;

(*3*)
let fun6_10_3 (f,g) s  =
  match s with
      Left l -> f l
    | Right r -> g r;;

(*4*)
let fun6_10_4 f =
  ((fun x -> f (Left x)),(fun x -> f (Right  x)));;

(*5*)
let fun6_10_5 s =
  match s with
      Left l -> (fun x -> Left (l x))
    | Right r -> (fun x -> Right (r x));;



(*************** Ex.7 ***************)
print_string "\n\n*************** Ex.7 ***************";;

(*** Ex.7.2 ***)
print_string "\n***** Ex.7.2 *****";;

let incr p =
  p := !p + 1;;

let x = ref 3;;
incr x;;
!x;;

(*** Ex.7.4 ***)
print_string "\n***** Ex.7.4 *****";;

let fact_imp n =
  let i = ref n and res = ref 1 in
  while !i>=0  do
    if !i > 0 then
      res := !res * !i;
    i := !i - 1
  done;
  !res;;

fact_imp 5;;

(*** Ex.7.6 ***)
(*
空リストの参照型は a_' list ref であり、テキスト違い1度のみ型変数に
具体的な型を代入できるようになっている。

従って、テキストの
# (2 :: !x, true :: !x);;
の式の時点で、２つめのconsが型エラーのため実行できない。

このように代入できる型変数を一度のみに限定することで参照先のリストの
内容の型を変更不可にし、内部の型が変更になったことによるconsの衝突を
防止している。
*)

(*** Ex.7.8 ***)
print_string "\n***** Ex.7.8 *****";;

let rec change = function
    (_, 0) -> []
  | ((c :: rest) as coins, total) ->
     if c > total then change (rest, total)
     else
       (try
          c :: change (coins, total - c)
        with Failure "change" -> change (rest, total))
  | _ -> raise (Failure "change");;

(*
残金よりも大きな硬化があった場合には原則残金の一部をその硬化と交換して再帰を行うが、
その再帰の結果うまくお金を崩せなかった場合（例外Failureが発生した場合）には
交換をせずに再帰を続行する。
残金が０になるより前に交換できる硬化のリストが空になる場合が新しく生まれうるので、
この場合には換金不可として例外を返す。

これは、「一度試してみて上手くいかなければ別の道を試す」という、
いわゆる深さ優先探索の実行となる。

*)


change ([50; 20; 10; 5; 2; 1], 43);;
change ( [25; 10; 5; 1], 43);;
change ([5; 2], 16);;
