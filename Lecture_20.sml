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
