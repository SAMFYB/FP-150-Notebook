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
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/44bc9d542a92714cac84e01cbbb7fd61.svg?invert_in_darkmode" align=middle width=8.68923pt height=14.15535pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/854d813ebdae89562ee01d30b6655ae6.svg?invert_in_darkmode" align=middle width=79.707045pt height=24.6576pt/> |
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/29632a9bf827ce0200454dd32fc3be82.svg?invert_in_darkmode" align=middle width=8.219277pt height=21.18732pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/98fc044df1426d8e13315667a5881624.svg?invert_in_darkmode" align=middle width=70.54806pt height=24.6576pt/> |
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/034d0a6be0424bffe9a6e7ac9236c0f5.svg?invert_in_darkmode" align=middle width=8.219277pt height=21.18732pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/ffa1dcb3d5e8791326183c21e8e3898d.svg?invert_in_darkmode" align=middle width=77.22033pt height=24.6576pt/> |
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1cfcd7b08c7374283591e89aa1b586a4.svg?invert_in_darkmode" align=middle width=28.759665pt height=14.15535pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/03f0a17af1386348f2c303f3d4d114b7.svg?invert_in_darkmode" align=middle width=215.471355pt height=24.6576pt/> |
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/4136997236d43514ad83bdc6fb7c69fb.svg?invert_in_darkmode" align=middle width=48.85089pt height=19.17828pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/fc5f9b5bae949ad55bc08fda8ecc233d.svg?invert_in_darkmode" align=middle width=186.804255pt height=24.6576pt/> |
| <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/1dda62b9f52197f613086bb104247584.svg?invert_in_darkmode" align=middle width=14.608275pt height=22.63866pt/> | <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/91ac033aec140743a973598439d09239.svg?invert_in_darkmode" align=middle width=252.210255pt height=24.6576pt/> |

### Some Examples

- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/de6bd4d6a30988d6261dddb7230350e2.svg?invert_in_darkmode" align=middle width=97.08534pt height=24.6576pt/>
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d248936ae552d4651a8432f49d666060.svg?invert_in_darkmode" align=middle width=93.81669pt height=24.6576pt/>
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/5f911e62f54114ef9d74e4d95d8ff4e2.svg?invert_in_darkmode" align=middle width=209.250855pt height=24.6576pt/>
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/91ecc8f33b8e22025a337b8ffd22ab20.svg?invert_in_darkmode" align=middle width=184.149405pt height=24.6576pt/>
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/48296ba258dfac2dfbe77b68ea7cf72f.svg?invert_in_darkmode" align=middle width=80.1504pt height=24.6576pt/> is the set of all strings formed from the alphabet
- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/d0bf28792b44d54bdcbe8976d80b956a.svg?invert_in_darkmode" align=middle width=153.70641pt height=24.6576pt/>

__Theorem.__ <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/ddcb483302ed36a59286424aa5e0be17.svg?invert_in_darkmode" align=middle width=11.18733pt height=22.46574pt/> is regular iff <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/c7f7272d102de6cd0afef7ad1317fdff.svg?invert_in_darkmode" align=middle width=21.421785pt height=27.65697pt/> is regular.

- <img src="https://rawgit.com/SAMFYB/FP-150-Notebook/master/svgs/acb989284deb3c822c0e503461de7a8e.svg?invert_in_darkmode" align=middle width=136.99026pt height=24.6576pt/> is the compliment of the last language above.

## Time to Write Some Code

```sml
datatype regexp = Char of char
                | Zero
                | One
                | Times of regexp * regexp
                | Plus of regexp * regexp
                | Star of regexp

(* accept : regexp -> string -> bool
 * req : true
 * ens : accept r s => true if s in L(r)
 *                     false otherwise
 *
 * (helper) match : regexp -> char list -> (char list -> bool) -> bool
 * req : k is total
 * ens : match r cs k => true if cs = p @ s s.t. p in L(r) & k s = true
 *                       false otherwise
 *)
fun accept r s = match r (String.explode s) List.null
fun match (Char a) cs k = case cs of
                            [] => false
                          | (c::cs') => (a = c) andalso (k cs')
  | match Zero cs k = false
  | match One cs k = k cs
  | match (Times (r1, r2)) cs k = match r1 cs (fn cs' => match r2 cs' k)
  | match (Plus (r1, r2)) cs k = (match r1 cs k) orelse (match r2 cs k)
  | match (Star r) cs k = (k cs) orelse (match r cs (fn cs' => match (Star k) cs' k))
```

__Issue.__ The last clause may not necessarily terminate considering `Star 1`.

Fixes
- Require a stronger spec
- Instantly check `cs' <> cs`

