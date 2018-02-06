# Lecture 7 Sorting

## Merge Sort Revisit

Optimal complexity for sequential computation: __Merge Sort__ (divide & conquer)

On parallel computation, merge sort speeds up a little on lists, and a lot on trees.

```
              [9, 7, 5, 3, 4]
              /             \
          [9, 5, 4]       [7, 3]
            /  \          /   \
        [9, 4]  [5]     [7]   [3]
          / \
        [9] [4]                 SPLIT
      -------------------------------
        [4, 9] + [5]            MERGE
               |
          [4, 5, 9] + [3, 7]
                    |
            [3, 4, 5, 7, 9]
```

> Note: It does not matter how to split as long as split evenly.

## Code on Merge Sort

```SML
(* msort : int list -> int list
 * REQ: true
 * ENS: msort L is a sorted permutation of L
 *)
(* Helpers
 * split : int list -> int list * int list
 * REQ: true
 * ENS: split L ===> (A, B) such that (A @ B) is a permutation of L
 *      such that |length A - length B| <= 1
 * merge : int list * int list -> int list
 * REQ: A & B are sorted
 * ENS: merge (A, B) is a sorted permutation of (A @ B)
 *)

fun msort ([] : int list) : int list = []
  | msort [x] = [x]
  | msort L =
    let
      val (A : int list, B : int list) = split L
    in
      merge (msort A, msort B)
    end

fun split ([] : int list) : int list * int list = ([], [])
  | split [x] = ([x], [])
  | split (x::y::xs) =
    let
      val (A, B) = split xs
    in
      (x::A, y::B)
    end

fun merge ([] : int list, B : int list) : int list = B
  | merge (A, []) = A
  | merge (x::xs, y::ys) =
    case Int.compare(x, y) of
      LESS => x::(merge (xs, y::ys))
    | GREATER => y::(merge (x::xs, ys))
    | EQUAL => x::y::(merge (xs, ys))
```

## Analyzing the Work

### The Work of the Helpers

```
fun split
  W(0) = c0
  W(1) = c1
  W(n) = c2 + W(n - 2)
       = c2 + c2 + W(n - 4)
       = c2 + c2 + c2 + W(n - 6)
       = c2 * (n / 2) + c1 or c0
```

Thus, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/2c876b6718d309e3aa75a46545fa5b68.svg?invert_in_darkmode" align=middle width=96.199455pt height=24.6576pt/>.

Similarly, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d967bda6f55835fd4989b0115a68b707.svg?invert_in_darkmode" align=middle width=109.508025pt height=24.6576pt/> where <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.867pt height=14.15535pt/> is the number of elements in the two lists.

> Note: The __span__ of the functions are also both <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/>. This is an intrinsic problem for lists. You have to walk through every elements of the list anyway.

### The Work of `msort`

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d13402fcd1d3f0835e632b802c1b2f1a.svg?invert_in_darkmode" align=middle width=108.716685pt height=16.438356pt/></p>
<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/ae0e8d112ba00b7ca61e9b65e3c7bb3e.svg?invert_in_darkmode" align=middle width=108.716685pt height=16.438356pt/></p>
<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/8baaae8dc0dad53efdc22dfb888f8357.svg?invert_in_darkmode" align=middle width=498.102pt height=17.03196pt/></p>

Further, <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/2e79fbda0d2a7e40a8eb761326ad0335.svg?invert_in_darkmode" align=middle width=162.333105pt height=24.6576pt/> is linear, and <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5c5e2ecd1fea6deca510e1e05d9b2a06.svg?invert_in_darkmode" align=middle width=73.80483pt height=22.85349pt/>.

Therefore,

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/2d5df64a419edb52467caae008dba3c8.svg?invert_in_darkmode" align=middle width=311.6916pt height=16.438356pt/></p>

We can consider the work with a tree analysis:

```
                      c4n
                      / \
               c4(n/2)  c4(n/2)
               /    \     /   \
          c4(n/4) c4(n/4) ...
```

At each level, the total work is exactly `c4n`, and there is `log n` levels.

Therefore, the total amount of work is `n log n`.

> The __span__ is the sum of the longest path along this tree, i.e.

<p align="center"><img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/90ab8386bfd5069668b62daf6225455e.svg?invert_in_darkmode" align=middle width=254.9844pt height=29.474115pt/></p>

## The Concept of "Sorted" in Trees

- `Empty` is sorted
- `Node(L, x, R)` is sorted iff
  - `L` is sorted & `y <= x` for all `y` in `L`
  - `R` is sorted & `z >= x` for all `z` in `R`

## Inserting into a Tree

```SML
(* Ins : int * tree -> tree
 * REQ: T is sorted
 * ENS: Ins (x, T) is a sorted tree consisting the elements of T & x
 *)
fun Ins (x : int, Empty : tree) : tree = Node(Empty, x, Empty)
  | Ins (x, Node(L, y, R)) =
    case Int.compare(x, y) of
      GREATER => Node(L, y, Ins(x, R))
    | _ => Node(Ins(x, L), y, R)
```

