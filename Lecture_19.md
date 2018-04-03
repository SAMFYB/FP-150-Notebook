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

__Brent's Theorem__: Time to perform a computation is $O(max(\frac{W}{p},S))$ where $p$ is the number of processors.

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

$$ max (\frac{W}{p}, S) = max (\frac{10}{2}, 4) = 5 $$

__Note:__ The particular structure of this graph does not allow the actual optimal to be achieved.

## Sequences

__Question:__ What is the cost of finding the length of a list? How can we do better? If we define our own type?

- Sequences are like `list` as we can walk through it sequentially.
- Sequences are like `tree` as it has `log` properties.

__Notation:__ $<x_0,...,x_{n-1}>$

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

