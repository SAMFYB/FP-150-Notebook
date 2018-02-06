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

