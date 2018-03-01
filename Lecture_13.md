# Lecture 13 Continuation Continued & Misc

## Exception Handling

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
  if Real.abs r2 <= 0.00001 then raise Divide else r1/r2
```

> Note. `op /` has type `real * real -> real`.

