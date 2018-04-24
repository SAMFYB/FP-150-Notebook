# Context-Free Grammar & Parsing

- Regular Languages -> Finite Automata
- Context-Free -> Finite Automata with a single Stack

## Context Free Grammar of ML

What is a program? An expression? A match? A pattern?

```
P ==> e | E; P
E ==> E + E | E andalso E | case E of M | fn M | ...
M ==> Q => E | Q => E \| M
Q ==> ...
```

It's called "context-free" because we can substitute anything with any instance of its extension.

More about grammar and parsing [here](https://github.com/SAMFYB/reading-notes-on-compiler).

Further reading: Elements of the Theory of Computation by Lewis and Papadimitriou.

## Code a Parser for Lambda Calculus (very likely Scheme)

```sml
datatype token = LPAREN | RPAREN | LAMBDA | ID of string | DOT
datatype exp = Fun of string * exp
             | App of exp * exp
             | Var of string
(* (Lx.xy) => LPAREN, LAMBDA, ID x, DOT, ID x, ID y, RPAREN
 *         => App (Fun (x, Var x), Var y) // Abstract Syntax Tree
 *)

(* parse : token list -> (exp * token list -> 'a) -> 'a
 * ens : parse T k == k (E, T2) if T = T1 @ T2 s.t. T1 is derivable in G with E
 *                 raise parse error if this is not possible
 *)
exception ParseError
fun parse ((ID x) :: ts) k = k (Var x, ts)
  | parse (LPAREN :: ts) k =
      parse ts (fn (e1, t1) =>
        parse t1 (fn (e2, RPAREN :: t2) =>
          k (App (e1, e2), t2) | _ => raise ParseError))
  | parse (LAMBDA :: (ID x) :: DOT :: ts) k =
      parse ts (fn (e, ts') => k (Fun (x, e), ts'))
  (* ... *)
  | parse _ = raise ParseError
```

