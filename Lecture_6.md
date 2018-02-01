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

### The `append` Function

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

### The `rev` Function

Now, let's analyze the function `rev`.

`rev` has one argument. Let `n` be the length of the list.

For `n = 0`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/e3f23706bb66633b8a71bd8460c1f650.svg?invert_in_darkmode" align=middle width=74.397015pt height=24.6576pt/>, which is a constant.

For `n >= 1`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1ecc390c60f43813584ce33525117b0b.svg?invert_in_darkmode" align=middle width=278.745555pt height=24.6576pt/>.

> Note: In order to determine the arguments for the complexity of `append` used here, we have to know that function `rev` does not change the length of the list input.

We know the complexity of the function `append`, so we can substitute and continue our analysis:

```
    W(n) <= k0 + k1(n - 1) + W(n - 1)
         <= k0' + k1'(n) + W(n - 1)
         ::
         <= k0' + k1'(n) + k0' + k1'(n - 1) + W(n - 2)
         <= k0' + k1'(n) + k0' + k1'(n - 1) + k0' + k1'(n - 2) + W(n - 3)
         <= ...
         == (n)(k0') + (k1')(1 +...+ n) + k0
```

Thus, we __conjecture__ this is of order <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/021273d50c6ff03efebda428e9e42d77.svg?invert_in_darkmode" align=middle width=16.41948pt height=26.76201pt/>.

### The Tail Recursive `rev`

Now, let's analyze the *tail recursive* version of the function.

```SML
fun trev (nil : int list, acc : int list) : int list = acc
  | trev (x::xs, acc) = trev(xs, x::acc)
```

Consider <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.867pt height=14.15535pt/> the length of first list, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/0e51a2dede42189d77627c4d742822c3.svg?invert_in_darkmode" align=middle width=14.43321pt height=14.15535pt/> the length of the accumulator.

For `n = 0`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/4254a7fee1ae66eeb746ebc9a500df37.svg?invert_in_darkmode" align=middle width=96.13593pt height=24.6576pt/>. We are just returning, __not__ copying anything.

For `n >= 1`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/f2b9e088938cc0beed3bf71344d35575.svg?invert_in_darkmode" align=middle width=237.517005pt height=24.6576pt/>.

> Note: It's important to think carefully about the __size__ of the arguments.

By observing the recurrent structure, we __conjecture__ this is again of linear time.

## Analysis of Trees

Consider this definition of the datatype `tree`:

```SML
datatype tree = Empty | Node of tree * int * tree

(* sum : tree -> int *)
fun sum (Empty : tree) : int = 0
  | sum (Node (left, x, right) = sum left + x + sum right
```

Let's consider the complexity of the function `sum`.

Consider "work" in terms of the size of the tree <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.867pt height=14.15535pt/>.

> Note: Sometimes we consider "work" or "span" in terms of the __depth__ of the tree.

> Important: The size <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.867pt height=14.15535pt/> here refers to the number of __nodes__. Sometimes we might want it different.

For `n = 0`, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/e3f23706bb66633b8a71bd8460c1f650.svg?invert_in_darkmode" align=middle width=74.397015pt height=24.6576pt/>, a constant, for an `Empty` tree.

For a non-`Empty` tree, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5d609be6cda20e20d5ecee776e348864.svg?invert_in_darkmode" align=middle width=253.335555pt height=24.6576pt/>.

We also know that <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/ce43541aa5d2e3c25f54d1ee14ab55c7.svg?invert_in_darkmode" align=middle width=126.97575pt height=19.17828pt/>.

__Conjecture:__ <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1501eddc53532a2bb87564a1eec93b1e.svg?invert_in_darkmode" align=middle width=136.073025pt height=24.6576pt/>.

> Consider: In fact, considering the work done in each `Node`, should be all <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/988584bba6844388f07ea45b7132f61c.svg?invert_in_darkmode" align=middle width=13.666455pt height=14.15535pt/>.

