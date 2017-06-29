open Syntax
open Eval

let rec read_eval_print env =
(* Ex3.2.2 によりエラー時に処理を行う*)
 let error_print ans = 
    print_string ("<Error> " ^ ans);
    print_newline();
    read_eval_print env in
try
  (* 本体 *)
  print_string "# ";
  flush stdout;
  let decl =
       Parser.toplevel Lexer.main (Lexing.from_channel stdin) in
  let (id, newenv, v) = eval_decl env decl in
    Printf.printf "val %s = " id;
    pp_val v;
    print_newline();
    read_eval_print newenv
(* Ex3.2.2 によりエラーをキャッチする*)
 with Failure ans -> error_print (ans ^ " (Failure)")
   | Eval.Error ans -> error_print (ans ^ " (Eval.Error)")
   | _ -> error_print "syntax error (Another)"



let initial_env = 
  Environment.extend "i" (IntV 1)
    (Environment.extend "v" (IntV 5) 
       (Environment.extend "x" (IntV 10)
	  (* Ex3.2.1 により大域環境拡張  ii = 2, iii = 3, iv = 4 *)
	  (Environment.extend "ii" (IntV 2)
	     (Environment.extend "iii" (IntV 3) 
		(Environment.extend "iv" (IntV 4) Environment.empty)))))

let _ = read_eval_print initial_env


(* [Ex3.2.1 実行例]
  # iv + iii * ii;;　拡張したii,iii,ivを用いて演算できる
  val - = 10  
　# iv < iii + 2;; 新しい変数で不等号判定、数字も混ぜられる
  val - = true
*)

(* [Ex3.2.2 実行例] 
   # newVal;;　レクサーのエラー
    <Error> lexing: empty token (Failure)
   # a;;　定義していない変数
    <Error> Variable not bound: a (Eval.Error)
   # 1 + true;;　二項演算でboolを使用したら
    <Error> Both arguments must be integer: + (Eval.Error)
   # if 1 then 2 else 3;; if式の条件に整数を使用したら
    <Error> Test expression must be boolean: if (Eval.Error)
   # + 1 2;;　文法がおかしい時
    <Error> syntax error (Another)

   Eval.ErrorとFailureについてはエラー原因を拾って表示できている
   それ以外のエラーについても syntax error として逃さずに拾えている
*)

(*[Ex3.2.3 実行例]
  # true && false;; 基本的な論理積
   val - = false
  # true || false;; 基本的な論理和
   val - = true
  # true || true && false;; 結合は論理積の方が強い
   val - = true
  # 4 < 1 || 4 < 10;; 不等号を要素に持てる
   val - = true
  # 2 && 3;; bool値以外は受け付けない
   <Error> Both arguments must be boolean: && (Eval.Error)
*)

(*[Ex3.3.1 実行例]
  # let a = 1;; 変数に新たに束縛
   val a = 1
  # a;;　参照できる
   val - = 1
  # a + 6 < 7;;　式の中で使用できる
   val - = false
  # let a = 2;; 束縛の上書き
   val a = 2
  # a + 6 < 8;; 静的に束縛が決定する
   val - = false
  # let b = 6 in a*b;; let-in式が使用できる
   val - = 12
  # b;;　let-in式内の束縛のレンジはその式内のみ
  　<Error> Variable not bound: b (Eval.Error)
  # let a = 5 in let b = a*2 in a*b;; let-in式は繋げていくことができる
   val - = 50
*)
