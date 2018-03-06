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

__Theorem.__ $L$ is regular iff $L^C$ is regular.

- $L((a+1)(b+ba)^*)$ is the compliment of the last language above.

