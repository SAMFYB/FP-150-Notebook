# Midterm 1 Review

## Work Analysis

```SML
(* Find : int * tree -> bool
 * REQ: true
 * ENS: Find (x, T) ===> true if x is in T | false otherwise
 *)
fun Find (x, Empty) = false
  | Find (x, Node(L, y, R)) =
    case (x = y) of
      true => true
    | false => let
                 val (b1, b2) = (Find (x, L), Find (x, R))
               in
                 b1 orelse b2
               end
```

> Note: This code is not optimized, but only for work/span analysis purpose.

### Work Analysis of the Above Function regarding Size

$$ \begin{align}
  W(0) &= k_0 \\
  W(n) &\leq k_1 + 2 W(\frac{n}{2}) \\
       &= \sum_{i=0}^{log(n)} 2^i k_i + c \cdot k_0 \\
       &= (2^{log(n)+1} - 1) \cdot k_1 + c \\
       \in O(n)
\end{align} $$

