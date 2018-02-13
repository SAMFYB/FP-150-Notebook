# Lecture 9

<!-- START doctoc -->
<!-- END doctoc -->

## Review: What have we seen so far?

- (Monomorphic) Types
- Functions (incl. Lambdas)
- Recursion (incl. Tail)
- Datatypes
- Pattern Matching
- Work & Span
- Equivalence
- Totality
- Induction
- * Proof of Correctness

## Preview: Where are we heading?

- Polymorphism (Staring today)
- Higher Order Functions
- Modular Systems

## Polymorphism

__Question.__ How do we define a list type that can take any types of elements?

> We need a "__type variable__".

```SML
datatype 'a list = nil | :: of 'a * 'a list
(* The cons operator takes a 'a type and cons it to a 'a list. *)
infixr :: (* The normal definition of cons. *)
```

Consider the type of the following lists:

```SML
[1] : int list
[] : 'a list (* The most general type of this list. *)
1 :: [] (* The 'a is instantiated as int in this expression. *)
```

> Note: `int list` is an "__instance__" of `'a list`.

Consider: `[[]] : 'a list list`.

