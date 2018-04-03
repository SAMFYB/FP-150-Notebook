# Lecture 19 Sequences (Cost Graphs)

April 3, 2018

__dag__: Cars don't run into each other!

## Cost Graphs

Cost Graph: Parallel Series, DAG with single source & sink.

__Example:__

```
(1 + 2) + 3

          _
         / \
        _   3
       / \  |
      1   2 |
        V   |
        _   /
          V
          _
```

| Base Case | Serial Computation | Parallel Computation |
| --------- | ------------------ | -------------------- |
| Single Node (sink = source) | o-o | See Below |

```
    _
   / \
  _   _
    V
    _
```

__Work__ is Number of Nodes
__Span__ is Length of the Longest Path (Count Edges)

For example, in the above `(1 + 2) + 3` instance, `W = 7` and `S = 4`.

__Brent's Theorem__: Time to perform a computation is <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/8439b70bf473858853994d1a6012877b.svg?invert_in_darkmode" align=middle width=107.49453pt height=28.67073pt/> where <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/2ec6e630f199f589a2402fdf3e0289d5.svg?invert_in_darkmode" align=middle width=8.270625pt height=14.15535pt/> is the number of processors.

__Example:__

```
(1 + 2) + (3 + 4)

         A
     B       G
   C   D   H   I
     E       J
         F

(Constraint: Computations below need results from Nodes above.)

Time / Processors (#1, #2)
-----+--------------------
  1  |  A
  2  |  B  G
  3  |  C  D
  4  |  H  I
  5  |  E  J
  6  |  F
```

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d9296a5db2a038abb470f5edc833087c.svg?invert_in_darkmode" align=middle width=218.6547pt height=36.82569pt/></p>

__Note:__ The particular structure of this graph does not allow the actual optimal to be achieved.

## Sequences

__Question:__ What is the cost of finding the length of a list? How can we do better? If we define our own type?

- Sequences are like `list` as we can walk through it sequentially.
- Sequences are like `tree` as it has `log` properties.

__Notation:__ <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/ac8ee1bcaf9adabf24373dc81cc947c9.svg?invert_in_darkmode" align=middle width=114.95253pt height=17.72397pt/>

### Implementation

```sml
signature SEQ =
sig
  type 'a seq (* abstract *)

  val empty : unit -> 'a seq (* notation: <> *)
  (* We need this so that in the same code we can have 'a seq, 'b seq, so on at the same time. *)
  (* In addition, the initialization function allows us to do stuff behind the scene. *)

  (* Side Note
   * We cannot pattern match directly on sequences.
   * We can however pattern match with 'list view' & 'tree view' of sequences.
   *)

  exception Range (* like 'index out of range' *)

  val tabulate : (int -> 'a) -> int -> 'a seq
  val length : 'a seq -> int
  val nth : 'a seq -> int -> 'a
  val map : ('a -> 'b) -> 'a seq -> 'b seq (* like 'map' for List *)
  val reduce : ('a * 'a -> 'a) -> 'a -> 'a seq -> 'a (* like 'fold' but has a more stricted type *)
  val mapreduce : ('a -> 'b) -> 'b -> ('b * 'b -> 'b) -> 'a seq -> 'b
  val filter : ('a -> bool) -> 'a seq -> 'a seq

  (* etc. *)
end
```

### Analysis of the Implementation above with Cost Graphs

- `empty () = <>`: constant work & span
- `tabulate f n =` <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/59fd60444d3014622039c292bc4a180f.svg?invert_in_darkmode" align=middle width=154.615725pt height=24.6576pt/>

__Cost Graph__ for `tabulate`:

```
                [SOURCE]
   f(0) f(1) ... ... ... f(n-1)
                 [SINK]
```

Suppose `f` has constant work & span, then <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/f4a2a08c15af030f2ba0eaebaeb7a879.svg?invert_in_darkmode" align=middle width=75.37365pt height=24.6576pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/cf524806204b9b8fb6a5a94f0edb2fa4.svg?invert_in_darkmode" align=middle width=66.94512pt height=24.6576pt/>.

However, `tabulate` for `List` has work and span of both <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> because `List` has no random access.

- `nth <x0,...,xn-1> i = xi if 0 <= i <= n-1 | raise Range otherwise`
  - Cost Graph: `o-o`
  - <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d73e2d0cb090623c71aa8260406fa70d.svg?invert_in_darkmode" align=middle width=106.671015pt height=24.6576pt/>
  - For `List`: <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/306dcddce5e721bcd99910ad3179124f.svg?invert_in_darkmode" align=middle width=108.318705pt height=24.6576pt/>

- `map f <x0,...,xn-1>`: same __cost graph__ as `tabulate`

---

- Assuming `g` is __associative__
  - Think of `g` as an `infix` operator
- `reduce g z <x0,...,xn-1> = x0 * x1 *...* xn-1 * z` where `*` is the infix operator defined by `g`

__Side Note:__ Sometimes (e.g. in 210) we assume `z` is an identity for `g`, which means it does not matter where to put `z` in the sequence. This is powerful for writing efficient parallel code.

__Cost Graph__ for `reduce`:

```
                              [SOURCE]
      _ _   _ _   _ _   _ _   ...   ...   _ _
       V     V     V     V       ...       V
       _     _     _     _       ...       _
          V           V                 V
                V             ...
                        [SINK]
```

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/50705407a2038b6e30a9da27d4cbd880.svg?invert_in_darkmode" align=middle width=75.37365pt height=16.438356pt/></p>
<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/b8fb0111e9245449f511e492e453171b.svg?invert_in_darkmode" align=middle width=103.00488pt height=16.438356pt/></p>

- `mapreduce f z g <x0,...,xn-1> = f(x0) * f(x1) *...* f(xn-1) * z`
- Work & Span is same as `reduce`

---

- `filter p <x0,...,xn-1> = <all xi s.t. p xi = true`
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/f4a2a08c15af030f2ba0eaebaeb7a879.svg?invert_in_darkmode" align=middle width=75.37365pt height=24.6576pt/> and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/b049cd3ebde6a8c2ebde2bea87c8e562.svg?invert_in_darkmode" align=middle width=103.005045pt height=24.6576pt/> because there is some additional work (for span)

---

```sml
structure Seq :> SEQ = struct (* etc. *) end

fun sum (s : int Seq.seq) : int = Seq.reduce (op +) 0 s

type row = int Seq.seq
type room = row Seq.seq (* 2D sequence *)

fun count (class : room) : int = sum (Seq.map sum class)

fun count' (class : room) : int = Seq.mapreduce sum 0 (op +) class (* alternative implementation *)
```

For `count'`

```
                          [SOURCE]
      [sum R1]   [sum R2] ... ... ...  [sum Rn]
               V             V  ...
                    ...
                    [SINK]
```

$$ S = O(log(n) + log(m)) $$

