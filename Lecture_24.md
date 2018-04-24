# Context-Free Grammar & Parsing

- Regular Languages -> Finite Automata
- Context-Free -> Finite Automata with a single Stack

## Context Free Grammar of ML

What is a program? An expression? A match? A pattern?

```
P ==> e | E; P
E ==> E + E | E andalso E | case E of M | fn M | ...
M ==> Q => E | Q => E \| M
Q ==> ...
```

It's called "context-free" because we can substitute anything with any instance of its extension.

More about grammar and parsing [here](https://github.com/SAMFYB/reading-notes-on-compiler).

Further reading: Elements of the Theory of Computation by Lewis and Papadimitriou.

