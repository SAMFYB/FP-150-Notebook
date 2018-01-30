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

