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

