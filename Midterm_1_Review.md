# Midterm 1 Review

## Work Analysis

```SML
(* Find : int * tree -> bool
 * REQ: true
 * ENS: Find (x, T) ===> true if x is in T | false otherwise
 *)
fun Find (x, Empty) = false
  | Find (x, Node(L, y, R)) =
    case (x = y) of
      true => true
    | false => let
                 val (b1, b2) = (Find (x, L), Find (x, R))
               in
                 b1 orelse b2
               end
```

> Note: This code is not optimized, but only for work/span analysis purpose.

### Work/Span Analysis of the Above Function regarding Size

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/9c9cb0a05948ad4e9ac278f4a3582153.svg?invert_in_darkmode" align=middle width=230.8185pt height=164.907765pt/></p>

> Note: This is also of $O(2^d)$.

__Exam.__ We are looking for 1. Recurrence, 2. Summation, 3. Big-O bound.

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5d520d752d41a4862a6f14a2c62049a5.svg?invert_in_darkmode" align=middle width=199.7985pt height=139.72596pt/></p>

> Note: This is also of $O(log(n))$.

## Totality

### Definition

A function `f` is total if for any valid input __value__ `v`, `f v` always reduces to a __value__.

Consider: `f (g ())` $\cong$ `1`?

This is wrong! `g ()` might not reduce to a __value__. (In fact, we have to know the totality of `g`.)

