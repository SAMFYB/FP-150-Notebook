# Lecture 19 Sequences (Cost Graphs)

April 3, 2018

__dag__: Cars don't run into each other!

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

