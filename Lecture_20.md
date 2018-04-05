# Lecture 20 - Game Theory

## Modular Framework for the following kinds of Games

- 2-player (alternate turns)
- deterministic (no dice)
- perfect information (no hidden state)
- zero-sum (I win, you lose; ties OK)
- finitely-branching (maybe even finite)

## Game Trees

- __Nodes__ represent current "state of game"
- __Edges__ represent possible moves
- A given __level__ corresponds to a given player, alternating turns

## Estimators

In practice, trees are too large to visit all leaves.

Instead,
- expand tree to __some depth__
- use __game-specific estimator__ to assign values (not just `1` or `~1`) at bottom-most nodes explored

Then, backchain minimax as before.

Repeat this after each actual move.

__Issue:__ Horizontal Effect

## Modular Framework

- Game: `GAME`
- Player: `PLAYER`
- Referee: `GO`

