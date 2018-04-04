# Recitation April 4 - Sequences

<!-- START doctoc -->
<!-- END doctoc -->

## List v. Sequences (Pros & Cons)

__Pros__:
- constant time access
- parallelism

__Cons__:
- no cons!
- take more memory
- no pattern matching

## Sequence Library

- Seq.tabulate
- Seq.map
- Seq.filter
- Seq.nth
- Seq.reduce

### Tabulate

```sml
Seq.tabulate : (int -> 'a) -> int -> 'a seq
(* < 0, 1, 2 > = *) Seq.tabulate (fn x => x) 3
```

### Reverse Sequence

```sml
fun rev S =
  Seq.tabulate (fn i => Seq.nth S (Seq.length - i - 1)) (Seq.length S)
```

### Eliminate Rows of Sequence of Sequences

```sml
fun elimRows (L : int Seq.seq Seq.seq) (k : int) =
  let
    val Smax = Seq.map (fn S => (Seq.reduce Int.max 0 S, S)) L
    val filtered = Seq.filter (fn (m, R) => m > k) Smax
    val remove = Seq.map (fn (m, R) => R) filtered
  in
    remove
  end

(* elimRows removes rows where there is NO element greater than k *)
```

## Work & Span Analysis of Sequence Library

| Function | Work | Span |
| -------- | ---- | ---- |
| tabulate | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> |
| map      | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> |
| filter   | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/85166763cc148ef36c2009f7eee4c50a.svg?invert_in_darkmode" align=middle width=70.05999pt height=24.6576pt/> |
| nth      | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> |
| reduce   | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1f08ccc9cd7309ba1e756c3d9345ad9f.svg?invert_in_darkmode" align=middle width=35.647755pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/85166763cc148ef36c2009f7eee4c50a.svg?invert_in_darkmode" align=middle width=70.05999pt height=24.6576pt/> |
| length   | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1e2f931ee6c0b8e7a51a7b0d123d514f.svg?invert_in_darkmode" align=middle width=34.000065pt height=24.6576pt/> |

