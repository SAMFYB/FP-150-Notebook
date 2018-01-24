# Recitation 2

Wednesday 24 January 2018

## Pattern Matching

What stuff can you pattern match on?
- constants (1,2,3...)
- variables
- constructors
- tuples
- wildcards

> Examples

```SML
fun foo (0:int) : int = 1     (* matching a constant *)
  | foo (x:int) : int = x - 1 (* matching a variable *)

fun bar ([]:int list) : int = 0             (* matching a constant *)
  | bar (x::L : int list) : int = x + bar L (* matching a constructor *)

(* returns (x <= y) *)
fun cmp (0:int, _:int) : bool = true (* matching constant and wildcard *)
  | cmp (_, 0) = false               (* same *)
  | cmp (x, y) = cmp (x - 1, y - 1)  (* matching variables *)
```

