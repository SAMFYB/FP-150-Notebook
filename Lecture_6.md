# Lecture 6 Asymptotic Analysis

## Definition Revisit

Suppose <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/190083ef7a1625fbc75f243cffb9c96d.svg?invert_in_darkmode" align=middle width=9.8175pt height=22.83138pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/3cf4fbd05970446973fc3d9fa3fe3c41.svg?invert_in_darkmode" align=middle width=8.43051pt height=14.15535pt/> are two positive-valued mathematical functions defined on (at least) the natural numbers. We say that <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/3d425a215e8eeb2a056f553633aaae4a.svg?invert_in_darkmode" align=middle width=32.469855pt height=24.6576pt/> is <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5e264321b62240fe80d33a9a9e73f1ca.svg?invert_in_darkmode" align=middle width=56.86362pt height=24.6576pt/> if there exists constant <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/a7fbe5b54077f34262525434e4dc1090.svg?invert_in_darkmode" align=middle width=39.077115pt height=22.64856pt/> such that <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/30bc9e98106ed295eed7f2b91fc70f9e.svg?invert_in_darkmode" align=middle width=104.45589pt height=24.6576pt/> for all <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/351d843943797c7cd25c7ce8abdcea2a.svg?invert_in_darkmode" align=middle width=46.784595pt height=22.46574pt/>.

Consider <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/337a108f34c35f02fb3480e42674ca42.svg?invert_in_darkmode" align=middle width=70.80678pt height=26.76201pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/6de708801d3679602277074ec752159b.svg?invert_in_darkmode" align=middle width=128.510085pt height=26.76201pt/>. <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/603fd07165a17c7ad477e730ecd866b4.svg?invert_in_darkmode" align=middle width=111.25092pt height=24.6576pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/aaff3c7903924cee364c08d7a4b5c947.svg?invert_in_darkmode" align=middle width=111.25092pt height=24.6576pt/>. Or, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/190083ef7a1625fbc75f243cffb9c96d.svg?invert_in_darkmode" align=middle width=9.8175pt height=22.83138pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/3cf4fbd05970446973fc3d9fa3fe3c41.svg?invert_in_darkmode" align=middle width=8.43051pt height=14.15535pt/> have the same asymptotic complexity (quadratic).

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

Analyze "work" of the function: <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1a0256f96451d8b12fa5a64f0b254178.svg?invert_in_darkmode" align=middle width=62.199555pt height=24.6576pt/>.

For `n = 0`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/4254a7fee1ae66eeb746ebc9a500df37.svg?invert_in_darkmode" align=middle width=96.13593pt height=24.6576pt/>, which is a constant.

For `n >= 1`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/73153338382bc11f76e53b218fa67547.svg?invert_in_darkmode" align=middle width=209.206305pt height=24.6576pt/>, where <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/988584bba6844388f07ea45b7132f61c.svg?invert_in_darkmode" align=middle width=13.666455pt height=14.15535pt/> is the constant time of `cons`.

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

