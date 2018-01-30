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

Question: could we run into something cyclical?

> By an inductive proof, we can show there could be __no__ cycles. Most likely in functional programming, we build something from base case and a well-defined constructor. Then we can prove totality. If you somehow want to have cycles: 1) there will be reference cells, 2) there will be "stream" that can somehow mimic cyclical behaviors, 3) as for graphs, we represent the data structure with functions, and that normally will give us cycles.

__Theorem.__ `height` is total. (Essentially, we have to prove it terminates.)

__Proof.__ We prove this by structural induction on the datatype.

__Base Case.__ `T = Empty`.

__Want-to-Show.__ `height(Empty) ===> (some value)`.

```SML
     height(Empty)                [by clause 1 of height]
===> 0 (* which is a value *)
```

__Induction Step.__ `T <> Empty` by assumption, so `T = Node(left, x, right)` for some integer `x` and some trees `left` and `right`.

__Induction Hypothesis.__ `height left ===> (some value) h_l` and `height right ===> (some value) h_r`.

> Be clear about what you're doing. Be pedantic if necessary.

__Want-to-Show.__ `height T ===> (some value)`.

```SML
     height T
===> height Node(left, x, right)               [* by referential transparency]
===> 1 + Int.max(height left, height right)    [by clause 2 of height]
===> 1 + Int.max(h_l, h_r)                     [by IH, and h_l, h_r are some values]
===> 1 + h_max                                 [h_max of some value, assuming Int.max is total]
===> (some value)                              [assuming + is total]
```

> Note: When we do these proofs, we automatically assume the possible values __typecheck__.
>
> Note: In this case, we want a __reduction__ instead of an __equivalence__. An argument for __equivalence__ is in fact weaker.

Question: Do we only use structural induction to prove totality?

> No. We can use structural induction to prove many things. It's powerful!

> Note: __Reduction__ automatically gives you __extensional equivalence__. But you have to be careful. Especially, if you only have __equivalence__ in the __IH__, then there could be problems.

### Another Type of Trees

Suppose we only want data be held on leaves:

```SML
  datatype tree = Leaf of int | Node of tree * tree
```

Consider a function to convert this type of trees into a list (in-order traversal):

```SML
fun flatten (Leaf x : tree) : int list = [x]
  | flatten (Node(left, right)) = flatten left @ flatten right
```

