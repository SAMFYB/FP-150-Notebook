# Recitation April 4 - Sequences

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

