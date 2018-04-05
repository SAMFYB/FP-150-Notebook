(* The GAME signature works for all this kind of games. *)
signature GAME =
sig
  datatype player = Minnie | Maxie
  datatype outcome = Winner of player | Draw
  datatype status = Over of outcome | In_play
  type state (* Game States, dependent on specific game *)
  type move  (* How do game states change and update *)

  datatype (* Estimator *) est = Definitely of outcome
                               | Guess of int (* How strong is the guess *)
  (* REQ : state instance should be In_play *)
  val estimator : state -> est
  val start : state

  (* REQ : move instance is a valid move *)
  val make_move : state * move -> state

  (* REQ : state instance is In_play
   * ENS : returns a non-empty Seq *)
  val moves : state -> move Seq.seq (* a sequence of all possible moves *)

  (* View : to see the key parts of an abstracted structure *)
  val status : state -> status
  val player : state -> player
end

(* Implementation of the game Nim *)
structure Nim : GAME = (* We could use opaque ascribtion. *)
struct
  (* datatype's exactly same as signature *)
  datatype player = Minnie | Maxie
  datatype outcome = Winner of player | Draw
  datatype status = Over of outcome | In_play

  datatype state = State of int * player
  (* Since we're using transparent ascribtion, this makes sure the user does not arbitrarily mutate the values. *)
  datatype move = Move of int

  (* same as signature *)
  datatype (* Estimator *) est = Definitely of outcome
                               | Guess of int (* How strong is the guess *)

  fun player (State (_, P)) = P
  fun status (State (0, P)) = Over (Winner P)
    | status _ = In_play

  val start = State (400, Maxie)

  (* A useful helper: flip players *)
  fun flip Maxie = Minnie
    | flip Minnie = Maxie

  fun make_move (State (n, P), Move k) =
    if (n > k orelse n = k) then State (n - k, flip P)
    else raise Fail "Illegal Move"

  fun moves (State (n, _)) = Seq.tabulate (fn x => Move (x + 1)) (Int.min (n, 3))

  fun estimator (State (n, P)) =
    if n mod 4 = 1 then Definitely (Winner (flip P))
                   else Definitely (Winner P)
end

(* Now we have a game, but we also need players. *)
signature PLAYER =
sig
  structure Game : GAME
  val next_move : Game.state -> Game.move
end

(* To create a player for a specific game, we need a functor! *)
functor HumanPlayer (G : GAME) : PLAYER =
struct
  structure Game = G
  fun next_move _ (* Ask the user for a move, check it's illegal, return it. *) =
    raise Fail "Unimplemented"
end

