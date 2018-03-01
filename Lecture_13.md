# Lecture 13 Continuation Continued & Misc

## Exceptions

We can define new exceptions like this:

```sml
exception Divide (* a new exception *)
Divide : exn (* "extensible" type: you can add new constructor to it at runtime *)
```

### A Real Division using Exception

```sml
(* divide : real * real -> real
 * req : true
 * ens : divide (r1, r2) = r1/r2 unless r2 is small which raises Divide
 *)
fun divide (r1 : real, r2 : real) : real =
  if Real.abs r2 <= 0.00001 then raise Divide else r1 / r2
```

> Note. `op /` has type `real * real -> real`.

__Type-Check.__ If `e : exn` then `raise e : 'a`.

### A more complicated Exception

```sml
exception Rdivide of real
Rdivide : real -> exn

fun Rdiv (r1, r2) = if Real.abs r2 <= 0.00001 then raise Rdivide r2 else r1 / r2
```

By this, we've done __error signaling__.

### Error Handling

```
  e handle p1 => e1
           p2 => e2
           ... (* pattern matching exceptions *)
```

Constraint: `e, e1, ..., en` must have the same type! (So we can think of the entirety as an expression.)

No need to be exhaustive: If no pattern matches an exception raised by `e`, then the original exception percolates out.

