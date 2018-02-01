# Lecture 6 Asymptotic Analysis

## Definition Revisit

Suppose $f$ and $g$ are two positive-valued mathematical functions defined on (at least) the natural numbers. We say that $f(n)$ is $O(g(n))$ if there exists constant $c\in\mathbb{N}$ such that $f(n)\leq c\cdot g(n)$ for all $n\geq N$.

Consider $f(n)=n^2$ and $g(n)=n^2+n+3$. $f(n)=O(g(n))$ and $g(n)=O(f(n))$. Or, $f$ and $g$ have the same asymptotic complexity (quadratic).

## Analysis of Two Functions

Consider our function `append` and `rev` before.

```SML
fun @ (nil : int list, L2 : int list) : int list = L2
  | @ (x::xs, L2) = x :: (@ (xs, L2))
infixr @

fun rev (nil : int list) : int list = nil
  | rev (x::xs) = (rev xs) @ [x]
```

So `@` has two arguments. Consider `n` length of first list, `m` length of second list.

Analyze "work" of the function: $W(n, m)$.

For `n = 0`, $W(0, m) = c_0$, which is a constant.

For `n >= 1`, $W(n, m) = c_1 + W(n-1, m)$, where $c_1$ is the constant time of `cons`.

> Note: This is not yet a solution. It's just a recursive analysis of the recurrent work.

An informal argument for the proof:

```
    W(n, m) = c1 + W(n - 1, m)
            = c1 + c1 + W(n - 2, m)
            = c1 + c1 + c1 + W(n - 3, m)
            = ...
            = c1 +...+ c1 + c0
```

This is called "unrolling the recurrence".

By observation, we can __conjecture__ the complexity is linear.

Then, we can prove this formally by __induction__.

