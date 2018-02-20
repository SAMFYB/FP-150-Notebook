# Lecture 10 Curried Functions & Higher-Order Functions

## Review of Function Definition, Evaluation, & Binding

Consider the definition of a function:

```SML
(* add : int * int -> int *)
fun add (x : int, y : int) : int = x + y
```

What happens upon this definition?

Namespace `add` is bind to a lambda expression __and__ the prior environment.

Now consider another definition:

```SML
fun plus (x : int) : int -> int = fn (y : int) => x + y
(* The type of function plus:
 * plus : int -> int -> int
 * OR int -> (int -> int)
 * They are the same because functions are right-associative. *)
```

Namespace `plus` is bind to a lambda expression in which there is another lambda expression, and the prior environment (including the binding of `add`).

Now consider the binding `val incr 3 = plus 3`.

What is bind to `incr 3`?

Let's consider the evaluation trace:

```
    plus 3
==> (extend the env) [env when plus defined] [3/x] body of plus
==> [env...] [3/x] (fn y => x + y)
```

Therefore, `incr 3` is the value `fn y => x + y` and the `[env...]` __and__ the binding `[3/x]`.

Now consider the call `incr 3 4`.

Evaluation trace:

```
    incr 3 4
==> [env when incr 3 defined] [4/y] body of incr 3
==> [env...] [3/x] [4/y] x + y
==> (find and substitute the bindings) 3 + 4
==> 7
```

