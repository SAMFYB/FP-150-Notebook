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

