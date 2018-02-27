# Lecture 12 Continuation Passing Style (CPS)

## Definition of Continuation

A __continuation__ is a function argument that encapsulates "what to do with the result".

__Key Point:__ Rather than return the result directly, `f` hands the result off to `k`, as follow:

```sml
fun f {a bunch of args} k =
  let
    {a bunch of computations}
  in
    k {result of computations}
  end
```

__Expressive Power:__ Because `k` appears as an argument the function `f` can manipulate it, e.g. treat it like a functional accumulator argument, frequently producing tail-recursive code.

__Caution:__ If `f` is recursive, it cannot wait for return values, but must build new continuations that expect such return values.

## Simple Examples

```sml
fun add (x, y, k) = k (x + y)

add (3, 4, fn r => r) => 7
add (3, 4, fn r => Int.toString r) => "7"
```

## Some More Examples

A normal implementation of a recursive `sum` over a list.

```sml
fun sum [] = 0
  | sum (x::xs) = x + (sum xs)
```

Implementation using __continuation__.

```sml
fun csum [] k = k 0
  | csum (x::xs) k = csum xs (fn s => k (x + s))
```

__Question.__ What is the connection between `sum` and `csum`?

Consider the `spec` of `csum`:

```
(* csum : int list -> (int -> 'a) -> 'a
 * req : true
 * ens : csum L k === k (sum L)
 *)
```

