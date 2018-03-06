# Lecture 14 Regular Expressions

## Basic Concepts

- Languages
- Acceptor Machines
- Grammars
- Content Free
- Regular Languages
- Regular Expressions
- Finite Automata
- Nondeterministic Pushdown Automata

## Regular Expressions Definition

- "a" in the alphabet is a regular expression
- 0 is a regular expression
- 1 is a regular expression

- If `r1, r2` are regular expressions, so is `r1r2` (concatenation).
- If `r1, r2` are regular expressions, so is `r1 + r2` (alternation).
- If `r` is a regular expression, so is `r*` (Kleene Star).

## Languages Associated with Regular Expressions

| Regular Expression | Language |
| ------------------ | -------- |
| $a$ | $L(a) = \{a\}$ |
| $0$ | $L(0) = \{\}$ |
| $1$ | $L(1) = \{\epsilon\}$ |
| $r_1r_2$ | $\{s_1s_2 : s_1 \in L(r_1), s_2 \in L(r_2)\}$ |
| $r_1+r_2$ | $\{s : s \in L(r_1) or s \in L(r_2)\}$ |
| $r^*$ | $\{s_1s_2...s_n : n \in \mathbb{N}, n \geq 0, s_i \in L(r)\}$ |

### Some Examples

- $L(aa) = \{aa\}$
- $L(ab) = \{ab\}$

