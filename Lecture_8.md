# Lecture 8

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Revisit Insert in Trees](#revisit-insert-in-trees)
- [Revisit Merge Sort](#revisit-merge-sort)
  - [Merge Sort on Trees](#merge-sort-on-trees)
  - [Analyzing Merge Sort on Trees](#analyzing-merge-sort-on-trees)
  - [Summary of Merge Sort](#summary-of-merge-sort)
  - [A Peek into Rebalancing](#a-peek-into-rebalancing)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Revisit Insert in Trees

```SML
fun Ins(x, Empty) = Node(Empty, x, Empty)
  | Ins(x, Node(L, y, R)) =
    case Int.compare(x, y) of
      GREATER => Node(L, y, Ins(x, R))
    | _ => Node(Ins(x, L), y, R)
```

The Work and Span are both <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/>. Or in fact, it is also <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/740010a0c1bf39b159892c43824d4144.svg?invert_in_darkmode" align=middle width=34.33683pt height=24.6576pt/>. In the worst case, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5d27b4b70b753caa9e77537a78ef2617.svg?invert_in_darkmode" align=middle width=40.34052pt height=22.83138pt/>.

For balanced trees, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/f12b96a49c42534c2471e8d45ba49147.svg?invert_in_darkmode" align=middle width=100.53351pt height=24.6576pt/>.

## Revisit Merge Sort

Can we optimize the Span to be a polynomial of <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/a9fbace32ecc719928919305b91b2c32.svg?invert_in_darkmode" align=middle width=44.27907pt height=24.6576pt/>?

### Merge Sort on Trees

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

What should go into `TODO`? `Node(Merge(L1, R_less), x, Merge(R1, R_greater))`

> Note: We have to inductively prove `Merge` is correct. The logic: assuming the spec, use the spec for the induction proof. Basic stuff: you have to guarantee spec holds.

> Side Note: When you have a spec that sometimes fails (we will see this in future), we have to be very careful about when it holds and when it does not.

```SML
(* SplitAt : int * tree -> tree * tree *)
fun SplitAt (_ : int, Empty : tree) : tree * tree = (Empty, Empty)
  | SplitAt (x, Node(L, y, R)) =
    case Int.compare(x, y) of
      LESS => let
                val (T1, T2) = SplitAt(x, L)
              in
                (T1, Node(T2, y, R))
              end
    | _ => let
             val (T1, T2) = SplitAt(x, R)
           in
             (Node(L, y, T1), T2)
           end
```

> Micheal: Take 15 seconds to think about this. Make sure you understand this. I didn't say this is practice for the exam. :)

### Analyzing Merge Sort on Trees

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/63e90af8af5497b0e8c74943d790079e.svg?invert_in_darkmode" align=middle width=659.49015pt height=164.977065pt/></p>

Now what?

Assuming trees are __balanced__, so <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/a45b6389352fe6842a7ab7347c4e39d1.svg?invert_in_darkmode" align=middle width=100.53351pt height=24.6576pt/>, also assuming `Msort` returns balanced trees,

> Side Note: By the fact that we're stuck on the analysis now, it appears that we have not fully accomplished what we want with our current code.

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/68bf034989b2fcd100518b16a5806a01.svg?invert_in_darkmode" align=middle width=393.05145pt height=69.83031pt/></p>

### Summary of Merge Sort

|                       | Work | Span |
| --------------------- | ---- | ---- |
| Insertion Sort (list) | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/3987120c67ed5a9162aa9841b531c3a9.svg?invert_in_darkmode" align=middle width=43.022265pt height=26.76201pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/3987120c67ed5a9162aa9841b531c3a9.svg?invert_in_darkmode" align=middle width=43.022265pt height=26.76201pt/> |
| Merge Sort (list)     | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/743c00b1fa7d59c887892656948b54b8.svg?invert_in_darkmode" align=middle width=67.14147pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> |
| Merge Sort (tree)     | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/743c00b1fa7d59c887892656948b54b8.svg?invert_in_darkmode" align=middle width=67.14147pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/4043208c5a0e3737ed883304b0a8d55e.svg?invert_in_darkmode" align=middle width=77.4345pt height=26.76201pt/> |

### A Peek into Rebalancing

```SML
(* To make this fast, we re-define tree datatype. *)
datatype tree = Empty
              | Node of tree * int * int * tree
fun rebalance (Empty : tree) : tree = Empty
  | rebalance T =
    let
      val(L, x, R) = halves T
    in
      Node(rebalance L, x, rebalance R)
    end
```

The Work of rebalancing is <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/>, and the Span is <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/a0cc370b2cb245937aaf1a5438fc8368.svg?invert_in_darkmode" align=middle width=77.4345pt height=26.76201pt/>.

