# Recitation March 28 (Midterm 2 Review)

## Agenda

- Announcements
- Composition
- Associativity/Partial Application
- CPS

## Composition

```sml
op o : ('a -> 'b) * ('c -> 'a) -> ('c -> 'b)
(Int.toString) o (fn x => x + 1) : int -> string

(op o) o (op o) (* NOT type-check *)
```

## Associativity

`o` is right associative because of `infixr` definition.

```sml
f o g o h = f o (g o h)
```

In general, functions are left associative.

```sml
fun curry x y z = fn x => (fn y => (fn z => x + y + z))
```

__Note:__ Types are right associative.

