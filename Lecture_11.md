# Combinators & Staging

### Composition Function

```SML
infix o
fun f o g = fn x => f (g x)
fun (f o g) x = f (g x) (* curried version *)
```

## What Is Function

Mathematically, we consider the connections between functions, abstracting from the actual value spaces underlying the definitions.

#### Ideas

- Type Theory
- Category Theory

### Functions in Spaces

Consider the space of __integer-valued__ functions, i.e. some function taking `t` from a __type space__ to some value in the __integer space__.

Then, we have __addition__ of functions, capturing addition of integers.

In math, we would use a __point-wise__ principal to define `f ++ g` as `(f ++ g)(x) = f(x) + g(x)`.

Here, we "lift up" the __integer space__ into the space of __integer-valued functions__.

### Valid Definitions Reflected in ML

```SML
infix ++
infix **
fun (f ++ g) x = (f x) + (g x)
fun (f ** g) x = (f x) * (g x)
```

__Question.__ What is the type of the above functions?

```SML
('a -> int) * ('a -> int) -> 'a -> int
```

__Note.__ `f` and `g` could take in different instances of `'a`, but cannot be inconsistent.

#### Function `MIN`

```SML
fun MIN (f, g) x = Int.min (f x, g x)
```

> Side Note. If `Int.min` is replaced to be polymorphic, as long as the types could be worked out, the compiler could make a `'b` type out of it.

### What To Do with Functions (As Values!)

```SML
fun double x = 2 * x
fun square x = x * x

fun quadratic x = x * x + 2 * x

(* rewrite the above definition *)
val quadratic = square ++ double

(* functions are values *)
```

We can see the Ring structure, not upon the integer space, but now upon the integer-valued function space!

```SML
val lower = MIN (square, double)
(* This gives us the lower envelope of the two integer functions! *)
```

FUNCTIONS ARE VALUES!

We've __abstracted__ away the explicit definition of functions. So we can treat them as __values__!

##### Functions Are Values!

## Staging

```SML
fun f (x : int, y : int) : int =
  let
    val z : int = horrible_computation x
  in
    good_computation (z, y)
  end

f (5, 2) (* 10 months *)
f (5, 7) (* 10 months *)
f (5, 8) (* 10 months *)
```

We want to pull out stuff we don't want to recompute.

So consider currying!

```SML
fun g (x : int) (y : int) : int =
  let
    val z : int = horrible_computation x
  in
    good_computation (z, y)
  end

val g' = g 5  (* 10 months *)
g' 2          (* 0.0000000000000000000000000000000000001 second *)
g' 7          (* 0.0000000000000000000000000000000000001 second *)
g' 8          (* 0.0000000000000000000000000000000000001 second *)
```

