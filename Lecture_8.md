# Lecture 8

## Revisit Insert in Trees

```SML
fun Ins(x, Empty) = Node(Empty, x, Empty)
  | Ins(x, Node(L, y, R)) =
    case Int.compare(x, y) of
      GREATER => Node(L, y, Ins(x, R))
    | _ => Node(Ins(x, L), y, R)
```

The Work and Span are both $O(n)$. Or in fact, it is also $O(d)$. In the worst case, $d = n$.

For balanced trees, $d = O(log(n))$.

## Revisit Merge Sort

Can we optimize the Span to be a polynomial of $log(n)$?

```SML
(* Msort : tree -> tree
 * REQ: true
 * ENS: Msort T is a sorted tree containing the exact elements of T
 *)
(* See Lecture 7 for the concept of a sorted tree. *)
fun Msort (Empty : tree) : tree = Empty
  | Msort (Node(L, x, R)) = Ins(x, Merge (Msort L, Msort R))
```

How do we Merge then?

Consider merging trees `Node(L1, x, R1), Node(L2, y, R2)`.

Assuming `x <= y`, we want to figure out where `x` goes in the second tree, split the second tree into two parts, and recursively merge the first tree with the part where the root is less than or equal to `x`.

```SML
(* Merge : tree * tree -> tree
 * REQ: T1, T2 are sorted
 * ENS: Merge (T1, T2) is sorted and contains exactly the elements of T1 & T2
 *)
fun Merge (Empty : tree, T2 : tree) : tree = T2
  | Merge (T1, Empty) = T1
  | Merge (Node(L1, x, R1), T2) =
    let
      val (R_less, R_greater) = SplitAt(x, T2)
    in
      raise TODO
    end
```

What should go into `TODO`?

