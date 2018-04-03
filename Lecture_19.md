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

