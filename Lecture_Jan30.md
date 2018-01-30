# Lecture 30 January 2018

## Datatype -- Tree

A user-defined recursive datatype.

> The __recursive__ structure allows easy recursion and induction proof.

- We want to be able to represent __empty trees__ (as base case).

```
    1
  2 _
_ _    # empty sub-trees - we have to somehow represent those
```

- We want to represent "Nodes" that contain a __left__ sub-tree, an integer, and a __right__ sub-tree.
- For the moment, that's it.

How do we tell ML about all this?

### Induction of Datatype

```SML
  datatype tree = Empty | Node of tree * int * tree

  (* A constant constructor: it constructs a value called "Empty" with type "tree". *)
  (* It is convention to capitalize constant constructor value. *)
  (* "of" says we want some more stuff for the constructor Node *)

  (* If we re-define the datatype of the same name, the old definition is shadowed. *)
  (* No mutation after a "Node" is constructed. *)

  (* "Node" is also a function -- Node : tree * int * tree -> tree *)
```

Some example values of this new datatype:

```SML
  1| Empty : tree
  2| val t1 : tree = Node(Node(Empty, 2, Empty), 1, Empty)
  3| val t2 : tree = Node(Empty, 3, Node(Empty, 4, Empty))
  4| val T : tree = Node(t1, 5, t2)
```

Suppose we want "mutation" at run-time:

```SML
fun change_to_6 (Node(left, _, right) : tree) : tree = Node(left, 6, right)
  | change_to_6 Empty = Empty
```

> Note: There is no actual mutation. The new defined Node shadows the old Node.

### More with Trees

Consider a function to define the height of a tree:

```SML
(* height : tree -> int *)
fun height (Empty : tree) : int = 0
  | height (Node(left, _, right)) = 1 + Int.max(height left, height right)

val 3 = height T
```

> Note: `Int` is a structure, and `Int.max` is a built-in function.

